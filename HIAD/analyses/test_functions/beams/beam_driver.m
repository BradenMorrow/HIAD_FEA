%% DRIVE THE BEAM FE ANALYSIS OF INFLATABLE TORUS TESTS
% Andy Young

clear

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
for an = 48 %  %length(P_all) 1:48 % 
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
    FEM.MODEL.Di = find(beam_F/sum(beam_F)); % Di;
    FEM.MODEL.D = -5.5;
    FEM.MODEL.Dinc = 0;

FEM.ANALYSIS = FE_controls_beam;

FEM.PLOT = plot_controls_beam;

    %% ANALYZE
    FEM.MODEL.F_pre = zeros(size(beam_F));
    
    FEM.MODEL.F_pt = zeros(size(beam_F,1),2);
    FEM.MODEL.F_pt(:,2) = beam_F;

    FEM.OUT.U = 0*beam_F;
    FEM.OUT.Uinc = [beam_F beam_F]*0;
    FEM.OUT.Finc = [beam_F beam_F]*0;
    FEM.PASS.f_norm = react;
    FEM.PASS.set_L = 1;
    FEM.PASS.iter_i = 1;
    
    
    FEM.OUT.dV = zeros(2,1);
    
    [FEM_out] = increment_FE(FEM);

    misc_plot_14JUL15(FEM_out,4)
    FE_plot(FEM_out)

    out(an).FEM_out = FEM_out;
    
    plot_analyses

    disp(an)
    beam_postshape(FEM_out)
end