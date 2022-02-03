% Investigate use of follower forces
clear

%%
% Load parameters
% Loading and elements
n = 3; % Number of nodes
react = 132000;

% Geometry
L = 1; % Length

%% NODES
x = linspace(0,L,n)';
y = 0*x;
z = 0*x;

nodes = [x y z];

%% ORIENT
orientation = nodes;
orientation(:,2) = orientation(:,2) + 1;

%% CONNECT
connect = [(1:n - 1)' (2:n)' 2*ones(size(nodes,1) - 1,1)];

%% BOUND
fix = zeros(size(x,1),6);
fix(1,:) = 1;
bound = fix';
bound = bound(:);

%% LOAD
force = fix*0;
% force(end,1) = react*cosd(45);
% force(end,2) = react*sind(45);
force(end,2) = -react;
F = force';
F = F(:);

U0 = F*0;

%% ELEMENTS
E = 2.1e11;
A = .002/10;
I = 1.666667e-8;

% Preallocate element structure
EL(n - 1).el = [];
EL(n - 1).el_in.nodes_ij = [];
EL(n - 1).el_in.orient_ij = [];
EL(n - 1).el_in.connect_ij = [];
EL(n - 1).el_in0.mat = [];
EL(n - 1).el_in0.geom = [];
EL = EL';

for i = 1:n - 1
    % Define element functions
    EL(i).el = @el2; % Linear, corotational beam
    
    % Element geometry
    EL(i).el_in.nodes_ij = [nodes(connect(i,1),:)
        nodes(connect(i,2),:)];
    EL(i).el_in.orient_ij = [orientation(connect(i,1),:)
        orientation(connect(i,2),:)];
    EL(i).el_in.connect_ij = connect(i,1:2);
    
    % Special element input
    EL(i).el_in0.mat = [E .3]; % [type E nu]
    EL(i).el_in0.geom = [A I I 0 2*I]; % [A Izz Iyy ky J]
    EL(i).el_in0.L0 = sqrt((EL(i).el_in.nodes_ij(2,1) - EL(i).el_in.nodes_ij(1,1))^2 + ...
            (EL(i).el_in.nodes_ij(2,2) - EL(i).el_in.nodes_ij(1,2))^2 + ...
            (EL(i).el_in.nodes_ij(2,3) - EL(i).el_in.nodes_ij(1,3))^2);
end


FEM.EL = EL;

FEM.MODEL.nodes = nodes;
FEM.MODEL.connect = connect;
FEM.MODEL.orientation = orientation;
FEM.MODEL.B = bound;
FEM.MODEL.F = F;
FEM.MODEL.F_pt = [F*0 F];

FEM.MODEL.F_pre = F*0;
FEM.MODEL.Dinc = 0;
FEM.MODEL.D = -1;
FEM.MODEL.Di = n*6 - 4;

FEM.PASS.Fext = F*0;



% FE controls
[FEM.ANALYSIS] = FE_controls;
[FEM.PLOT] = plot_controls;


% % % % Solver and analysis
% % % FEM.ANALYSIS.d_inc = 1000; % Starting number of loading increments
% % % FEM.ANALYSIS.control = 2; % 1 - Displacement solver;
% % %                           % 2 - Newton-Raphson solver;
% % %                           % 3 - Arc-length solver;
% % %                           % 4 - Updated arc-length solver;
% % %                           % 5 - Work solver;
% % %                           % 6 - Displacement solver - enforce displacement;
% % % FEM.ANALYSIS.constraint = 3; % Arc-length constraint type (for control = 3)
% % % FEM.ANALYSIS.NR_inc = 1; % Newton-Raphson, update stiffness matrix every 'NR_inc' increments
% % % FEM.ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
% % % FEM.ANALYSIS.arc_switch = 100; % Number of NR cutbacks before switching to arc-length solver, 0 is off
% % % 
% % % FEM.ANALYSIS.max_inc = 100; % Maximum number of increments
% % % FEM.ANALYSIS.max_iter = 10; % Maximum number of iterations per increment
% % % FEM.ANALYSIS.tol = 1e-4; % Solver tolerance, (normalized to force vector)
% % % FEM.ANALYSIS.Dmax = 10; % Absolute maximum displacement
% % % FEM.ANALYSIS.Di = 1; % DOF to track
% % % FEM.ANALYSIS.DOF = 6; % DOF/node
% % % FEM.ANALYSIS.analysis = 2; % 1 = linear, 2 = large displacement, linear, 3 = large displacement, nonlinear
% % % FEM.ANALYSIS.step = 1;
% % % 
% % % FEM.ANALYSIS.adapt = 1;
% % % FEM.ANALYSIS.inc_target = 6;
% % % FEM.ANALYSIS.cord_update = 0;
% % % 
% % % 
% % % FEM.ANALYSIS.follow = 1;
% % % FEM.ANALYSIS.follow_F1 = @update_F_cable;
% % % FEM.ANALYSIS.follow_F2 = @update_F_cable;
% % % FEM.ANALYSIS.follow_Knc = @update_Knc_cable;
% % % 
% % % 
% % % 
% % % % Plotting flags
% % % 
% % % 
% % % FEM.PLOT.plot = 10; % 1 = plot output
% % % FEM.PLOT.fig = 1; % Figure number
% % % FEM.PLOT.scale = 1; % Deformation scale
% % % FEM.PLOT.undef = 1;
% % % FEM.PLOT.def = 1;
% % % FEM.PLOT.force = 1;
% % % FEM.PLOT.number = 0;
% % % FEM.PLOT.triad = 0;
% % % 
% % % FEM.PLOT.plot_shape = 'cant_def(FEM)';
% % % FEM.PLOT.plot_inc = 1; % Plot each increment switch
% % % FEM.PLOT.plot_iter = 1; % Plot each iteration switch
% % % 
% % % FEM.OUT.U = bound*0;
% % % 
% % % 
% % % 
% % % 
% % % %% Analyze, STEP 1 - initial shape
% % % FEM.PASS.f_norm = react;
% % % FEM.PASS.set_L = 1;
% % % 
% % % FEM.BOUND.U0 = U0;
% % % 
% % % 
% % % 
% % % % FEM.BOUND.F_pt(end,2) = -1000;


%FE_plot(FEM)

[FEM_out] = increment_FE(FEM);




%FE_plot(FEM_out)
cant_def(FEM_out)













