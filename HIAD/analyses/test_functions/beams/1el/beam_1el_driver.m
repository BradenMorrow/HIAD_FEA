%% DRIVE THE BEAM FE ANALYSIS OF INFLATABLE TORUS TESTS
% Andy Young
% December 31, 2014
clear

%% PREPROCESS
% Geometry and configuration (specific to analysis geometry)
n = 10; % Number of elements
L = 100;

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
    
    FEM.EL = EL;
    FEM.MODEL.nodes = beam_nodes; % Consolidate variable from analysis preprocessors
    FEM.MODEL.orientation = beam_orientation;
    FEM.MODEL.connect = beam_connect;
    FEM.MODEL.B = beam_bound;
    FEM.MODEL.F = beam_F;
    FEM.MODEL.Di = find(beam_F/sum(beam_F)); % Di;
    FEM.MODEL.D = -5.5; %4.635;
    FEM.MODEL.Dinc = 0;


    FEM.ANALYSIS = FE_controls_beam_1el;
    
    FEM.PLOT = plot_controls_beam_1el;


    %% ANALYZE
    FEM.ANALYSIS.step = 1;
    FEM.MODEL.F_pre = zeros(size(beam_F));   
    
    FEM.MODEL.F_pt = zeros(size(beam_F,1),2);
    FEM.MODEL.F_pt(:,2) = beam_F;

    FEM.OUT.U = 0*beam_F;
    FEM.OUT.Uinc = [beam_F beam_F]*0;
    FEM.OUT.Finc = [beam_F beam_F]*0;
    FEM.PASS.f_norm = react;
    FEM.PASS.set_L = 1;

    
    tic
    [FEM_out] = increment_FE(FEM);
    toc

    misc_plot_28OCT15_2(FEM_out,nDOF)
    FE_plot(FEM_out)

    out(an).FEM_out = FEM_out;

    disp(an)
end






