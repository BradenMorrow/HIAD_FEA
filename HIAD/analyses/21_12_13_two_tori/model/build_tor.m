function [FEM, theta, th_bench, th_tst] = build_tor(C,tor,straps,min_nodes,num_bench,num_teststraps,b_theta0,ts_theta0,r_major,bench_length)
%% Create the tori FE model


%% THETA
% Theta tolerance
tol = 1e-12;

theta_tor = linspace(0,2*pi,min_nodes + 1)';
if size(theta_tor,1) > 1
    theta_tor(end) = [];
end

% Loop through loop straps
for i = 1:size(straps,1)
    % First strap node
    th_st1 = linspace(straps(i).theta0,straps(i).theta0 + 2*pi,straps(i).num_straps + 1)';
    th_st1(end) = [];
    
    % Second strap node
    th_st2 = linspace(straps(i).theta0 + straps(i).theta_sweep,straps(i).theta0 + straps(i).theta_sweep + 2*pi,straps(i).num_straps + 1)';
    th_st2(end) = [];
end

% Loop through loading straps
for i = 1:num_teststraps
    % First strap node
    th_tst = linspace(ts_theta0,ts_theta0 + 2*pi,num_teststraps + 1)';
    th_tst(end) = [];
end

% Loop through bench nodes
d_th = 2*asin(bench_length/r_major);
for i = 1:num_bench
    % First strap node
    th_bench1 = linspace(b_theta0 - d_th/2,b_theta0 - d_th/2 + 2*pi,num_bench + 1)';
    th_bench1(end) = [];
    
    th_bench2 = linspace(b_theta0 + d_th/2,b_theta0 + d_th/2 + 2*pi,num_bench + 1)';
    th_bench2(end) = [];
end

th_bench = [th_bench1; th_bench2];
% Combine theta locations
theta1 = [theta_tor; th_st1; th_st2; th_tst; th_bench];
theta1(theta1 >= 2*pi) = theta1(theta1 >= 2*pi) - 2*pi;
theta1(theta1 < 0) = theta1(theta1 < 0) + 2*pi;

% Sort theta vector
theta = unique(theta1);

% Enforce tolerance
theta2 = round(theta/tol)*tol;
theta = unique(theta2);

%% Preallocate and declare variables
FEM.MODEL.orientation = [];
FEM.MODEL.connect = [];
FEM.EL = [];
FEM.MODEL.nodes = [];
FEM.MODEL.B = [];
FEM.MODEL.F = [];
FEM.MODEL.U_pt = [];


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
    connect = [connect_i 5*ones(size(connect_i,1),1)];
    
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
    
    %% Boundary
    b = zeros(size(nodes,1),6);
    b = b';
    bound = b(:);

    %% U vector
    u = zeros(size(nodes,1),6);
    u = u';
    U = u(:);
    
    FEM.MODEL.U_pt = [FEM.MODEL.U_pt; U];

    %% Loading 
    F = zeros(size(bound));
        
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