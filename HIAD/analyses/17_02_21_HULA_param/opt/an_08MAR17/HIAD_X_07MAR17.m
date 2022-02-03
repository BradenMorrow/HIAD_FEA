function [out] = HIAD_X_07MAR17(X)
% Parameterized HIAD analysis
% Driver for parameterized HIAD analyses
% August 9, 2016
% clear

[param] = build_param(X);


%% USER INPUT
% Define centerbody tieback location and torus centers
% [X Z] locations
[C,r] = HULA_config;

alpha_cone = 70; % HIAD angle with vertical

% % % % Define torus connectivities
% % % Ccon = [1 2 % Centerbody to T1
% % %     2 3 % T1 to T2
% % %     3 4 % T2 to T3
% % %     4 5 % T3 to T4
% % %     5 6]; % T4 to T5

% Define torus properties
% tor = define_tor(C,r);
tor = define_tor_param(C,r,param);

% Find the number of nodes - every torus has an equal number of nodes
min_nodes = 1; % Minimum number of torus nodes


% Define strap sets
% straps = define_straps_PT2(C,r,alpha_cone);
straps = define_straps_param(C,r,alpha_cone,param);

% Define HIAD loading
% Total Z direction reaction
Rz = 1; % 31000; % 55000; % lbf
load = define_press(C,r,alpha_cone,Rz);

% END USER INPUT


%% BUILD MODEL
% Assemble torus elements
[FEM, theta] = build_tor(C,tor,straps,load,min_nodes);

% Assemble interaction elements
pre_str = zeros(size(tor,1),1); % Interaction element prestrain
[FEM] = build_int(FEM,theta,C,tor,pre_str);

% Assemble link and strap elements
% [FEM,strap_type,strap_EL_1] = build_links_straps(FEM,theta,C,tor,straps);
[FEM,strap_type,strap_EL_1] = build_links_straps(FEM,theta,C,tor,straps);


%% PLOT AND CONTROLS
% Modeling controlls
FEM.ANALYSIS = FE_controls0_opt;
FEM.PLOT = plot_controls0;

% % % FE_plot(FEM)
% % % post_proc_driver1(FEM)

% END BUILD MODEL


% % % out.mass = get_mass(FEM,C,r,straps);


%% RUN ANALYSIS
% tic
[FEM_out] = increment_FE(FEM);
% toc

% END RUN ANALYSIS


%% POST PROCESS RESULTS
% Shape
% FEM_out.PLOT.els = [0 0 0 1];
% FE_plot(FEM_out)
% FEM_out.PLOT.undef = 0;

if isfield(FEM_out.OUT,'Fext_inc')
    out.mass = get_mass(FEM,C,r,straps);
    
    [k,F_soft] = plot_inc(FEM_out);
    
    out.k_0 = k(1);
    out.k_end = k(2);
    out.F_soft = F_soft;
    out.FEM_out = FEM_out;
    out.F_penalty = max_strap_force(FEM_out,straps,strap_type,strap_EL_1);
else
    out.mass = 1e4;
    out.k_0 = 0;
end



% % % % Load deformation
% % % [k] = plot_out(FEM_out);


%%
% Strap response
% % % fig_1 = 200;
% % % % strap_forces(FEM_out,straps,strap_type,strap_EL_1,fig_1)

% % % strap_test(fig_1)


% FE_plot(FEM_out)


% END POST PROCESS RESULTS













