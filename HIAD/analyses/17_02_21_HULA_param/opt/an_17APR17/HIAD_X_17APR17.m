function [out] = HIAD_X_17APR17(X0)
% Parameterized HIAD analysis
% Driver for parameterized HIAD analyses
% August 9, 2016
% clear


% % % X = [15 % Internal inflation pressure (psi)
% % %     15
% % %     15
% % %     15
% % %     15
% % %     15
% % %     15
% % %     65 % Braid angle (deg)
% % %     65
% % %     65
% % %     65
% % %     65
% % %     65
% % %     65
% % %     60 % Location of cords on cross-section (deg)
% % %     60
% % %     60
% % %     60
% % %     60
% % %     60
% % %     60
% % %     1 % Cord stiffness factor
% % %     1
% % %     1
% % %     1
% % %     1
% % %     1
% % %     1
% % %     32 % Number of loop straps (set 1)
% % %     32
% % %     32
% % %     32
% % %     32 % Number of loop straps (set 2)
% % %     32
% % %     32
% % %     32 % Number of radial strap sets
% % %     100 % Loop strap pretension (set 1)
% % %     100
% % %     100
% % %     100
% % %     100 % Loop strap pretension (set 2)
% % %     100
% % %     100
% % %     200 % Radial strap pretension
% % %     1 % Strap stiffness factor (loop set 1) (scale strap width)
% % %     1
% % %     1
% % %     1
% % %     1 % Strap stiffness factor (loop set 2) (scale strap width)
% % %     1
% % %     1
% % %     1 % Strap stiffness factor (fore radials) (scale strap width)
% % %     1]'; % Strap stiffness factor (aft radials) (scale strap width)
% % % 
% % % X(8:14) = X0;

[param] = build_param(X0);


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
Rz = 1000; % 32000; % lbf
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
FEM.ANALYSIS = FE_controls1_opt;
FEM.PLOT = plot_controls0;

% % % FE_plot(FEM)
% % % post_proc_driver1(FEM)

% END BUILD MODEL


%% RUN ANALYSIS
% tic
% % % out.mass = get_mass2(FEM,C,r,straps,param);
[FEM_out] = increment_FE(FEM);
% toc

% END RUN ANALYSIS


%% POST PROCESS RESULTS
% Shape
% FEM_out.PLOT.els = [0 0 0 1];
% FE_plot(FEM_out)
% FEM_out.PLOT.undef = 0;

if isfield(FEM_out.OUT,'Fext_inc')
    out.mass = get_mass0(FEM,C,r,straps);
    
    [k,~] = plot_inc_17MAR17(FEM_out);
    
%     out.k_0 = k(1);
%     out.FU = FU;
%     out.k_end = k(2);
%     out.F_soft = F_soft;
%     out.FEM_out = FEM_out;
%     out.F_penalty = max_strap_force(FEM_out,straps,strap_type,strap_EL_1);
else
    out.mass = 1e6;
    k = -1e6;
end

out.k = -k(1)*1e6;

% % % % Load deformation
% % % [k] = plot_out(FEM_out);


%%
% Strap response
% % % fig_1 = 200;
% % % % strap_forces(FEM_out,straps,strap_type,strap_EL_1,fig_1)

% % % strap_test(fig_1)


% FE_plot(FEM_out)


% END POST PROCESS RESULTS







end





