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
% 
% Expanding to include geometric imperfections.  Must still include twist
% perturbations.

%% Nodes
beam_nodes = linspace(0,L,n + 1)'; % Location of nodes, xyz (in)
[beam_nodes,I] = sort([beam_nodes; L - a]);
[~,I] = max(I);
Di = I*6 - 4;

beam_nodes = [beam_nodes zeros(length(beam_nodes),2)];
N = size(beam_nodes,1); % Total nodes

%% Rollers
beam_nodes = [0 -14 0
    beam_nodes];
Di = Di + 6;
N = N + 1;

%% Orientation
beam_orientation = beam_nodes;
beam_orientation(:,2) = beam_orientation(:,2) + 1;
beam_orientation(1,:) = [-1 -14 0];

%% Connectivities
beam_connect = [(1:size(beam_nodes,1) - 1)' (2:size(beam_nodes,1))'];

type = 3*ones(size(beam_connect,1),1);
beam_connect = [beam_connect type];
beam_connect(1,3) = 2;

%% Boundaries
% [ux uy uz rx ry rz]
% 1 = fixed
% 0 = free
b_bound = zeros(size(beam_nodes,1),6);
b_bound(1,2:4) = 1;
b_bound(end,[1 5 6]) = 1;

% b_bound(:,[3 4 5]) = 1;

beam_bound = b_bound';
beam_bound = beam_bound(:);

%% Loading
% For load control vector
beam_F = zeros(size(beam_nodes,1)*6,1);
beam_F(Di) = -react/2; % Load (lb)



%% Elements
% Preallocate element structure
EL(N - 1).el = [];
EL(N - 1).el_in.nodes_ij = [];
EL(N - 1).el_in.orient_ij = [];
EL(N - 1).el_in.connect_ij = [];
EL(N - 1).el_in0.mat = [];
EL(N - 1).el_in0.geom = [];
EL = EL';

% Roller support
E = 29000000;
A = pi*1^2*10;
I = pi*1^4/4*10;

% Define element functions
EL(1).el = @el2; % Linear, corotational beam

% Element geometry
EL(1).el_in.nodes_ij = [beam_nodes(beam_connect(1,1),:)
    beam_nodes(beam_connect(1,2),:)];
EL(1).el_in.orient_ij = [beam_orientation(beam_connect(1,1),:)
    beam_orientation(beam_connect(1,2),:)];
EL(1).el_in.connect_ij = beam_connect(1,1:2);

% Special element input
EL(1).el_in0.mat = [E .3]; % [E nu]
EL(1).el_in0.geom = [A I I 0 2*I]; % [A Izz Iyy ky J]
EL(1).el_in0.L0 = sqrt((EL(1).el_in.nodes_ij(2,1) - EL(1).el_in.nodes_ij(1,1))^2 + ...
        (EL(1).el_in.nodes_ij(2,2) - EL(1).el_in.nodes_ij(1,2))^2 + ...
        (EL(1).el_in.nodes_ij(2,3) - EL(1).el_in.nodes_ij(1,3))^2);




% Inflatable beam
% Configuration
p = p_i; % Internal pressure
r = r_i; % Shell (minor) radius
alpha = alpha_i; % Location of cords on shell cross section 
% alpha = 180;

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
ELong1 = (A(1,1) - A(1,2)^2/A(2,2))/(3*t); % psi
ELong = ELong1*E_fac_i;

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

% Number of integration points (3 to 10)
Nint = 10;


% Loop through elements and load relevant data
for i = 2:N - 1
    % Define element functions
    EL(i).el = @el3; % Pneumatic, corotational beam
    
    % Element geometry
    EL(i).el_in.nodes_ij = [beam_nodes(beam_connect(i,1),:)
        beam_nodes(beam_connect(i,2),:)];
    EL(i).el_in.orient_ij = [beam_orientation(beam_connect(i,1),:)
        beam_orientation(beam_connect(i,2),:)];
    EL(i).el_in.connect_ij = beam_connect(i,1:2);
    
    % Special element input
    EL(i).el_in0.p = p;
    EL(i).el_in0.r = r;
    EL(i).el_in0.alpha = zeros(size(alpha,1),Nint);
    EL(i).el_in0.beta = beta;
    
    EL(i).el_in0.eps = eps0*ones(size(alpha,1),2);
    EL(i).el_in0.f = Fc*ones(size(alpha,1),2);
    EL(i).el_in0.Fc = Fc;
    
    % Cord input
    for j = 1:Nint % Loop through integration points
        for k = 1:length(alpha) % Loop through each cord
            EL(i).el_in0.nodes(j).cords(k).axial = d;
            EL(i).el_in0.nodes(j).cords(k).load_point = load_point;
            EL(i).el_in0.nodes(j).cords(k).unload_point = unload_point;
            EL(i).el_in0.nodes(j).cords(k).eps_rate = 1;
        end
        
        EL(i).el_in0.alpha(:,j) = alpha;
    end
    
    EL(i).el_in0.propsLH = [ELong EHoop GLH nuHL t]'; % Shell properties
    EL(i).el_in0.EI = [0 0 0]; % Tangent EI
    EL(i).el_in0.y_bar = [0 0]'; % Location of NA
    
    EL(i).el_in0.D0 = [0 0 0 0 0 0]';
    EL(i).el_in0.P0 = [0 0 0 0 0 0]';
    
    EL(i).el_in0.PV_work = 0; % [0 0]';
    EL(i).el_in0.n = Nint;
    
    % Initialize stored variables for fiber model
    EL(i).el_in0.flex.K = zeros(5); % Section forces
    EL(i).el_in0.flex.D = zeros(5,Nint); % zeros(3,Nint); % Section forces
    EL(i).el_in0.flex.Du = zeros(5,Nint); % Unbalanced section forces
    EL(i).el_in0.flex.Q = zeros(5,1); % Element forces
    EL(i).el_in0.flex.f = zeros(5,5,Nint); % zeros(3,3,Nint); % Section compliance matrices
    EL(i).el_in0.flex.d = zeros(5,Nint); % zeros(3,Nint); % Section deformations
    EL(i).el_in0.flex.e = zeros(size(alpha,1),Nint) + eps0; % Section fiber strains
    
    
% % %     EL(i).el_in0.flex.d_ax = zeros(1,Nint); % zeros(3,Nint); % Section deformations    
% % %     EL(i).el_in0.flex.eps_kappa = zeros(1,Nint); % zeros(3,Nint); % Section deformations    
% % %     EL(i).el_in0.flex.eps_kappa0 = zeros(1,Nint); % zeros(3,Nint); % Section deformations   

    % Iterative or non-iterative state determination procedure
    EL(i).el_in0.state_it = false;

end

% p = p_i;