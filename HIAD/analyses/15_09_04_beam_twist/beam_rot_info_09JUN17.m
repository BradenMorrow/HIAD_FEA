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
% L = 64.5; % (in)
% n = 30; % Number of elements

beam_nodes = linspace(0,L,n + 1)'; % Location of nodes, xyz (in)
[beam_nodes,I] = sort([beam_nodes; L/2 - a; L/2 + a]);

Di = zeros(length(I),6);
Di(:,2) = I == length(I) - 1 | I == length(I);
Di = Di';
Di = Di(:);

beam_nodes = [beam_nodes zeros(length(beam_nodes),2)];

N = size(beam_nodes,1); % Total nodes

%% Orientation
% beam_orientation = linspace(0,L,n + 1)';
% beam_orientation = [beam_orientation ones(size(beam_orientation)) zeros(size(beam_orientation))];
beam_orientation = beam_nodes;

rot_angle = 0; % 
rot = beam_nodes(:,1)/beam_nodes(end,1)*rot_angle*pi/180;


beam_orientation(:,2:3) = [cos(rot) sin(rot)];

%% Connectivities
% beam_connect = [(1:n)' (2:n + 1)'];
beam_connect = [(1:size(beam_nodes,1) - 1)' (2:size(beam_nodes,1))'];
type = 3*ones(size(beam_connect,1),1);
beam_connect = [beam_connect type];

%% Boundaries
% [ux uy uz rx ry rz]
DOF = 6; % DOF/node
analysis = 3; % 1 = linear, 2 = large displacement, linear, 3 = large displacement, nonlinear

% Boundaries
% 1 = fixed
% 0 = free
b_bound = zeros(size(beam_nodes,1),DOF);
% % % b_bound(1,[1 4]) = 1;
% % % b_bound(end,4) = 1;
b_bound(1,1) = 1;

beam_bound = b_bound';
beam_bound = beam_bound(:);

%% Loading
% For load control vector
force = -react/2; % Load (lb)

% Force DOF of interest (for plotting)
% a = 21.5; % 50; % 
% Di = round((L - a)/(L/n) + 1)*DOF - 4;

% beam_F = zeros((n + 1)*DOF,1);
% beam_F(Di) = force;
% beam_F = zeros(size(beam_nodes,1)*DOF,1);
% beam_F(Di) = force;
beam_F = Di*force;



%% Element type
% Preallocate element structure
EL(N - 1).el = [];
% % % EL(N - 1).el_in.nodes_ij = [];
% % % EL(N - 1).el_in.orient_ij = [];
% % % EL(N - 1).el_in.connect_ij = [];
EL(N - 1).el_in = [];
EL(N - 1).el_in0.mat = [];
EL(N - 1).el_in0.geom = [];
EL = EL';

% Roller support
E = 29000000;
A = pi*1^2*10;
I = pi*1^4/4*10;

% Define element functions
EL(1).el = @el2; % Linear, corotational beam

% % % % Element geometry
% % % EL(1).el_in.nodes_ij = [beam_nodes(beam_connect(1,1),:)
% % %     beam_nodes(beam_connect(1,2),:)];
% % % EL(1).el_in.orient_ij = [beam_orientation(beam_connect(1,1),:)
% % %     beam_orientation(beam_connect(1,2),:)];
% % % EL(1).el_in.connect_ij = beam_connect(1,1:2);

% Special element input
EL(1).el_in0.mat = [E .3]; % [E nu]
EL(1).el_in0.geom = [A I I 0 2*I]; % [A Izz Iyy ky J]
% % % EL(1).el_in0.L0 = sqrt((EL(1).el_in.nodes_ij(2,1) - EL(1).el_in.nodes_ij(1,1))^2 + ...
% % %         (EL(1).el_in.nodes_ij(2,2) - EL(1).el_in.nodes_ij(1,2))^2 + ...
% % %         (EL(1).el_in.nodes_ij(2,3) - EL(1).el_in.nodes_ij(1,3))^2);




% Inflatable beam
% Configuration
p = p_i; % Internal pressure
r = r_i; % Shell (minor) radius
alpha = alpha_i; % Location of cords on shell cross section 

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

% Number of integration points (3 to 10)
Nint = 3;
% rot_angle = .34;
% rot_angle_i = .34/(size(beam_nodes,1) - 1)/Nint;
% 
% alpha_i = alpha - rot_angle_i;

% Loop through elements and load relevant data
for i = 1:N - 1
% % %     % Define element functions
% % %     EL(i).el = 'el3'; % Pneumatic, corotational beam
% % %     
% % %     % Element geometry
% % %     EL(i).el_in.nodes_ij = [beam_nodes(beam_connect(i,1),:)
% % %         beam_nodes(beam_connect(i,2),:)];
% % %     EL(i).el_in.orient_ij = [beam_orientation(beam_connect(i,1),:)
% % %         beam_orientation(beam_connect(i,2),:)];
% % %     EL(i).el_in.connect_ij = beam_connect(i,1:2);
% % %     
% % %     EL(i).el_in = [];
% % %     
% % %     % Special element input
% % %     EL(i).el_in0.p = p;
% % %     EL(i).el_in0.r = r;
% % %     EL(i).el_in0.alpha = zeros(size(alpha,1),Nint);
% % %     EL(i).el_in0.beta = beta;
% % %     
% % %     EL(i).el_in0.eps = eps0*ones(size(alpha,1),2);
% % %     EL(i).el_in0.f = Fc*ones(size(alpha,1),2);
% % %     EL(i).el_in0.Fc = Fc;
% % %     
% % %     % Cord input
% % %     for j = 1:Nint % Loop through integration points
% % %         for k = 1:length(alpha) % Loop through each cord
% % %             EL(i).el_in0.nodes(j).cords(k).axial = d;
% % %             EL(i).el_in0.nodes(j).cords(k).load_point = load_point;
% % %             EL(i).el_in0.nodes(j).cords(k).unload_point = unload_point;
% % %             EL(i).el_in0.nodes(j).cords(k).eps_rate = 1;
% % %         end
% % %         
% % % %         alpha_i = alpha_i + rot_angle_i;
% % % %         EL(i).el_in0.alpha(:,j) = alpha_i;
% % %         EL(i).el_in0.alpha(:,j) = alpha;
% % %     end
% % %     
% % %     EL(i).el_in0.propsLH = [ELong EHoop GLH nuHL t]'; % Shell properties
% % %     EL(i).el_in0.EI = [0 0 0]; % Tangent EI
% % %     EL(i).el_in0.y_bar = [0 0]'; % Location of NA
% % %     
% % %     EL(i).el_in0.D0 = [0 0 0 0 0 0]';
% % %     EL(i).el_in0.P0 = [0 0 0 0 0 0]';
% % %     
% % %     EL(i).el_in0.PV_work = 0; %[0 0]';
% % %     
% % %     EL(i).el_in0.PV_work = 0; %[0 0]';
% % %     EL(i).el_in0.n = Nint;
% % %     EL(i).el_in0.break = 0;
% % %     
% % %     % Initialize stored variables for fiber model
% % %     EL(i).el_in0.flex.K = zeros(5); % Section forces
% % %     EL(i).el_in0.flex.D = zeros(5,Nint); % zeros(3,Nint); % Section forces
% % %     EL(i).el_in0.flex.Du = zeros(5,Nint); % Unbalanced section forces
% % %     EL(i).el_in0.flex.Q = zeros(5,1); % Element forces
% % %     EL(i).el_in0.flex.f = zeros(5,5,Nint); % zeros(3,3,Nint); % Section compliance matrices
% % %     EL(i).el_in0.flex.d = zeros(5,Nint); % zeros(3,Nint); % Section deformations
% % %     EL(i).el_in0.flex.e = zeros(size(alpha,1),Nint) + eps0; % Section fiber strains
% % %     
% % %     % Iterative or non-iterative state determination procedure
% % %     EL(i).el_in0.state_it = false;

        EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
        
        % Define element functions
        EL(i).el = 'el3'; % Pneumatic, corotational beam
        
        % Special element input
        EL(i).el_in0.break = 0;
        EL(i).el_in0.K0 = zeros(6,6);
        EL(i).el_in0.p = p;
        EL(i).el_in0.r = r;
        EL(i).el_in0.alpha = zeros(size(alpha,1),Nint);
        EL(i).el_in0.beta = beta;
        
        EL(i).el_in0.eps = eps0*ones(size(alpha,1),2);
        EL(i).el_in0.f = Fc*ones(size(alpha,1),2);
        
        % Cord input
        for g = 1:Nint % Loop through integration points
            for k = 1:length(alpha) % Loop through each cord
                EL(i).el_in0.nodes(g).cords(k).axial = d;
            end
            
            EL(i).el_in0.alpha(:,g) = alpha;
        end
        
        EL(i).el_in0.propsLH = [ELong 0 GLH 0 1]'; % [ELong EHoop GLH nuHL 1]'; % Shell properties
        
        EL(i).el_in0.D0 = [0 0 0 0 0 0]';
        EL(i).el_in0.P0 = [0 0 0 0 0 0]';
        
        EL(i).el_in0.n = Nint;
        
        % Initialize stored variables for fiber model
        EL(i).el_in0.flex.break = 0;
        EL(i).el_in0.flex.K = zeros(5); % Element stiffness
        EL(i).el_in0.flex.D = zeros(5,Nint); % Section forces
        EL(i).el_in0.flex.Du = zeros(5,Nint); % Unbalanced section forces
        EL(i).el_in0.flex.Q = zeros(5,1); % Element forces
        EL(i).el_in0.flex.f = zeros(5,5,Nint); % Section compliance matrices
        EL(i).el_in0.flex.d = zeros(5,Nint); % Section deformations
        EL(i).el_in0.flex.e = zeros(size(alpha,1),Nint) + eps0; % Section fiber strains
        
        % Iterative or non-iterative state determination procedure
        EL(i).el_in0.state_it = false;
end




% Supports
s_nodes = [0 -14 0
    L -14 0];

s_orientation = [-1 -14 0
    L + 1 -14 0];

s_connect = [N + 1 1 2
    N + 2 N 2];

s_bound = [[0 1 1 1 0 0]'
    [0 1 1 0 0 0]'];


% % % b_bound(1,[1 4]) = 1;
% % % b_bound(end,4) = 1;



s_F = zeros(12,1);

Di = [Di; zeros(12,1)];

s_ind = [N N + 1]';



EL(s_ind(1)).el = 'el2';
EL(s_ind(2)).el = 'el2';

% % % EL(s_ind(1)).el_in.nodes_ij = [s_nodes(1,:)
% % %     beam_nodes(s_connect(1,2),:)];
% % % EL(s_ind(2)).el_in.nodes_ij = [s_nodes(2,:)
% % %     beam_nodes(s_connect(2,2),:)];
% % % 
% % % EL(s_ind(1)).el_in.orient_ij = [s_orientation(1,:)
% % %     beam_orientation(s_connect(1,2),:)];
% % % EL(s_ind(2)).el_in.orient_ij = [s_orientation(2,:)
% % %     beam_orientation(s_connect(2,2),:)];
% % % 
% % % EL(s_ind(1)).el_in.connect_ij = s_connect(1,1:2);
% % % EL(s_ind(2)).el_in.connect_ij = s_connect(2,1:2);

EL(s_ind(1)).el_in = [];
EL(s_ind(2)).el_in = [];

% % % EL(s_ind(1)).el_in0.mat = [29000000 .3];
% % % EL(s_ind(2)).el_in0.mat = [29000000 .3];
% % % 
% % % EL(s_ind(1)).el_in0.geom = [pi*rs^2 pi*rs^4/4 pi*rs^4/4 2 2*pi*rs^4/4];
% % % EL(s_ind(2)).el_in0.geom = [pi*rs^2 pi*rs^4/4 pi*rs^4/4 2 2*pi*rs^4/4];
% % % 
% % % EL(s_ind(1)).el_in0.L = 14;
% % % EL(s_ind(2)).el_in0.L = 14;
% % % 
% % % 
% % % EL(s_ind(1)).el_in0.break = 0;
% % % EL(s_ind(2)).el_in0.break = 0;

rs = 2;


for i = 1:2
    EL(s_ind(i)).el_in0.break = 0;
    EL(s_ind(i)).el_in0.mat = [29000000 .3];
    EL(s_ind(i)).el_in0.geom = [pi*rs^2 pi*rs^4/4 pi*rs^4/4 2 2*pi*rs^4/4];
    EL(s_ind(i)).el_in0.axial = spline([1 2 3],[1 2 3]);
    EL(s_ind(i)).el_in0.axial_k = spline([1 2 3],[1 2 3]);
    EL(s_ind(i)).el_in0.eps0 = 0;
    EL(s_ind(i)).el_in0.K0 = zeros(6);
    EL(s_ind(i)).el_in0.p = 0;
    EL(s_ind(i)).el_in0.r = 0;
    EL(s_ind(i)).el_in0.alpha = zeros(2,3);
    EL(s_ind(i)).el_in0.beta = 0;
    EL(s_ind(i)).el_in0.eps = zeros(5,2);
    EL(s_ind(i)).el_in0.f = zeros(5,2);
    EL(s_ind(i)).el_in0.nodes.cords.axial = zeros(10,2);
    EL(s_ind(i)).el_in0.propsLH = [0 0 0 0 1]';
    EL(s_ind(i)).el_in0.D0 = [0 0 0 0 0 0]';
    EL(s_ind(i)).el_in0.P0 = [0 0 0 0 0 0]';
    EL(s_ind(i)).el_in0.n = 0;
    EL(s_ind(i)).el_in0.flex.break = 0;
    EL(s_ind(i)).el_in0.flex.K = zeros(5);
    EL(s_ind(i)).el_in0.flex.D = [0 0 0 0 0]';
    EL(s_ind(i)).el_in0.flex.Du = [0 0 0 0 0]';
    EL(s_ind(i)).el_in0.flex.Q = [0 0 0 0 0]';
    EL(s_ind(i)).el_in0.flex.f = zeros(5);
    EL(s_ind(i)).el_in0.flex.d = [0 0 0 0 0]';
    EL(s_ind(i)).el_in0.flex.e = [0 0 0; 0 0 0];
    EL(s_ind(i)).el_in0.state_it = false;

    
end





