% Torus analysis and refinement
clear
%%

% Load parameters
% Loading and elements
n = 100; % Number of elements
L = 100;

react = 1; % 20000; 
nP = 1; %32; % Number of loading points
P = react/nP/2; % Strap load

% Geometry
R = 79.6114323373661; % (174.8 - 13.6)/2; % Torus (major) radius
delta_a = 0; % Perturbation in radius
delta_b = 0;

Aip = 0; % Amplitude of in-plane sine waves
nip = 0; % Number of in-plane sine waves

Aop = 0; % Amplitude of out-of-plane sine waves
nop = 0; % Number of out-of-plane sine waves


% Link configuration
k_ax_link = 10000; % For each link (lb/in)
k_b_link = 10000;

% Strap configuration
k_ax_strap = 10000; % For each strap (lb/in)
k_b_strap = 0;

% Boundary configurations
% Torus tangent springs
k_ax_tan_tor = .001; % For each support
k_b_tan_tor = 0;

% Torus vertical springs - compression
k_ax_vert_tor_comp = .001; % 100000; % For each support % 
k_b_vert_tor_comp = 0;

% Torus vertical springs - tension
k_ax_vert_tor_ten = .001;
k_b_vert_tor_ten = 0;

% Strap tangent springs
k_ax_tan_strap = 10000; % For each strap
k_b_tan_strap = 0;

% % % % Strap vertical springs
% % % k_ax_vert_strap = 10000;
% % % k_b_vert_strap = 0;


% Pre-process geometry
% Torus and straps
torus_inp_16JUN15
torus_torsion_link_01JUN15
strap_inp_15JUN15

% Boundary conditions
tan_tor_inp_28MAY15 % Torus tangent
vert_tor_inp_28MAY15 % Torus vertical
tan_strap_inp_28MAY15 % Strap tangent
% vert_strap_inp_28MAY15 % Strap vertical

%% Compile element types
nodes = [linspace(0,L,n + 1)' zeros(n + 1,2)];
% [tor_nodes];
%     link_nodes
%     strap_nodes
%     tan_tor_nodes
%     vert_tor_nodes
%     tan_strap_nodes];
% %     vert_strap_nodes];

orientation = nodes + [zeros(n + 1,1) ones(n + 1,1) zeros(n + 1,1)];
% [tor_orientation];
%     link_orientation
%     strap_orientation
%     tan_tor_orientation
%     vert_tor_orientation
%     tan_strap_orientation];
% %     vert_strap_orientation];

connect = [(1:n)' (2:n + 1)' 5*ones(n,1) ones(n,1)];
% [tor_connect];
%     link_connect
%     strap_connect
%     tan_tor_connect
%     vert_tor_connect
%     tan_strap_connect];
% %     vert_strap_connect];

bound0 = zeros(n + 1,6);
bound0(1,:) = 1;
bound0(end,:) = [0 1 0 0 0 0];
bound1 = bound0';
bound = bound1(:);
% [tor_bound];
%     link_bound
%     strap_bound
%     tan_tor_bound
%     vert_tor_bound
%     tan_strap_bound];
% %     vert_strap_bound];

F1 = bound*0;
F1(end - 4) = -1e6;
% [tor_F1];
%     link_F1
%     strap_F1
%     tan_tor_F1
%     vert_tor_F1
%     tan_strap_F1];
% %     vert_strap_F1];

F2 = bound*0;
% [tor_F2];
%     link_F2
%     strap_F2
%     tan_tor_F2
%     vert_tor_F2
%     tan_strap_F2];
% %     vert_strap_F2];

strap_constrain_15JUN15
FEM.BOUND.KC = KC;


FEM.CONFIG = CONFIG;
FEM.SPRING(1:2) = SPRING;
FEM.SPRING(3:5) = LIN_BEAM;

FEM.GEOM.nodes = nodes;
FEM.GEOM.connect = connect;
FEM.GEOM.orientation = orientation;
FEM.BOUND.B = bound;
FEM.BOUND.F1 = F1;
FEM.BOUND.F2 = F2;
FEM.BOUND.F = F1*0; % F2(:,2);
FEM.PASS.f_norm = react;

FEM.BOUND.F_pre = zeros(size(F1));
FEM.BOUND.Dinc = 0;
FEM.BOUND.D = -1;
FEM.BOUND.Di = strap_ind(1)*6 - 4; % 1;



% Solver and analysis
FEM.ANALYSIS.d_inc = 1; % Starting number of loading increments
FEM.ANALYSIS.control = 6; % 1 - Displacement solver;
                          % 2 - Newton-Raphson solver;
                          % 3 - Arc-length solver;
                          % 4 - Updated arc-length solver;
                          % 5 - Work solver;
                          % 6 - Displacement solver - enforce displacement;
FEM.ANALYSIS.constraint = 3; % Arc-length constraint type (for control = 3)
FEM.ANALYSIS.NR_inc = 1; % Newton-Raphson, update stiffness matrix every 'NR_inc' increments
FEM.ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
FEM.ANALYSIS.arc_switch = 100; % Number of NR cutbacks before switching to arc-length solver, 0 is off

FEM.ANALYSIS.max_inc = 200; % Maximum number of increments
FEM.ANALYSIS.max_iter = 100; % Maximum number of iterations per increment
FEM.ANALYSIS.tol = 1e-3; % Solver tolerance, (normalized to force vector)
FEM.ANALYSIS.Dmax = .5; % Absolute maximum displacement
FEM.ANALYSIS.Di = 1; % DOF to track
FEM.ANALYSIS.DOF = 6; % DOF/node
FEM.ANALYSIS.analysis = 3; % 1 = linear, 2 = large displacement, linear, 3 = large displacement, nonlinear
FEM.ANALYSIS.step = 1;

% Plotting flags
FEM.PLOT.plot = 1; % 1 = plot output
FEM.PLOT.fig = 1; % Figure number
FEM.PLOT.scale = 1000; % Deformation scale

FEM.PLOT.plot_shape = ' '; % 'plot_tor_def(FEM)';
FEM.PLOT.plot_inc = 1; % Plot each increment switch
FEM.PLOT.plot_iter = 1; % Plot each iteration switch

% FEM.OUT.U = bound*0;
% FEM.OUT.U(1:length(U0_tor)) = U0_tor;


% % % %% Analyze, STEP 1 - gravity
% % % FEM_in_grav = FEM;
% % % FEM_in_grav.BOUND.F = F1; % F2(:,2);
% % % FEM_in_grav.PASS.f_norm = grav_norm;
% % % 
% % % [FEM_out_grav] = FE_solver(FEM_in_grav);
% % % % FEM_out_grav = FEM;
% % % 
% % % FE_plot(FEM_out_grav)



%% Analyze, STEP 1 - initial shape
U = bound*0;
U(end - 4) = -.001;
% U(end - 5) = .1;
FEM.OUT.U = U;
FEM.BOUND.U0 = U;


FE_plot(FEM)


FEM_in_shape = FEM;

[FEM_out_shape] = FE_solver(FEM_in_shape);
% FEM_out_grav = FEM;


FE_plot(FEM_out_shape)





%% Analyze, STEP 2 - loading
% Update solver parameters
FEM_out_grav.ANALYSIS.d_inc = 100; % Starting number of loading increments
FEM_out_grav.ANALYSIS.control = 1; % 1 - Displacement solver;
                                   % 2 - Newton-Raphson solver;
                                   % 3 - Arc-length solver;
                                   % 4 - Updated arc-length solver;
                                   % 5 - Work solver;
FEM_out_grav.ANALYSIS.constraint = 3; % Arc-length constraint type

%%%
FEM_out_grav.ANALYSIS.step = 1;

FEM_out_grav.PASS.set_L = 1;
FEM_out_grav.PASS.f_norm = react;

% Update loading
%%%
FEM_out_grav.BOUND.F_pre = zeros(size(F1));
FEM_out_grav.BOUND.F_pt = F2;
FEM_out_grav.BOUND.follow = 0;

[FEM_out_load] = FE_solver_pt_cord(FEM_out_grav);
FE_plot(FEM_out_load)



% plot_tor_def(FEM_out)




















