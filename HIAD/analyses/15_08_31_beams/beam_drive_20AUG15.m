%% DRIVE THE BEAM FE ANALYSIS OF INFLATABLE TORUS TESTS
% Andy Young
% December 31, 2014
clear
t_tot = tic;


% plot_tests

%% PREPROCESS
% Geometry and configuration (specific to analysis geometry)
n = 10; % Number of elements
L = 64.5;
a = 20.5;

% Load beam specimen data
input_vars_30MAR15


ELong_i = zeros(size(p_all));

% Loop through beam specimens
out(48,1).FEM_out.MODEL = [];
for an = 47 % 24 %  %length(P_all) 1:48 % 
    % Beam specimen variables
    react = P_all(an);
    p_i = p_all(an);
    r_i = r_all(an);
    beta_i = beta_all(an);
    props12_i = props12_all(an,:);
    alpha_i = alpha_all(an,:)';
    axial_table_i = axial_table_all{an};
    plot_ref_i = plot_ref(an);
    E_fac_i = E_fac(an);

    % Load beam specimen
    beam_inp_12MAY15 % Analysis preprocessor
    
    ELong_i(an) = ELong*t*3;
    
    FEM.EL = EL;
    FEM.MODEL.nodes = beam_nodes; % Consolidate variable from analysis preprocessors
    FEM.MODEL.orientation = beam_orientation;
    FEM.MODEL.connect = beam_connect;
    FEM.MODEL.B = beam_bound;
    FEM.MODEL.F = beam_F;
    FEM.MODEL.Di = beam_F/sum(beam_F); % Di;
    FEM.MODEL.D = -5.5; %4.635;
    FEM.MODEL.Dinc = 0;

%     % Solver and analysis
%     FEM.ANALYSIS.d_inc = 100; % Starting number of loading increments
%     FEM.ANALYSIS.control = 2; % 2 - Newton-Raphson solver;
%                               % 3 - arc-length solver;
%     FEM.ANALYSIS.constraint = 2; % Arc-length constraint type
%     FEM.ANALYSIS.NR_inc = 1; % Newton-Raphson, update stiffness matrix every 'NR_inc' increments
%     FEM.ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
%     FEM.ANALYSIS.arc_switch = 100; % Number of NR cutbacks before switching to arc-length solver, 0 is off
% 
%     FEM.ANALYSIS.max_inc = 500; % Maximum number of increments
%     FEM.ANALYSIS.max_iter = 10; % Maximum number of iterations per increment
%     FEM.ANALYSIS.tol = 1e-4; % Solver tolerance, (normalized to force vector)
%     FEM.ANALYSIS.Dmax = 5.05; % Absolute maximum displacement
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
%     FEM.ANALYSIS.follow_F1 = [];
%     FEM.ANALYSIS.follow_F2 = [];
%     FEM.ANALYSIS.follow_Knc = 'Knc_P_result';

    FEM.ANALYSIS = FE_controls;



%     % Plotting flags
%     FEM.PLOT.plot = 1; % 1 = plot output
%     FEM.PLOT.fig = 1; % Figure number
%     FEM.PLOT.scale = 1; % Deformation scale
% 
%     FEM.PLOT.plot_shape = 'misc_plot_14JUL15(FEM,4)';
%     FEM.PLOT.plot_inc = 1; % Plot each increment switch
%     FEM.PLOT.plot_iter = 1; % Plot each iteration switch

    FEM.PLOT = plot_controls;

    %% ANALYZE
    FEM.ANALYSIS.step = 1;
    FEM.MODEL.F_pre = zeros(size(beam_F));
%     FEM.MODEL.F_pre(7) = -p*pi*r^2*100;
    
    
    FEM.MODEL.F_pt = zeros(size(beam_F,1),2);
    FEM.MODEL.F_pt(:,2) = beam_F;

    FEM.OUT.U = 0*beam_F;
    FEM.OUT.Uinc = [beam_F beam_F]*0;
    FEM.OUT.Finc = [beam_F beam_F]*0;
    FEM.PASS.f_norm = react;
    FEM.PASS.set_L = 1;
    FEM.PASS.iter_i = 1;
    
    
%     FEM.OUT.M = zeros(500,1);
    FEM.OUT.dV = zeros(2,1);
    
    tic
    [FEM_out] = increment_FE(FEM);
    toc

    misc_plot_14JUL15(FEM_out,4)
    FE_plot(FEM_out)

    out(an).FEM_out = FEM_out;
    
    plot_analyses

    disp(an)
end

% save('output_13JAN16_Eeff','out')

toc(t_tot)

%%
% % % % Plot analyses
% % % load('output_20AUG15.mat')
% % % out = out1';
% % % dir0 = 'C:\Users\andrew.young\Desktop\FE_code\modeling_paper_20AUG15';
% % % input_vars_30MAR15
% % % plot_tests
% % % for an = 17:48
% % % %     react = P_all(an);
% % % %     p_i = p_all(an);
% % % %     r_i = r_all(an);
% % % %     beta_i = beta_all(an);
% % % %     props12_i = props12_all(an,:);
% % % %     alpha_i = alpha_all(an,:)';
% % % %     axial_table_i = axial_table_all{an};
% % % %     plot_ref_i = plot_ref(an);
% % % % 
% % % % 
% % % % 
% % % % 
% % % % 
% % % % 
% % % %     beam_inp_12MAY15 % Analysis preprocessor
% % %     
% % %     
% % %     
% % %     plot_ref_i = plot_ref(an);
% % %     plot_analyses
% % % end


%%
plot_trace.nodes = FEM_out.MODEL.nodes;
plot_trace.Uinc = FEM_out.OUT.Uinc;
plot_trace.Fext = FEM_out.OUT.Fext_inc;
save('plot_trace_60_20_2up','plot_trace')


