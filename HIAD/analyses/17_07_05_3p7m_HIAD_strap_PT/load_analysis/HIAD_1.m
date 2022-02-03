% % % function [obj] = HIAD_1(eps0)

% Initial strap prestrain
eps0 = [...
    0.0727333551447135
    0.0795015875846628
    0.0866101425207137
    0.0834698935823437
    0.076473154877301
    0.0814486980890768
    0.088414536333364
    0.0761890296702292
    0.0792316883797731
    0.0841353416593145
    0.0885301248727806
    0.0816917676417207
    0.0876895260793095
    0.0830229723010519
    0.119561387407005
    0.110902216991374
    0.102829985012598
    0.0918319252017059
    -1.05841417549846];

% Driver for parameterized HIAD analyses
% August 9, 2016
% clear

%% USER INPUT
% Define centerbody tieback location and torus centers
% [X Z] locations
d_alpha = eps0(end);
eps0 = eps0(1:end - 1);

[C,r] = pressure_tub_config(d_alpha);

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

% straps = define_straps_22JUN17(C,r,alpha_cone);
straps = define_straps_05JUL17(C,r,alpha_cone,eps0);

% Define HIAD loading
% Total Z direction reaction
Rz = 0; % .0000001; % 375000; % lbf
load = define_press(C,r,alpha_cone,Rz);

% END USER INPUT


%% BUILD MODEL
% Assemble torus elements
[FEM, theta] = build_tor(C,tor,straps,load,min_nodes);

% Assemble interaction elements
C1 = [C(2:end,1) - C(1:end - 1,1) C(2:end,2) - C(1:end - 1,2)].^2;
C1 = (C1(:,1) + C1(:,2)).^.5;
r1 = [r(1)
    r(1) + r(2)
    r(2) + r(3)
    r(3) + r(4)
    r(4) + r(5)
    r(5) + r(6)
    r(6) + r(7)
    r(7) + r(8)];

pre_str = (C1 - r1)./r1;

[FEM] = build_int_TT(FEM,theta,C,tor,pre_str,Ccon);

% Assemble link and strap elements
[FEM,strap_type,strap_EL_1] = build_links_straps(FEM,theta,C,tor,straps);

% Modeling controlls
FEM.ANALYSIS = FE_controls_PT0;
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



% % % FE_plot(FEM)
% % % post_proc_driver1
% % % post_proc_driver_dis

% END BUILD MODEL


%% RUN ANALYSIS (PRETENSION)
% tic
[FEM_out] = increment_FE(FEM);
% toc

% END RUN ANALYSIS


%%
% Strap force objective
strap_ID = (strap_EL_1:strap_EL_1 + size(strap_type,1) - 1)';
f = FEM_out.OUT.fint_el(7,strap_ID,end);
f = permute(f,[2 3 1]);

f_strap = [mean(f(strap_type == 1))
    mean(f(strap_type == 2))
    mean(f(strap_type == 3))
    mean(f(strap_type == 4))
    mean(f(strap_type == 5))
    mean(f(strap_type == 6))
    mean(f(strap_type == 7))
    mean(f(strap_type == 8))
    mean(f(strap_type == 9))
    mean(f(strap_type == 10))
    mean(f(strap_type == 11))
    mean(f(strap_type == 12))
    mean(f(strap_type == 13))
    mean(f(strap_type == 14))
    mean(f(strap_type == 15))
    mean(f(strap_type == 16))
    mean(f(strap_type == 17))
    mean(f(strap_type == 20))];

f_target = [50
    50
    70
    60
    50
    50
    70
    50
    50
    65
    65
    50
    70
    50
    50
    50
    40
    40];


obj_f = sum((f_target - f_strap).^2);


% Shape objective
U2 = reorg_vec(FEM_out.OUT.U);

ind = ((1:size(C,1) - 1)' - 1)*size(theta,1)' + 1;
n0 = FEM.MODEL.nodes(ind,:);
n1 = n0 + U2(ind,1:3);

[obj_d] = get_def_con(n0,n1,alpha_cone);



%% RUN ANALYSIS (EXTERNAL LOADING)
FEM1 = FEM_out;

% % % % Define loading
% % % Fz = sum(FEM1.MODEL.F_pt(3:6:end));
% % % FEM1.MODEL.F_pt = FEM1.MODEL.F_pt*375000/Fz;

% Define HIAD loading
% Total Z direction reaction
Rz = 9000; % 375000; % 0; % .0000001; % lbf
C1 = [C(1,:)
    n1(:,[1 3])];
load = define_press(C1,r,alpha_cone,Rz);
[FEM_loading,~] = build_tor(C1,tor,straps,load,min_nodes);
FEM1.MODEL.F_pt(1:size(FEM_loading.MODEL.F_pt,1),:) = FEM_loading.MODEL.F_pt;

% Controls
[FEM1.ANALYSIS] = FE_controls1;

% Analyze
[FEM1_out] = increment_FE(FEM1);




%% POST PROCESS RESULTS
% Shape
FE_plot(FEM1_out)

FEM1_out.PLOT.undef = 0;
post_proc_driver2(FEM1_out)

% Load deformation
[k] = plot_out(FEM1_out);

save('FEM_st_minus','FEM_out')

%% Strap response
fig_1 = 200;
strap_forces_SI_pub(FEM1_out,straps,strap_type,strap_EL_1,fig_1)
strap_test_SI_pub(fig_1)



%%
fig = 1010;
% % plot_cord2(FEM1_out,0.004448,fig)
plot_cord2(FEM1_out,1,fig)


cord_test_SI(1010)








































