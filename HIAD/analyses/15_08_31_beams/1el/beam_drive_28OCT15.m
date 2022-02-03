%% DRIVE THE BEAM FE ANALYSIS OF INFLATABLE TORUS TESTS
% Andy Young
% December 31, 2014
clear

% cd C:\Users\andrew.young\Desktop\FE_code\torus_30MAR15
dir0 = 'C:\Users\andrew.young\Desktop\FE_code\flex_06NOV15';

cd(dir0)
set_working_dir

% plot_tests

%% PREPROCESS
% Geometry and configuration (specific to analysis geometry)
n = 10; % Number of elements
L = 100;
a = L;

nDOF = 0;

% Load beam specimen data
input_vars_30MAR15

% Loop through beam specimens
out(48,1).FEM_out.MODEL = [];
for an = 24 % 32 % 17:48 %length(P_all)
    % Beam specimen variables
    react = 10000; %P_all(an);
    p_i = p_all(an);
    r_i = r_all(an);
    beta_i = beta_all(an);
    props12_i = props12_all(an,:);
    alpha_i = alpha_all(an,:)';
    axial_table_i = axial_table_all{an};
    plot_ref_i = plot_ref(an);

    % Load beam specimen
    beam_inp_28OCT15 % Analysis preprocessor
    
    
%     M_wrink = pi/8*p*pi*r^2*(r*2)^3*(1 - 2*cotd(beta)^2)

    
    FEM.EL = EL;
    FEM.MODEL.nodes = beam_nodes; % Consolidate variable from analysis preprocessors
    FEM.MODEL.orientation = beam_orientation;
    FEM.MODEL.connect = beam_connect;
    FEM.MODEL.B = beam_bound;
    FEM.MODEL.F = beam_F;
    FEM.MODEL.Di = beam_F/sum(beam_F); % Di;
    FEM.MODEL.D = -5.5; %4.635;
    FEM.MODEL.Dinc = 0;

    % Solver and analysis
    FEM.ANALYSIS.d_inc = 50; % Starting number of loading increments
    FEM.ANALYSIS.control = 2; % 2 - Newton-Raphson solver;
                              % 3 - arc-length solver;
    FEM.ANALYSIS.constraint = 2; % Arc-length constraint type
    FEM.ANALYSIS.NR_inc = 1; % Newton-Raphson, update stiffness matrix every 'NR_inc' increments
    FEM.ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
    FEM.ANALYSIS.arc_switch = 100; % Number of NR cutbacks before switching to arc-length solver, 0 is off

    FEM.ANALYSIS.max_inc = 500; % Maximum number of increments
    FEM.ANALYSIS.max_iter = 10; % Maximum number of iterations per increment
    FEM.ANALYSIS.tol = 1e-6; % Solver tolerance, (normalized to force vector)
    FEM.ANALYSIS.Dmax = 3e1; % Absolute maximum displacement
    FEM.ANALYSIS.Di = 1; % DOF to track
    FEM.ANALYSIS.DOF = 6; % DOF/node
    FEM.ANALYSIS.analysis = 3; % 1 = linear, 2 = large displacement, linear, 3 = large displacement, nonlinear



    FEM.ANALYSIS.adapt = 0;
    FEM.ANALYSIS.inc_target = 3;
    FEM.ANALYSIS.cord_update = 0;
    FEM.ANALYSIS.follow = 0;
    FEM.ANALYSIS.follow_F1 = [];
    FEM.ANALYSIS.follow_F2 = [];
    FEM.ANALYSIS.follow_Knc = 'Knc_P_result';




    % Plotting flags
    FEM.PLOT.plot = 1; % 1 = plot output
    FEM.PLOT.fig = 1; % Figure number
    FEM.PLOT.scale = 1; % Deformation scale

    FEM.PLOT.plot_shape = sprintf('misc_plot_28OCT15_2(FEM,%g)',nDOF);
    FEM.PLOT.plot_inc = 1; % Plot each increment switch
    FEM.PLOT.plot_iter = 1; % Plot each iteration switch


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

    
    tic
    [FEM_out] = FE_solver(FEM);
    toc

    misc_plot_28OCT15_2(FEM_out,nDOF)
    FE_plot(FEM_out)

    out(an).FEM_out = FEM_out;
    
%     plot_analyses

    disp(an)
end

% save('output_04SEP15','out')



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


