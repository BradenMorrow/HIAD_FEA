% Torus analysis and refinement
clear
%%

tic

% Load parameters
% Loading and elements
n = 51; % Number of elements
react = 7000; % 20000; 
nP = 32; % Number of loading points
P = react/nP/2; % Strap load

% Geometry
R = 66.3985882748306; % (174.8 - 13.6)/2; % Torus (major) radius
delta_a = 0; % Perturbation in radius
delta_b = 0;

Aip = 0; % Amplitude of in-plane sine waves
nip = 0; % Number of in-plane sine waves

Aop = 0; % Amplitude of out-of-plane sine waves
nop = 0; % Number of out-of-plane sine waves


% Link configuration
k_ax_link = 100000; % For each link (lb/in)
k_b_link = 100000;

% Strap configuration
k_ax_strap = 90; % For each strap (lb/in)
k_b_strap = 0;

% Boundary configurations
% Torus tangent springs
k_ax_tan_tor = .001; % For each support
k_b_tan_tor = 0;

% Torus vertical springs - compression
k_ax_vert_tor_comp = 100000; % For each support % 
k_b_vert_tor_comp = 0;

% Torus vertical springs - tension
k_ax_vert_tor_ten = .001;
k_b_vert_tor_ten = 0;

% Strap tangent springs
k_ax_tan_strap = 100000; % For each strap
k_b_tan_strap = 0;

% % % % Strap vertical springs
% % % k_ax_vert_strap = 10000;
% % % k_b_vert_strap = 0;



D_disp = 4;

% Pre-process geometry
% Torus and straps
% torus_inp_16JUN15
torus_inp_12SEP15
torus_torsion_link_01JUN15
strap_inp_12SEP15

% Boundary conditions
tan_tor_inp_28MAY15 % Torus tangent
vert_tor_inp_28MAY15 % Torus vertical
tan_strap_inp_28MAY15 % Strap tangent
% vert_strap_inp_28MAY15 % Strap vertical

% Compile element types
nodes = [tor_nodes % ];
    link_nodes
    strap_nodes
    tan_tor_nodes
    vert_tor_nodes
    tan_strap_nodes];
%     vert_strap_nodes];

orientation = [tor_orientation % ];
    link_orientation
    strap_orientation
    tan_tor_orientation
    vert_tor_orientation
    tan_strap_orientation];
%     vert_strap_orientation];

connect = [tor_connect % ];
    link_connect
    strap_connect
    tan_tor_connect
    vert_tor_connect
    tan_strap_connect];
%     vert_strap_connect];

bound = [tor_bound % ];
    link_bound
    strap_bound
    tan_tor_bound
    vert_tor_bound
    tan_strap_bound];
%     vert_strap_bound];

F1 = [tor_F1 % ];
    link_F1
    strap_F1
    tan_tor_F1
    vert_tor_F1
    tan_strap_F1];
%     vert_strap_F1];

F2 = [tor_F2 % ];
    link_F2
    strap_F2
    tan_tor_F2
    vert_tor_F2
    tan_strap_F2];
%     vert_strap_F2];

% strap_constrain_15JUN15
% FEM.BOUND.KC = KC;


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

FEM.BOUND.F_pre = zeros(size(F1));
FEM.BOUND.Dinc = 0;
FEM.BOUND.D = -1;
FEM.BOUND.Di = strap_ind(1)*6 - 4; % 1;



% Solver and analysis
FEM.ANALYSIS.d_inc = 1; % Starting number of loading increments
FEM.ANALYSIS.control = 4; % 1 - Displacement solver;
                          % 2 - Newton-Raphson solver;
                          % 3 - Arc-length solver;
                          % 4 - Displacement solver - enforce displacement;
FEM.ANALYSIS.constraint = 3; % Arc-length constraint type (for control = 3)
FEM.ANALYSIS.NR_inc = 1; % Newton-Raphson, update stiffness matrix every 'NR_inc' increments
FEM.ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
FEM.ANALYSIS.arc_switch = 100000; % Number of NR cutbacks before switching to arc-length solver, 0 is off

FEM.ANALYSIS.max_inc = 100; % Maximum number of increments
FEM.ANALYSIS.max_iter = 10; % Maximum number of iterations per increment
FEM.ANALYSIS.tol = 1e-3; % Solver tolerance, (normalized to force vector)
% FEM.ANALYSIS.Dmax = .77; % Absolute maximum displacement
FEM.ANALYSIS.Di = 1; % DOF to track
FEM.ANALYSIS.DOF = 6; % DOF/node
FEM.ANALYSIS.analysis = 3; % 1 = linear, 2 = large displacement, linear, 3 = large displacement, nonlinear
FEM.ANALYSIS.step = 1;


FEM.ANALYSIS.adapt = 0;
FEM.ANALYSIS.inc_target = 4;
FEM.ANALYSIS.cord_update = 0;
FEM.ANALYSIS.follow = 0;
% FEM.ANALYSIS.follow_F1 = 'F_tor_TIM';
% FEM.ANALYSIS.follow_F2 = 'F2_tor_TIM';
% FEM.ANALYSIS.follow_Knc = 'Knc_tor_TIM';
% FEM.ANALYSIS.P_vec = P_vec;








% Plotting flags
FEM.PLOT.plot = 10; % 1 = plot output
FEM.PLOT.fig = 1; % Figure number
FEM.PLOT.scale = 10; % Deformation scale

FEM.PLOT.plot_shape = 'plot_tor_def(FEM)';
FEM.PLOT.plot_inc = 1; % Plot each increment switch
FEM.PLOT.plot_iter = 1; % Plot each iteration switch

FEM.OUT.U = bound*0;
% FEM.OUT.U(1:length(U0_tor)) = U0_tor;
% FE_plot(FEM)











%% Analyze, STEP 1 - initial shape
FEM_in_shape = FEM;
FEM_in_shape.BOUND.F = zeros(size(F1));
FEM_in_shape.PASS.f_norm = 1; % react;

U0 = bound*0;
U0(1:length(U0_tor)) = U0_tor; % U_initial_tor_51; % 
FEM_in_shape.BOUND.U0 = U0;
U_pt = [zeros(size(U0)) U0];
FEM_in_shape.BOUND.U_pt = U_pt;

FEM_in_shape.ANALYSIS.Dmax = .9*max(abs(U0)); % Absolute maximum displacement


[FEM_out_shape] = FE_solver_pt_cord(FEM_in_shape);
% FEM_out_shape = FEM;

% load('elas_201_23JUN15.mat')
% load('elas_51_23JUN15.mat')


FE_plot(FEM_out_shape)








%% Analyze, STEP 2 - loading
% % % FEM_in_load = FEM_out_shape;
% % % 
% % % U0_load = zeros(size(U0));
% % % U0_load(strap_ind(1)*6 - 5:strap_ind(end)*6) = U0_strap;
% % % 
% % % FEM_in_load.BOUND.U0 = U0_load;

% % % load('elas_201_23JUN15.mat')
% % % load('elas_51_23JUN15.mat')

cord_update_18JUN15


% Update nodes
U2 = zeros(length(FEM_out_shape.OUT.U)/6,6);
for j = 1:6
    U2(:,j) = FEM_out_shape.OUT.U(j:6:length(FEM_out_shape.OUT.U));
end



FEM_in_load = FEM;
% % % load('element.mat')
% % % FEM_in_load.CONFIG.element = element;


% FEM_in_load.GEOM.nodes = FEM.GEOM.nodes;
% % FEM_in_load.GEOM.nodes(1:link_ind(length(link_ind)),:) = FEM.GEOM.nodes(1:link_ind(length(link_ind)),:) + U2(1:link_ind(length(link_ind)),1:3);
% % % FEM_in_load.GEOM.nodes(~strap_ind,:) = FEM.GEOM.nodes(~strap_ind,:) + U2(~strap_ind,1:3);

update_orient


% Update solver parameters
FEM_in_load.ANALYSIS.d_inc = 50; % Starting number of loading increments
FEM_in_load.ANALYSIS.control = 4; % 1 - Displacement solver;
                                  % 2 - Newton-Raphson solver;
                                  % 3 - Arc-length solver;
                                  % 4 - Displacement solver - enforce displacement;
FEM_in_load.ANALYSIS.constraint = 3; % Arc-length constraint type
FEM_in_load.ANALYSIS.Dmax = D_disp; % Absolute maximum displacement

%%%
FEM_in_load.ANALYSIS.step = 1;

FEM_in_load.PASS.set_L = 1;
FEM_in_load.PASS.f_norm = 1; % react;

% Update loading
%%%
FEM_in_load.BOUND.F_pre = zeros(size(F1)); % FEM_in_load.PASS.Fint; % zeros(size(F1));
FEM_in_load.BOUND.F_pt = F2;
FEM_in_load.BOUND.follow = 0;

bound(1:length(tor_bound)) = 0;
bound(strap_ind(1)*6 - 5:strap_ind(end)*6) = 1;

% bound(1:length(tor_bound)) = 1;

FEM_in_load.BOUND.B = bound;


% Displacement vector
% U0 = bound*0;
% U0(strap_ind(1)*6 - 5:strap_ind(end)*6) = U0_strap;
% FEM_in_load.BOUND.U0 = U0;

U0_vec1 = [normr((-FEM_in_load.GEOM.nodes(FEM_in_load.SPRING(1).ind,:) - ...
    FEM_in_load.GEOM.nodes(FEM_in_load.SPRING(2).ind,:)))*D_disp zeros(nP*2,3)]';
U0_vec = U0_vec1(:);

U0 = bound*0;
U0(strap_ind(1)*6 - 5:strap_ind(end)*6) = U0_vec;
FEM_in_load.BOUND.U0 = U0;



cable_disp


U_pt = zeros(size(U0,1),size(U_pt0,2));
U_pt(strap_ind(1)*6 - 5:strap_ind(end)*6,:) = U_pt0;
FEM_in_load.BOUND.U_pt = U_pt;




FEM_in_load.PLOT.scale = 10;
FEM_in_load.ANALYSIS.cord_update = 1;

FE_plot(FEM_in_load)
[FEM_out_load] = FE_solver_pt_cord(FEM_in_load);
FE_plot(FEM_out_load)



plot_tor_def(FEM_out_load)

% save('out_14SEP15_2_no_shape','FEM_out_load')



toc














