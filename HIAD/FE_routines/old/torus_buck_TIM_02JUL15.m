% Torus analysis and refinement
clear
%%

% Load parameters
% Loading and elements
n = 72; % Number of elements
react = 10; % 20000; 
nP = n; %32; % Number of loading points
P = react/nP; % Strap load
e = .001;

% Geometry
R = 100; % Torus (major) radius
delta_a = 0; % Perturbation in radius
delta_b = 0;

Aip = 0; % Amplitude of in-plane sine waves
nip = 0; % Number of in-plane sine waves

Aop = 0; % Amplitude of out-of-plane sine waves
nop = 0; % Number of out-of-plane sine waves


% % % % Link configuration
% % % k_ax_link = 100000; % For each link (lb/in)
% % % k_b_link = 100000;
% % % 
% % % % Strap configuration
% % % k_ax_strap = 10000; % For each strap (lb/in)
% % % % k_b_strap = 0;

% Boundary configurations
% Torus tangent springs
k_ax_tan_tor = .0000001; % For each support
k_b_tan_tor = 0;

% Torus vertical springs - compression
k_ax_vert_tor_comp = .0000001; % For each support % 
k_b_vert_tor_comp = 0;

% Torus vertical springs - tension
k_ax_vert_tor_ten = .0000001;
k_b_vert_tor_ten = 0;

% % % % Strap tangent springs
% % % k_ax_tan_strap = 100000; % For each strap
% % % k_b_tan_strap = 0;

% % % % Strap vertical springs
% % % k_ax_vert_strap = 10000;
% % % k_b_vert_strap = 0;



D_disp = 20;

% Pre-process geometry
% Torus and straps
% torus_inp_16JUN15
% torus_inp_15JUL15
torus_inp_20JUL15

% torus_torsion_link_01JUN15
% strap_inp_15JUN15

% Boundary conditions
tan_tor_inp_28MAY15 % Torus tangent
vert_tor_inp_28MAY15 % Torus vertical
% tan_strap_inp_28MAY15 % Strap tangent
% vert_strap_inp_28MAY15 % Strap vertical

% Compile element types
nodes = [tor_nodes % ];
%     link_nodes
%     strap_nodes
    tan_tor_nodes
    vert_tor_nodes];
%     tan_strap_nodes];
%     vert_strap_nodes];

orientation = [tor_orientation % ];
%     link_orientation
%     strap_orientation
    tan_tor_orientation
    vert_tor_orientation];
%     tan_strap_orientation];
%     vert_strap_orientation];

connect = [tor_connect % ];
%     link_connect
%     strap_connect
    tan_tor_connect
    vert_tor_connect];
%     tan_strap_connect];
%     vert_strap_connect];

bound = [tor_bound % ];
%     link_bound
%     strap_bound
    tan_tor_bound
    vert_tor_bound];
%     tan_strap_bound];
%     vert_strap_bound];

F1 = [tor_F1 % ];
%     link_F1
%     strap_F1
    tan_tor_F1
    vert_tor_F1];
%     tan_strap_F1];
%     vert_strap_F1];

F2 = [tor_F2 % ];
%     link_F2
%     strap_F2
    tan_tor_F2
    vert_tor_F2];
%     tan_strap_F2];
%     vert_strap_F2];

% strap_constrain_15JUN15
% FEM.BOUND.KC = KC;


FEM.CONFIG = CONFIG;
% FEM.SPRING(1:2) = SPRING;
FEM.SPRING(2:3) = LIN_BEAM;

FEM.GEOM.nodes = nodes;
FEM.GEOM.connect = connect;
FEM.GEOM.orientation = orientation;
FEM.BOUND.B = bound;
FEM.BOUND.F1 = F1;
FEM.BOUND.F2 = F2;
FEM.BOUND.F = F2(:,2);
FEM.BOUND.F_pt = F2;

FEM.BOUND.F_pre = zeros(size(F1));
FEM.BOUND.Dinc = 0;
FEM.BOUND.D = -1;
FEM.BOUND.Di = 1;



% Solver and analysis
FEM.ANALYSIS.d_inc = 200; % Starting number of loading increments
FEM.ANALYSIS.control = 2; % 1 - Displacement solver;
                          % 2 - Newton-Raphson solver;
                          % 3 - Arc-length solver;
                          % 4 - Updated arc-length solver;
                          % 5 - Work solver;
                          % 6 - Displacement solver - enforce displacement;
FEM.ANALYSIS.constraint = 3; % Arc-length constraint type (for control = 3)
FEM.ANALYSIS.NR_inc = 1; % Newton-Raphson, update stiffness matrix every 'NR_inc' increments
FEM.ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
FEM.ANALYSIS.arc_switch = 100; % Number of NR cutbacks before switching to arc-length solver, 0 is off

FEM.ANALYSIS.max_inc = 100; % Maximum number of increments
FEM.ANALYSIS.max_iter = 10; % Maximum number of iterations per increment
FEM.ANALYSIS.tol = 1e-4; % Solver tolerance, (normalized to force vector)
% FEM.ANALYSIS.Dmax = .77; % Absolute maximum displacement
FEM.ANALYSIS.Di = 1; % DOF to track
FEM.ANALYSIS.DOF = 6; % DOF/node
FEM.ANALYSIS.analysis = 2; % 1 = linear, 2 = large displacement, linear, 3 = large displacement, nonlinear
FEM.ANALYSIS.step = 1;




FEM.ANALYSIS.adapt = 1;
FEM.ANALYSIS.inc_target = 3;
FEM.ANALYSIS.cord_update = 0;
FEM.ANALYSIS.follow = 1;
FEM.ANALYSIS.follow_F1 = 'F_tor_TIM';
FEM.ANALYSIS.follow_F2 = 'F2_tor_TIM';
FEM.ANALYSIS.follow_Knc = 'Knc_tor_TIM';
FEM.ANALYSIS.P_vec = P_vec;



% Plotting flags
FEM.PLOT.plot = 10; % 1 = plot output
FEM.PLOT.fig = 1; % Figure number
FEM.PLOT.scale = 1; % Deformation scale

FEM.PLOT.plot_shape = 'plot_tor_def_TIM(FEM)';
FEM.PLOT.plot_inc = 1; % Plot each increment switch
FEM.PLOT.plot_iter = 1; % Plot each iteration switch

FEM.OUT.U = bound*0;
% FEM.OUT.U(1:length(U0_tor)) = U0_tor;
FE_plot(FEM)


% % % %% Analyze, STEP 1 - gravity
% % % FEM_in_grav = FEM;
% % % FEM_in_grav.BOUND.F = F1; % F2(:,2);
% % % FEM_in_grav.PASS.f_norm = grav_norm;
% % % 
% % % [FEM_out_grav] = FE_solver(FEM_in_grav);
% % % % FEM_out_grav = FEM;
% % % 
% % % 
% % % 
% % % 
% % % FE_plot(FEM_out_grav)







%% Analyze, STEP 1 - initial shape
FEM_in = FEM;
% FEM_in_shape.BOUND.F = zeros(size(F1));
FEM_in.PASS.f_norm = react;
FEM_in.PASS.set_L = 1;


U0 = bound*0;
% U0(1:length(U0_tor)) = U0_tor; % U_initial_tor_51; % 
% FEM_in_shape.BOUND.U0 = U0;

FEM_in.ANALYSIS.Dmax = 40; % Absolute maximum displacement


[FEM_out] = FE_solver_pt_cord(FEM_in);
% FEM_out_shape = FEM;

% load('elas_201_23JUN15.mat')
% load('elas_51_23JUN15.mat')


FE_plot(FEM_out)
plot_tor_def_TIM(FEM_out)














