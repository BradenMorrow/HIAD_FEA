% Driver for parameterized HIAD analyses
% August 9, 2016
% clear

%% USER INPUT
% Define centerbody tieback location and torus centers
% [X Z] locations
[C,r] = WT_config;

% % % C = [170.22695601602 78.8978503484703 % Location of tieback to centerbody
% % %     185.185453 84.342298 % T1 center
% % % 	213.724769 94.729760 % T2 center
% % % 	242.558759 105.224474 % T3 center
% % % 	271.650278 115.812921 % T4 center
% % % 	300.963157 126.481936 % T5 center
% % % 	322.382105 124.113612]; % T6 center
% % % 
% % % r = [31.837/2 % Minor radii of tori, T1
% % %     31.837/2 % T2
% % %     31.837/2 % T3
% % %     31.837/2 % T4
% % %     31.837/2 % T5
% % %     12.735/2]; % T6

alpha_cone = 60; % HIAD angle with vertical

% Define torus connectivities
Ccon = [1 2 % Centerbody to T1
    2 3 % T1 to T2
    3 4 % T2 to T3
    4 5 % T3 to T4
    5 6 % T4 to T5
    6 7 % T5 to T6
    7 8 % T6 to T7
    8 9]; % T7 to T8

% Define torus properties
tor = define_tor(C,r);

% Find the number of nodes - every torus has an equal number of nodes
min_nodes = 100; % Minimum number of torus nodes


% Define strap sets
% straps = define_straps_WT(C,r,alpha_cone);
straps = define_straps_WT2(C,r,alpha_cone);

% Define HIAD loading
% Total Z direction reaction
Rz = 55000; % lbf
load = define_press(C,r,alpha_cone,Rz);

% END USER INPUT


%% BUILD MODEL
% Assemble torus elements
% [FEM, theta] = build_tor(C,tor,straps,load,min_nodes);
[FEM, theta] = build_tor_WT(C,tor,straps,load,min_nodes);

% Assemble interaction elements
pre_str = zeros(size(tor,1),1); % Interaction element prestrain
[FEM] = build_int(FEM,theta,C,tor,pre_str);

% Assemble link and strap elements
[FEM,strap_type,strap_EL_1] = build_links_straps(FEM,theta,C,tor,straps);


%% PLOT AND CONTROLS
% Modeling controlls
FEM.ANALYSIS = FE_controls0;
FEM.PLOT = plot_controls0;

FE_plot(FEM)
post_proc_driver1(FEM)

% END BUILD MODEL


%% EQUILIBRIUM
check_EQ(FEM)



%% RUN ANALYSIS
tic
[FEM_out] = increment_FE(FEM);
toc

% END RUN ANALYSIS


%% POST PROCESS RESULTS
% Shape
% FEM_out.PLOT.els = [0 0 0 1];
% FE_plot(FEM_out)

FEM_out.PLOT.undef = 0;

[k,Y_soft] = plot_inc2(FEM_out);
post_proc_driver2(FEM_out)

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














