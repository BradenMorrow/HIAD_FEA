% Driver for parameterized HIAD analyses
% August 9, 2016
clear

%% USER INPUT
% Define centerbody tieback location and torus centers
% [X Z] locations
[C,r] = pressure_tub_config;


alpha_cone = 70; % HIAD angle with vertical

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
% % % straps = define_straps_PT2(C,r,alpha_cone);
% % % % strap_response_22SEP16(150400,100,0,5300,.09375);

% straps = define_straps_22JUN17(C,r,alpha_cone);
straps = define_straps_28JUN17(C,r,alpha_cone);

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
% [FEM] = build_int(FEM,theta,C,tor,pre_str);
[FEM] = build_int_TT(FEM,theta,C,tor,pre_str,Ccon);

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
% plot_cord2(FEM_out,0.004448,fig)
plot_cord2(FEM_out,1,fig)


cord_test_SI(1000)






