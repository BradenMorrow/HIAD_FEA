% Pre-process the torus object
% Andy Young
% December 31, 2014
%
% Preprocess the:
%   Location of nodes
%   Element connectivities
%   Element orientations
%   Boundary conditions
%   Force vector


%% Nodes
beam_nodes = linspace(0,L,n + 1)'; % Location of nodes, xyz (in)
Di = size(beam_nodes,1)*6 - nDOF;

beam_nodes = [beam_nodes zeros(length(beam_nodes),2)];
N = size(beam_nodes,1); % Total nodes

%% Orientation
beam_orientation = beam_nodes;
beam_orientation(:,2) = beam_orientation(:,2) + 1;

%% Connectivities
beam_connect = [(1:size(beam_nodes,1) - 1)' (2:size(beam_nodes,1))'];

type = 3*ones(size(beam_connect,1),1);
beam_connect = [beam_connect type];
% % % beam_connect(1,3) = 2;

%% Boundaries
% [ux uy uz rx ry rz]
% 1 = fixed
% 0 = free
b_bound = zeros(size(beam_nodes,1),6);
b_bound(1,[1 2 3 4]) = 1;
b_bound(end,[2 3]) = 1;

beam_bound = b_bound';
beam_bound = beam_bound(:);

%% Loading
% For load control vector
beam_F = zeros(size(beam_nodes,1)*6,1);
beam_F(Di) = react; % Load (lb)

%% Elements
% Preallocate element structure
EL(N - 1).el = [];
EL(N - 1).el_in.nodes_ij = [];
EL(N - 1).el_in.orient_ij = [];
EL = EL';

% Roller support
E = 29000000;
A = pi*1^2*10;
I = pi*1^4/4*10;

EL(1).el_in0 = instantiate_EL; % Instatiate all element variables

% Define element functions
EL(1).el = 'el2'; % Linear, corotational beam

% Element geometry
EL(1).el_in.nodes_ij = [beam_nodes(beam_connect(1,1),:)
    beam_nodes(beam_connect(1,2),:)];
EL(1).el_in.orient_ij = [beam_orientation(beam_connect(1,1),:)
    beam_orientation(beam_connect(1,2),:)];

% Special element input
EL(1).el_in0.break = 0;
% EL(1).el_in0.mat = [E .3]; % [E nu]
% EL(1).el_in0.geom = [A I I 0 2*I]; % [A Izz Iyy ky J]


% Inflatable beam
% Configuration
p = p_i; % Internal pressure
r = r_i; % Shell (minor) radius
if nDOF == 0
    alpha = [60 180 300]'; % Location of cords on shell cross section
elseif nDOF == 1;
    alpha = [90 210 330]';
end

% Material preprocessor
beta = beta_i; % Braid angle
props12 = props12_i; % Shell properties
propsB = [54.8 19]'; % Bladder properties [E nu]' (lb/in)
propsB(3) = propsB(1)/(2*propsB(2)) - 1; % Bladder Poisson ratio

t = .1/3; % Lamina thickness

% Fiber (lamina) properties
E1 = props12(1)/t; % psi
E2 = props12(2)/t;
G12 = props12(3)/t;
nu12 = props12(4);

% Bladder properties
E_b = propsB(1)/t; % psi
G_b = propsB(2)/t;
nu_b = propsB(3);

[A,~] = get_A([E1 E1 E_b]', [E2 E2 E_b]', [nu12 nu12 nu_b]', [G12 G12 G_b]', [beta -beta 0]', [t t t]');

% Laminate properties
ELong = (A(1,1) - A(1,2)^2/A(2,2))/(3*t); % *4; % psi
EHoop = (A(2,2) - A(1,2)^2/A(1,1))/(3*t); % psi
GLH = A(3,3)/(3*t); % psi
nuHL = A(1,2)/A(1,1);


% Cord force/strain lookup table
axial_table = axial_table_i;
d = load(axial_table);

Fc = p*pi*r^2/length(alpha)*(1 - 2*cot(beta*pi/180)^2); % Force in one cord after inflation (lb)
eps0 = interp1(d(:,1),d(:,2),Fc); % Initial cord strain

load_point = [0 0];
unload_point = [0 0];

% Number of integration points (3, 4 or 5 currently)
Nint = 6;

% Loop through elements and load relevant data
for i = 1:N - 1
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el3'; % Pneumatic, corotational beam
    
    % Special element input
    EL(i).el_in0.break = 0;
    EL(i).el_in0.K0 = zeros(6,6);
    EL(i).el_in0.p = p;
    EL(i).el_in0.r = r;
    EL(i).el_in0.alpha = alpha;
    EL(i).el_in0.beta = beta;
    
    EL(i).el_in0.eps = eps0*ones(size(alpha,1),2);
    EL(i).el_in0.f = Fc*ones(size(alpha,1),2);
    
    % Cord input
    for j = 1:Nint % Loop through integration points
        for k = 1:length(alpha) % Loop through each cord
            EL(i).el_in0.nodes(j).cords(k).axial = d;
        end
        
        EL(i).el_in0.alpha(:,j) = alpha;
    end
    
    EL(i).el_in0.propsLH = [ELong EHoop GLH nuHL t]'; % Shell properties
    
    EL(i).el_in0.D0 = [0 0 0 0 0 0]';
    EL(i).el_in0.P0 = [0 0 0 0 0 0]';
    
    EL(i).el_in0.K0 = zeros(6);
    
    EL(i).el_in0.n = Nint;
    
    % Initialize stored variables for fiber model
    EL(i).el_in0.flex.break = 0;
    EL(i).el_in0.flex.K = zeros(5); % Section forces
    EL(i).el_in0.flex.D = zeros(5,Nint); % Section forces
    EL(i).el_in0.flex.Du = zeros(5,Nint); % Unbalanced section forces
    EL(i).el_in0.flex.Q = zeros(5,1); % Element forces
    EL(i).el_in0.flex.f = zeros(5,5,Nint); % Section compliance matrices
    EL(i).el_in0.flex.d = zeros(5,Nint); % Section deformations
    EL(i).el_in0.flex.e = zeros(size(alpha,1),Nint) + eps0; % Section fiber strains
    
    % Iterative or non-iterative state determination procedure
    EL(i).el_in0.state_it = false;
end