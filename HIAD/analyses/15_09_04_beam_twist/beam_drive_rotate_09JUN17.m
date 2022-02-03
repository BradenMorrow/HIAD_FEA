%% DRIVE THE BEAM FE ANALYSIS OF INFLATABLE TORUS TESTS
% Andy Young
% December 31, 2014
clear

% plot_tests

%% PREPROCESS
% Geometry and configuration (specific to analysis geometry)
n = 30; % Number of elements
L = 64.5*2;
a = 20.5;

% Preallocate out
out(48).FEM_out = [];

input_vars_30MAR15
for an = 48 % 17:48 %length(P_all)
%     react = 800;

    react = P_all(an);
    p_i = p_all(an);
    r_i = r_all(an);
    beta_i = beta_all(an);
    props12_i = props12_all(an,:);
    % % % alpha_i = alpha_all(an,:)';
    alpha_i = [30 150 270]';
    
    axial_table_i = axial_table_all{an};
    plot_ref_i = plot_ref(an);

    beam_rot_info_09JUN17 % Analysis preprocessor
    
    FEM.EL = EL;
    FEM.MODEL.nodes = [beam_nodes
        s_nodes]; % Consolidate variable from analysis preprocessors
    FEM.MODEL.orientation = [beam_orientation
        s_orientation];
    FEM.MODEL.connect = [beam_connect
        s_connect];
    FEM.MODEL.B = [beam_bound
        s_bound];
    FEM.MODEL.F = [beam_F
        s_F];
    FEM.MODEL.Di = Di;
    FEM.MODEL.D = -20; %4.635;
    FEM.MODEL.Dinc = 0;

%     % Solver and analysis
%     FEM.ANALYSIS.d_inc = 20; % Starting number of loading increments
%     FEM.ANALYSIS.control = 2; % 2 - Newton-Raphson solver;
%                               % 3 - arc-length solver;
%     FEM.ANALYSIS.constraint = 2; % Arc-length constraint type
%     FEM.ANALYSIS.NR_inc = 1; % Newton-Raphson, update stiffness matrix every 'NR_inc' increments
%     FEM.ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
%     FEM.ANALYSIS.arc_switch = 100; % Number of NR cutbacks before switching to arc-length solver, 0 is off
% 
%     FEM.ANALYSIS.max_inc = 500; % Maximum number of increments
%     FEM.ANALYSIS.max_iter = 10; % Maximum number of iterations per increment
%     FEM.ANALYSIS.tol = 1e-3; % Solver tolerance, (normalized to force vector)
%     FEM.ANALYSIS.Dmax = 5; % Absolute maximum displacement
%     FEM.ANALYSIS.Di = 1; % DOF to track
%     FEM.ANALYSIS.DOF = 6; % DOF/node
%     FEM.ANALYSIS.analysis = 3; % 1 = linear, 2 = large displacement, linear, 3 = large displacement, nonlinear
% 
% 
% 
%     FEM.ANALYSIS.adapt = 1;
%     FEM.ANALYSIS.inc_target = 3;
%     FEM.ANALYSIS.cord_update = 0;
%     FEM.ANALYSIS.follow = 0;
%     FEM.ANALYSIS.follow_F1 = 'F_tor_TIM';
%     FEM.ANALYSIS.follow_F2 = 'F2_tor_TIM';
%     FEM.ANALYSIS.follow_Knc = 'Knc_tor_TIM';
    
    
    FEM.ANALYSIS = FE_controls_09JUN17;
    
    
    
    
%     % Plotting flags
%     FEM.PLOT.plot = 1; % 1 = plot output
%     FEM.PLOT.fig = 1; % Figure number
%     FEM.PLOT.scale = 1; % Deformation scale
% 
%     FEM.PLOT.plot_shape = 'misc_plot_twist_20AUG15(FEM,4)';
%     FEM.PLOT.plot_inc = 1; % Plot each increment switch
%     FEM.PLOT.plot_iter = 1; % Plot each iteration switch

FEM.PLOT = plot_controls;


    %% ANALYZE
    FEM.ANALYSIS.step = 1;
    FEM.MODEL.F_pre = zeros(size(FEM.MODEL.F));
    FEM.MODEL.F_pt = zeros(size(FEM.MODEL.F,1),2);
    FEM.MODEL.F_pt(:,2) = FEM.MODEL.F;

    FEM.OUT.U = 0*FEM.MODEL.F;
    FEM.PASS.f_norm = react;
    FEM.PASS.set_L = 1;

    tic
    [FEM_out] = increment_FE(FEM);
    toc

    misc_plot_twist_20AUG15(FEM_out,4)
    FE_plot(FEM_out)


    out(an).FEM_out = FEM_out;
    plot_rotation

    disp(an)
end

out1 = out';
% save('output_twist_1mm_04SEP15_2','out1')





