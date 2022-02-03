% Torus analysis and refinement
clear
%%

% Load parameters
% Loading and elements
n = 20; % Number of nodes
react = 25000; % 20000; 
nP = n; %32; % Number of loading points
P = react/nP; % Strap load
e = .01;

% Geometry
R = 100; % Torus (major) radius
delta_a = 0; % Perturbation in radius
delta_b = 0;

Aip = 0; % Amplitude of in-plane sine waves
nip = 0; % Number of in-plane sine waves

Aop = 0; % Amplitude of out-of-plane sine waves
nop = 0; % Number of out-of-plane sine waves


D_disp = 20;

% Pre-process geometry
torus_inp_21JUL15

% Compile element types
nodes = tor_nodes;
orientation = tor_orientation;
connect = tor_connect;
bound = tor_bound;
% % % F1 = tor_F1;
F2 = tor_F2;

FEM.EL = EL;
FEM.MODEL.nodes = nodes;
FEM.MODEL.connect = connect;
FEM.MODEL.orientation = orientation;
FEM.MODEL.B = bound;
% % % FEM.MODEL.F1 = F1;
% % % FEM.MODEL.F2 = F2;
FEM.MODEL.F = F2(:,2);
FEM.MODEL.F_pt = F2;

% FEM.MODEL.F_pre = zeros(size(F2));
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.Dinc = 0;
FEM.MODEL.D = -1;
FEM.MODEL.Di = 1;



% % Solver and analysis
% FEM.ANALYSIS.d_inc = 40; % Starting number of loading increments
% FEM.ANALYSIS.control = 2; % 1 - Displacement solver;
%                           % 2 - Newton-Raphson solver;
%                           % 3 - Arc-length solver;
%                           % 4 - Updated arc-length solver;
%                           % 5 - Work solver;
%                           % 6 - Displacement solver - enforce displacement;
% FEM.ANALYSIS.constraint = 3; % Arc-length constraint type (for control = 3)
% FEM.ANALYSIS.NR_inc = 1; % Newton-Raphson, update stiffness matrix every 'NR_inc' increments
% FEM.ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
% FEM.ANALYSIS.arc_switch = 100; % Number of NR cutbacks before switching to arc-length solver, 0 is off
% 
% FEM.ANALYSIS.max_inc = 100; % Maximum number of increments
% FEM.ANALYSIS.max_iter = 10; % Maximum number of iterations per increment
% FEM.ANALYSIS.tol = 1e-4; % Solver tolerance, (normalized to force vector)
% % FEM.ANALYSIS.Dmax = .77; % Absolute maximum displacement
% FEM.ANALYSIS.Di = 1; % DOF to track
% FEM.ANALYSIS.DOF = 6; % DOF/node
% FEM.ANALYSIS.analysis = 2; % 1 = linear, 2 = large displacement, linear, 3 = large displacement, nonlinear
% FEM.ANALYSIS.step = 1;
% 
% 
% 
% 
% FEM.ANALYSIS.adapt = 1;
% FEM.ANALYSIS.inc_target = 3;
% FEM.ANALYSIS.cord_update = 0;
% FEM.ANALYSIS.follow = 1;
% FEM.ANALYSIS.follow_F1 = 'F_tor_TIM';
% FEM.ANALYSIS.follow_F2 = 'F2_tor_TIM; Fpre2_tor_TIM;';
% FEM.ANALYSIS.follow_Knc = 'Knc_tor_TIM; Knc_pre_tor_TIM;';
% FEM.ANALYSIS.P_vec = P_vec;

FEM.ANALYSIS = FE_controls;



% % Plotting flags
% FEM.PLOT.plot = 1; % 1 = plot output
% FEM.PLOT.fig = 1; % Figure number
% FEM.PLOT.scale = 1; % Deformation scale
% 
% FEM.PLOT.plot_shape = 'plot_tor_def_TIM(FEM)';
% FEM.PLOT.plot_inc = 1; % Plot each increment switch
% FEM.PLOT.plot_iter = 1; % Plot each iteration switch

FEM.PLOT = plot_controls;

FEM.OUT.U = bound*0;
FE_plot(FEM)


%% Analyze, STEP 1 - initial shape
FEM_in = FEM;
FEM_in.PASS.f_norm = react;
FEM_in.PASS.set_L = 1;

FEM_in.OUT.Fext_inc = [bound bound]*0;
U0 = bound*0;

FEM_in.ANALYSIS.Dmax = 300; % Absolute maximum displacement


[FEM_out] = FE_solver(FEM_in);

FE_plot(FEM_out)
plot_tor_def_TIM(FEM_out)














