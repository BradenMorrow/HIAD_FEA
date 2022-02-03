function [out] = HIAD_param_F2_28FEB17(param)

% Parameterized HIAD analysis
% Driver for parameterized HIAD analyses
% August 9, 2016
% clear

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
Rz = 20000; % 55000; % lbf
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
[FEM,~,~] = build_links_straps(FEM,theta,C,tor,straps);






%% ANALYSES

% Step 0 - Uniform pressure distribution
% Modeling controlls
FEM.ANALYSIS = FE_controls0_28FEB17;
FEM.PLOT = plot_controls0;

% % % FE_plot(FEM)
% % % post_proc_driver1(FEM)

fprintf('\nUniform pressure distribution\n')
[FEM_out0] = increment_FE(FEM);



%%
% Step 1 - Nonuniform pressure distribution
fprintf('\nNonuniform pressure distribution\n')
FEM1 = FEM_out0;
FEM1.ANALYSIS = FE_controls1;

% Include out-of-plane preload
FEM1.MODEL.F_pre = FEM1.OUT.Fext_inc(:,end);
    

Rz2 = 40000;
F = define_press2(C,r,alpha_cone,Rz2,theta);
FEM1.MODEL.F_pt = [zeros(size(FEM1.MODEL.F_pre,1),1) [F; zeros(size(FEM1.MODEL.F_pre,1) - size(F,1),1)]];
% % % FEM1.MODEL.F(1:size(theta,1)*(size(C,1) - 1)*6) = FEM1.MODEL.F(1:size(theta,1)*(size(C,1) - 1)*6) + F2;
% % % FEM1.PLOT.force = 1;
% % % FE_plot(FEM1)

tic
[FEM_out1] = increment_FE(FEM1);
toc

FE_plot(FEM_out1)
post_proc_driver2(FEM_out1)

% END RUN ANALYSIS



% % % %%
% % % % Step 1 - Nonuniform pressure distribution
% % % fprintf('\nNonuniform pressure distribution\n')
% % % FEM1 = FEM_out0;
% % % FEM1.ANALYSIS = FE_controls1;
% % % 
% % % % Include out-of-plane preload
% % % FEM1.MODEL.F_pre = FEM1.OUT.Fext_inc(:,end);
% % %     
% % % 
% % % ind0 = round(interp1(theta,(1:size(theta,1))',[pi/2 3*pi/2]'));
% % % ind = size(theta,1)*6*5 + (ind0 - 1)*6 + 2;
% % % 
% % % 
% % % 
% % % 
% % % F = 15000;
% % % % F = define_press2(C,r,alpha_cone,Rz2,theta);
% % % FEM1.MODEL.F_pt = zeros(size(FEM1.MODEL.F_pt));
% % % FEM1.MODEL.F_pt(ind,2) = [-F F]';
% % % 
% % % 
% % % FEM1.MODEL.F = FEM1.MODEL.F_pt(:,2);
% % % FEM1.PLOT.force = 1;
% % % FEM1.PLOT.def = 0;
% % % FE_plot(FEM1)
% % % 
% % % tic
% % % [FEM_out1] = increment_FE(FEM1);
% % % toc
% % % 
% % % FE_plot(FEM_out1)
% % % post_proc_driver2(FEM_out1)
% % % 
% % % % END RUN ANALYSIS





%% POST PROCESS RESULTS
% Shape
% FEM_out.PLOT.els = [0 0 0 1];
% FE_plot(FEM_out)
% FEM_out.PLOT.undef = 0;

out.mass = get_mass(FEM,C,r,straps);



[k,F_soft] = plot_inc(FEM_out1);


out.k_0 = k(1);
out.k_end = k(2);
out.F_soft = F_soft;
out.FEM_out = FEM_out1;

% % % % Load deformation
% % % [k] = plot_out(FEM_out);


% % % %%
% % % % Strap response
% % % fig_1 = 200;
% % % strap_forces(FEM_out,straps,strap_type,strap_EL_1,fig_1)
% % % strap_test(fig_1)
% % % 
% % % 
% % % % FE_plot(FEM_out)
% % % 
% % % 
% % % % END POST PROCESS RESULTS






end







