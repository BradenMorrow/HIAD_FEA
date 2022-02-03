% Driver for parameterized HIAD analyses
% August 9, 2016
% clear

%% USER INPUT
% Define centerbody tieback location and torus centers
% [X Z] locations
[C,r] = pressure_tub_config;

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

alpha_cone = 70; % HIAD angle with vertical

% Define torus connectivities
Ccon = [1 2 % Centerbody to T1
    2 3 % T1 to T2
    3 4 % T2 to T3
    4 5 % T3 to T4
    5 6 % T4 to T5
    6 7]; % T5 to T6

% Define torus properties
tor = define_tor(C,r);

% Find the number of nodes - every torus has an equal number of nodes
min_nodes = 100; % Minimum number of torus nodes


% Define strap sets
straps = define_straps_PT3(C,r,alpha_cone);

% Define HIAD loading
% Total Z direction reaction
Rz = 9000; % 375000; % lbf
load = define_press(C,r,alpha_cone,Rz);

% END USER INPUT


%% BUILD MODEL
% Assemble torus elements
[FEM, theta] = build_tor(C,tor,straps,load,min_nodes);

% Assemble interaction elements
pre_str = zeros(size(tor,1),1); % Interaction element prestrain
[FEM] = build_int(FEM,theta,C,tor,pre_str);

% Assemble link and strap elements
[FEM,strap_type,strap_EL_1] = build_links_straps(FEM,theta,C,tor,straps);

% Modeling controlls
FEM.ANALYSIS = FE_controls0;
FEM.PLOT = plot_controls0;

% Initialize cord force arrays
FEM.OUT.cord_f = zeros(50,7);
th = size(FEM.MODEL.theta,1);
for i = 1:8
    FEM.OUT.cord_f(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(1);
end

FEM.OUT.cord_f2 = zeros(50,7);
th = size(FEM.MODEL.theta,1);
for i = 1:8
    FEM.OUT.cord_f2(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(2);
end



FE_plot(FEM)
post_proc_driver1
post_proc_driver_dis

% END BUILD MODEL


%% RUN ANALYSIS
tic
[FEM_out] = increment_FE(FEM);
toc

% END RUN ANALYSIS


%% POST PROCESS RESULTS
% Shape
FE_plot(FEM_out)

FEM_out.PLOT.undef = 0;
post_proc_driver2(FEM_out)

% Load deformation
[k] = plot_out(FEM_out);

save('FEM_st_minus','FEM_out')


%%
% Strap response
fig_1 = 200;
strap_forces_SI(FEM_out,straps,strap_type,strap_EL_1,fig_1)
strap_test_SI(fig_1)


% FE_plot(FEM_out)


% END POST PROCESS RESULTS




%%
fig = 1000;
plot_cord2(FEM_out,0.004448,fig)


cord_test_SI(1000)






