function [MODEL,EL] = torus(theta,I_theta_cable,tor)
% Generate properties and geometry for torus

%% GENERAL
r = tor.r; % Minor radius (in)
p = tor.p; % Inflation pressure (psi)
beta = tor.beta; % Braid angle (deg)
alpha = tor.alpha; % Cord locations (deg from vertical)
ELong1 = tor.ELong; % Measured zylon longitudinal stiffness (lb/in)
GLH = tor.GLH; % Measured zylon inplane shear stiffness (lb/in)
Nint = tor.Nint; % Number of integration points (3 to 10)

%% NODES
nodes = tor.nodes;


%% ORIENTATION
orientation = nodes;
orientation(:,3) = orientation(:,3) + 100;


%% CONNECTIVITIES
connect = [(1:size(theta,1) - 1)' (2:size(theta,1))'];
connect = [connect; size(theta,1) 1];
connect = [connect 3*ones(size(connect,1),1)];


%% BOUNDARIES
b = [zeros(size(nodes,1),3) zeros(size(nodes,1),3)];
b(I_theta_cable,1:3) = 1;
b = b';
bound = b(:);


%% LOADING
f = zeros(size(nodes,1),6);
f = f';
F = f(:);


%% MODEL
MODEL.nodes = nodes;
MODEL.orientation = orientation;
MODEL.connect = connect;
MODEL.B = bound;
MODEL.F = F;


%% ELEMENTS
% Preallocate element structure
EL(size(connect,1)).el = [];
EL(size(connect,1)).el_in.nodes_ij = [];
EL(size(connect,1)).el_in.orient_ij = [];
EL(size(connect,1)).el_in.connect_ij = [];
EL(size(connect,1)).el_in0.mat = [];
EL(size(connect,1)).el_in0.geom = [];
EL = EL';

% Inflatable specific
% Shell
[ELong] = get_beam_EL(beta,p,r,ELong1); % Gross axial stiffness

% Cord force/strain lookup table
axial_table = 'axial_T4_20psi'; % 'C_axial_table_0'; % 
d = load(axial_table);
d(:,1) = d(:,1);

Fc = p*pi*r^2/length(alpha)*(1 - 2*cotd(beta)^2); % Force in one cord after inflation (lb)
eps0 = interp1(d(:,1),d(:,2),Fc); % Initial cord strain

load_point = [0 0]; % For hysteretic cord model
unload_point = [0 0];

% Loop through elements and load relevant data
for i = 1:size(connect,1)
    % Define element functions
    EL(i).el = @el3; % Pneumatic, corotational beam
    
    % Element geometry
    EL(i).el_in.connect_ij = connect(i,1:2);
    
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
    
    EL(i).el_in0.propsLH = [ELong 0 GLH 0 1]'; % [ELong EHoop GLH nuHL 1]'; % Shell properties
    
    EL(i).el_in0.D0 = [0 0 0 0 0 0]';
    EL(i).el_in0.P0 = [0 0 0 0 0 0]';
    
    EL(i).el_in0.n = Nint;
    
    % Initialize stored variables for fiber model
    EL(i).el_in0.flex.K = zeros(5); % Element stiffness
    EL(i).el_in0.flex.D = zeros(5,Nint); % Section forces
    EL(i).el_in0.flex.Du = zeros(5,Nint); % Unbalanced section forces
    EL(i).el_in0.flex.Q = zeros(5,1); % Element forces
    EL(i).el_in0.flex.f = zeros(5,5,Nint); % Section compliance matrices
    EL(i).el_in0.flex.d = zeros(5,Nint); % Section deformations
    EL(i).el_in0.flex.e = zeros(size(alpha,1),Nint) + eps0; % Section fiber strains
    
    % Iterative or non-iterative state determination procedure
    EL(i).el_in0.state_it = 0;
end



end

