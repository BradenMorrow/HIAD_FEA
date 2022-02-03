function [out] = HIAD_param_21FEB17(param)

% Parameterized HIAD analysis
% Driver for parameterized HIAD analyses
% August 9, 2016
% clear

%% USER INPUT
% Define centerbody tieback location and torus centers
% [X Z] locations
[C,r] = HULA_config;

alpha_cone = 70; % HIAD angle with vertical

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
Rz = 55000; % 31000; % lbf 30000; % 
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
FEM.ANALYSIS = FE_controls0; % FE_controls1_opt;
FEM.PLOT = plot_controls0;

% Initialize cord force arrays
FEM.OUT.cord_f = zeros(50,7);
th = size(FEM.MODEL.theta,1);
for i = 1:7
    FEM.OUT.cord_f(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(1);
end

FEM.OUT.cord_f2 = zeros(50,7);
th = size(FEM.MODEL.theta,1);
for i = 1:7
    FEM.OUT.cord_f2(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(2);
end

% % % FE_plot(FEM)
post_proc_driver1(FEM)

% END BUILD MODEL


%% RUN ANALYSIS
% tic
[FEM_out] = increment_FE(FEM);
% toc

% END RUN ANALYSIS


%% POST PROCESS RESULTS
% Shape
% FE_plot(FEM_out)

% Mass estimate
out.mass0 = get_mass0(FEM,C,r,straps);
% % % out.mass = get_mass2(FEM,C,r,straps,param);
% % % out.mass2 = get_mass(FEM,C,r,straps);

% Load deformation response
[k,F_soft] = plot_inc(FEM_out);

% Save output
out.k_0 = k(1);
out.k_end = k(2);
out.F_soft = F_soft;


%%
% Strap response
out.F_penalty = max_strap_force(FEM_out,straps,strap_type,strap_EL_1);
% fig_1 = 200;
% strap_forces(FEM_out,straps,strap_type,strap_EL_1,fig_1)

% Cord response
FEM_out.OUT.cord_f(FEM_out.OUT.cord_f(:,1) == 0,:) = [];
FEM_out.OUT.cord_f2(FEM_out.OUT.cord_f2(:,1) == 0,:) = [];
plot_cord(FEM_out)

% FE_plot(FEM_out)
out.FEM_out = FEM_out;

% END POST PROCESS RESULTS
end










