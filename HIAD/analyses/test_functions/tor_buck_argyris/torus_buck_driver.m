% Calculate buckling response of a quarter of a torus under loading with 
% geometric perturbations and imperfections.
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
F2 = tor_F2;

FEM.EL = EL;
FEM.MODEL.nodes = nodes;
FEM.MODEL.connect = connect;
FEM.MODEL.orientation = orientation;
FEM.MODEL.B = bound;
FEM.MODEL.F = F2(:,2);
FEM.MODEL.F_pt = F2;

FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.Dinc = 0;
FEM.MODEL.D = -1;
FEM.MODEL.Di = 1;

FEM.ANALYSIS = FE_controls_tor_buck_argyris;

FEM.PLOT = plot_controls_tor_buck_argyris;

FEM.OUT.U = bound*0;
FE_plot(FEM)


%% Analyze, STEP 1 - initial shape
FEM_in = FEM;
% FEM_in.PASS.f_norm = react;
FEM_in.PASS.set_L = 1;

FEM_in.OUT.Fext_inc = [bound bound]*0;

[FEM_out] = increment_FE(FEM_in);

FE_plot(FEM_out)
plot_tor_def_TIM(FEM_out)














