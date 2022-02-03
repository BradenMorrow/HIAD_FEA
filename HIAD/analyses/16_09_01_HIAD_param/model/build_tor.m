function [FEM,theta] = build_tor(C,tor,straps,load)
%% Create the torii FE model


%% THETA
% Theta tolerance
tol = 1e-12;

% Find the number of nodes - every torus has an equal number of nodes
min_nodes = 0; % Minimum number of torus nodes

theta_tor = linspace(0,2*pi,min_nodes)';
if size(theta_tor,1) > 1
    theta_tor(end) = [];
end

% Preallocate strap node positions
theta0(size(straps,1),1).theta1 = [];
theta0(size(straps,1),1).theta2 = [];

% Loop through straps
for i = 1:size(straps,1)
    % First strap node
    theta0(i).theta1 = linspace(straps(i).theta0,straps(i).theta0 + 2*pi,straps(i).num_straps + 1)';
    theta0(i).theta1(end) = [];
    
    % Second strap node
    theta0(i).theta2 = linspace(straps(i).theta0 + straps(i).theta_sweep,straps(i).theta0 + straps(i).theta_sweep + 2*pi,straps(i).num_straps + 1)';
    theta0(i).theta2(end) = [];
end

% Combine theta locations
theta0_1 = [theta0.theta1]';
theta0_1 = theta0_1(:);
theta0_2 = [theta0.theta2]';
theta0_2 = theta0_2(:);
theta1 = [theta_tor; theta0_1; theta0_2];
theta1(theta1 >= 2*pi) = theta1(theta1 >= 2*pi) - 2*pi;
theta1(theta1 < 0) = theta1(theta1 < 0) + 2*pi;

% Sort theta vector
theta = unique(theta1);

% Enforce tolerance
theta2 = round(theta/tol)*tol;
theta = unique(theta2);

%% Preallocate and declare variables
C(1,:) = []; % Remove tieback

FEM.EL = [];
FEM.MODEL.nodes = [];
FEM.MODEL.orientation = [];
FEM.MODEL.connect = [];
FEM.MODEL.B = [];
FEM.MODEL.F = [];

EL(size(theta,1),1).el = [];
% EL(size(theta,1),1).el_in.nodes_ij = [];
% EL(size(theta,1),1).el_in.orient_ij = [];
EL(size(theta,1),1).el_in = [];
EL(size(theta,1),1).el_in0.mat = [];
EL(size(theta,1),1).el_in0.geom = [];


%% Create torus models
for i = 1:size(C,1)
    %% Nodes
    % % % Must modify code here to have anything other than a perfect
    % % %  circle.  For example, user could input initial shape 
    % % %  perturbations or non circular members
    x = C(i,1)*cos(theta);
    y = C(i,1)*sin(theta);
    z = C(i,2)*ones(size(theta));
    nodes = [x y z];
    
    
    %% ORIENTATION
    orientation = nodes;
    orientation(:,3) = orientation(:,3) + 100;
    
    
    %% CONNECTIVITIES
    N = size(theta,1)*(i - 1);
    connect_i = [(1:size(theta,1))' (2:size(theta,1) + 1)']; % Tori loop
    connect_i(end,2) = 1;
    connect_i = connect_i + N;
    connect = [connect_i 3*ones(size(connect_i,1),1)];
    
    
    %% BOUNDARIES
    b = zeros(size(nodes,1),6);
    b = b';
    bound = b(:);
    
    
    %% LOADING
    % % % Must modify code here in order to use a pressure distribution
    % % %  other than a constant pressure load.  For example, pressure
    % % %  distribution on a torus could be a Fourier summation or include 
    % % %  point loads
    F = press_dist(load(i,:),theta,C(i,1)); % Linear symetrical pressure distribution
    
    
    
    % Loop through elements
    for j = 1:size(connect,1)
        EL(j).el_in0 = instantiate_EL; % Instatiate all element variables
        
        % Define element functions
        EL(j).el = 'el3'; % Pneumatic, corotational beam
        
        % Special element input
        EL(j).el_in0.break = 0;
        EL(j).el_in0.K0 = zeros(6,6);
        EL(j).el_in0.p = tor(i).p;
        EL(j).el_in0.r = tor(i).r;
        EL(j).el_in0.alpha = zeros(size(tor(i).alpha,1),tor(i).Nint);
        EL(j).el_in0.beta = tor(i).beta;
        
        EL(j).el_in0.eps = tor(i).eps0*ones(size(tor(i).alpha,1),2);
        EL(j).el_in0.f = tor(i).Fc*ones(size(tor(i).alpha,1),2);
        
        % Cord input
        for g = 1:tor(i).Nint % Loop through integration points
            for k = 1:length(tor(i).alpha) % Loop through each cord
                EL(j).el_in0.nodes(g).cords(k).axial = tor(i).d;
            end
            
            EL(j).el_in0.alpha(:,g) = tor(i).alpha;
        end
        
        EL(j).el_in0.propsLH = [tor(i).ELong 0 tor(i).GLH 0 1]'; % [ELong EHoop GLH nuHL 1]'; % Shell properties
        
        EL(j).el_in0.D0 = [0 0 0 0 0 0]';
        EL(j).el_in0.P0 = [0 0 0 0 0 0]';
        
        EL(j).el_in0.n = tor(i).Nint;
        
        % Initialize stored variables for fiber model
        EL(j).el_in0.flex.break = 0;
        EL(j).el_in0.flex.K = zeros(5); % Element stiffness
        EL(j).el_in0.flex.D = zeros(5,tor(i).Nint); % Section forces
        EL(j).el_in0.flex.Du = zeros(5,tor(i).Nint); % Unbalanced section forces
        EL(j).el_in0.flex.Q = zeros(5,1); % Element forces
        EL(j).el_in0.flex.f = zeros(5,5,tor(i).Nint); % Section compliance matrices
        EL(j).el_in0.flex.d = zeros(5,tor(i).Nint); % Section deformations
        EL(j).el_in0.flex.e = zeros(size(tor(i).alpha,1),tor(i).Nint) + tor(i).eps0; % Section fiber strains
        
        % Iterative or non-iterative state determination procedure
        EL(j).el_in0.state_it = tor(i).state_it;
    end
    
    %% MODEL
    FEM.EL = [FEM.EL; EL];
    FEM.MODEL.nodes = [FEM.MODEL.nodes; nodes];
    FEM.MODEL.orientation = [FEM.MODEL.orientation; orientation];
    FEM.MODEL.connect = [FEM.MODEL.connect; connect];
    FEM.MODEL.B = [FEM.MODEL.B; bound];
    FEM.MODEL.F = [FEM.MODEL.F; F];
    
end

%% Set forces
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];
FEM.MODEL.theta = theta;
end
