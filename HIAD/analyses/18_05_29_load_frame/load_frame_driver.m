% Analyze the response of a column under buckling.  
% Use a small perturbation force to induce buckling.
clear
clc


%% GEOMETRY
L_sleds = 15*12; % Members 1, in
L_top_rxn = 5*12; % Memebers 2, in
L_col = 11.5*12; % Members 3, in
L_brace_leg = 3*12; % Members 4, in
L_brace = L_brace_leg*sqrt(2); % Members 4, in

m1_w = 10.2; % Members 1, in (W10x77)
m1_h = 10.6;
m1_geom = [22.6 455 154 0 5.11]; % [A Izz Iyy ky J]
m1_wt = 77; % lb/ft

m2_w = 10; % Members 2, in (W10x45)
m2_h = 10;
m2_geom = [13.3 248 5.34 0 1.51]; % [A Izz Iyy ky J]
m2_wt = 45; % lb/ft

m3_w = 6; % Members 3, in (HSS6x6x3/8)
m3_h = 6;
m3_geom = [7.58 39.5 39.5 0 64.6]; % [A Izz Iyy ky J]
m3_wt = 46; % lb/ft

m4_w = 3; % Members 4, in (HSS3x3x1/4)
m4_h = 3;
m4_geom = [2.44 3.02 3.02 0 5.08]; % [A Izz Iyy ky J]
m4_wt = 8.78; % lb/ft

mRIG_geom = [22.6 455 154 0 5.11]*1.2; % [A Izz Iyy ky J]
weight = m1_wt*L_sleds/12*2 + m2_wt*L_top_rxn/12*1 + m3_wt*L_col/12*2 + m4_wt*L_brace/12*4;
h_in = (L_col - m1_h - m2_h*2 - 56.2)/12;
h_out = (L_col - m1_h - m2_h*2 - 56.2 - 40)/12;

%% NODES
nodes = [0 L_top_rxn/2 - m1_w/2 m1_h/2
    -L_sleds/2 L_top_rxn/2 - m1_w/2 m1_h/2
    L_sleds/2 L_top_rxn/2 - m1_w/2 m1_h/2
    -(L_brace_leg + m3_w/2 + m1_h/2) L_top_rxn/2 - m1_w/2 m1_h/2
    (L_brace_leg + m3_w/2 + m1_h/2) L_top_rxn/2 - m1_w/2 m1_h/2
    -(L_brace_leg + m3_w/2) L_top_rxn/2 - m1_w/2 m1_h
    (L_brace_leg + m3_w/2) L_top_rxn/2 - m1_w/2 m1_h
    0 L_top_rxn/2 - m1_w/2 m1_h
    -m3_w/2 L_top_rxn/2 - m1_w/2 m1_h + L_brace_leg
    m3_w/2 L_top_rxn/2 - m1_w/2 m1_h + L_brace_leg
    0 L_top_rxn/2 - m1_w/2 m1_h + L_brace_leg + m3_w/2
    0 L_top_rxn/2 - m1_w/2 L_col - m2_h/2
    0 L_top_rxn/2 - m1_w/2 - m3_w/2 L_col - m2_h/2
    0 0 L_col - m2_h/2
    0 -L_top_rxn/2 + m1_w/2 m1_h/2
    -L_sleds/2 -L_top_rxn/2 + m1_w/2 m1_h/2
    L_sleds/2 -L_top_rxn/2 + m1_w/2 m1_h/2
    -(L_brace_leg + m3_w/2 + m1_h/2) -L_top_rxn/2 + m1_w/2 m1_h/2
    (L_brace_leg + m3_w/2 + m1_h/2) -L_top_rxn/2 + m1_w/2 m1_h/2
    -(L_brace_leg + m3_w/2) -L_top_rxn/2 + m1_w/2 m1_h
    (L_brace_leg + m3_w/2) -L_top_rxn/2 + m1_w/2 m1_h
    0 -L_top_rxn/2 + m1_w/2 m1_h
    -m3_w/2 -L_top_rxn/2 + m1_w/2 m1_h + L_brace_leg
    m3_w/2 -L_top_rxn/2 + m1_w/2 m1_h + L_brace_leg
    0 -L_top_rxn/2 + m1_w/2 m1_h + L_brace_leg + m3_w/2
    0 -L_top_rxn/2 + m1_w/2 L_col - m2_h/2
    0 -L_top_rxn/2 + m1_w/2 + m3_w/2 L_col - m2_h/2];

nodes(:,1) = nodes(:,1) + L_sleds/2;


%% CONNECT
% connect = [(1:n - 1)' (2:n)' 4*ones(size(nodes,1) - 1,1)];
connect1 = [2 4 % 1 SLED
    4 1 % 2 SLED
    1 5 % 3 SLED
    5 3 % 4 SLED
    4 6 % 5 RIG
    1 8 % 6 RIG
    5 7 % 7 RIG
    6 9 % 8 BRACE
    8 11 % 9 COL
    7 10 % 10 BRACE
    9 11 % 11 RIG
    10 11 % 12 RIG
    11 12 % 13 COL
    12 13 % 14 RIG
    13 14]; % 15 CROSS

connect = [connect1
    connect1 + 14];
connect(end,:) = [14 27];
connect = [connect 2*ones(size(connect,1),1)];


%% ORIENT
orientation = zeros(size(connect));
orientation(:,2) = L_top_rxn/2 - m1_w/2;
orientation(:,3) = 50;
orientation(16:30,2) = -L_top_rxn/2 + m1_w/2;
orientation([15 30],:) = [L_sleds/2 0 150
    L_sleds/2 0 150];
% % % orientation([9 13 9 + 15 13 + 15],1) = 0;
% % % orientation([9 13 9 + 15 13 + 15],3) = 0;

%% BOUND
fix = zeros(size(nodes,1),6);
fix(2,[1 2 3]) = 1;
fix(3,[2 3]) = 1;
fix(2 + 14,[1 2 3]) = 1;
fix(3 + 14,[2 3]) = 1;

bound = fix';
bound = bound(:);


figure(10)
clf
box on
hold on
axis equal
plot3(nodes(:,1),nodes(:,2),nodes(:,3),'ko')
plot3(orientation(:,1),orientation(:,2),orientation(:,3),'rx')
view(3)

for i = 1:size(connect,1)
    line(nodes(connect(i,1:2),1)',nodes(connect(i,1:2),2)',nodes(connect(i,1:2),3)');
end


%% LOAD
force = fix*0;
force(14,3) = 161*1.2; % Case 1, kip
% force(14,3) = -100*1.2; % Case 2, kip
% force(14,[1 2 3]) = [.1 0 1]*161*1.2; % Case 3, kip
% force(14,[1 2 3]) = [.1 0 -1]*100*1.2; % Case 4, kip
F = force';
F = F(:);

U0 = F*0;

%% MATERIALS
E = 29000;

% Preallocate element structure
EL(size(connect,1)).el = [];
EL(size(connect,1)).el_in.nodes_ij = [];
EL(size(connect,1)).el_in.orient_ij = [];
EL(size(connect,1)).el_in0.break = [];
EL(size(connect,1)).el_in0.mat = [];
EL(size(connect,1)).el_in0.geom = [];
EL = EL';

geom1 = [m1_geom
    m1_geom
    m1_geom
    m1_geom
    mRIG_geom
    mRIG_geom
    mRIG_geom
    m4_geom
    m3_geom
    m4_geom
    mRIG_geom
    mRIG_geom
    m3_geom
    mRIG_geom
    m2_geom];
geom = [geom1
    geom1];
    
for i = 1:size(connect,1)
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el2'; % Corotational formulation, linear elastic
    
    % Special element input
    EL(i).el_in0.break = 0;
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = geom(i,:); % [A Izz Iyy ky J]
end


FEM.EL = EL;

FEM.MODEL.nodes = nodes;
FEM.MODEL.orientation = orientation;
FEM.MODEL.connect = connect;
FEM.MODEL.B = bound;
FEM.MODEL.F = F;
FEM.MODEL.F_pt = [F*0 F];

FEM.MODEL.F_pre = F*0;
FEM.MODEL.Dinc = 0;
FEM.MODEL.D = -1;
FEM.MODEL.Di = 0; % n*6 - 4; % The dof that will be used for the b matrix in displacement solver
FEM.PASS.Fext = F*0;

FEM.ANALYSIS = FE_controls_load_frame;
FEM.PLOT = plot_controls_load_frame;

FEM.OUT.U = bound*0;
FE_plot(FEM)


%% Analyze, STEP 1 - initial shape
[FEM_out] = increment_FE(FEM);

FE_plot(FEM_out)

el_loads = FEM_out.OUT.fint_el(:,:,2)';






% Plotting
%% Sled members
A = el_loads(1:4,[1 7]);
A(:,1) = -A(:,1);
A = A';
V = el_loads(1:4,[2 8]);
V(:,2) = -V(:,2);
V = V';
M = el_loads(1:4,[6 12]);
M(:,1) = -M(:,1);
M = M';

figure(2)
clf

subplot(3,1,1)
box on
hold on
plot(nodes([2 4 4 1 1 5 5 3],1)/12,A(:),'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
title('Sled Member')
xlabel('Length (ft)')
ylabel('Axial (kip)')
xlim([0 L_sleds/12])
ylim([-100 100])
sled_axial = [nodes([2 4 4 1 1 5 5 3],1)'/12
    A(:)'];

subplot(3,1,2)
box on
hold on
plot(nodes([2 4 4 1 1 5 5 3],1)/12,V(:),'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Shear (kip)')
xlim([0 L_sleds/12])
ylim([-75 75])
sled_shear = [nodes([2 4 4 1 1 5 5 3],1)'/12
    V(:)'];

subplot(3,1,3)
box on
hold on
plot(nodes([2 4 4 1 1 5 5 3],1)/12,M(:)/12,'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Moment (kip*ft)')
xlim([0 L_sleds/12])
ylim([-225 225])
sled_moment = [nodes([2 4 4 1 1 5 5 3],1)'/12
    M(:)'/12];


%% Posts
A = el_loads([9 13],[1 7]);
A(:,1) = -A(:,1);
A = A';
Vy = el_loads([9 13],[2 8]);
Vy(:,2) = -Vy(:,2);
Vy = Vy';
Mz = el_loads([9 13],[6 12]);
Mz(:,2) = -Mz(:,2);
Mz = Mz';
Vz = el_loads([9 13],[3 9]);
Vz(:,2) = -Vz(:,2);
Vz = Vz';
My = el_loads([9 13],[5 11]);
My(:,2) = -My(:,2);
My = My';

figure(3)
clf

subplot(1,5,1)
box on
hold on
plot(A(:),nodes([8 11 11 12],3)/12,'k-','linewidth',2)
plot([0 0],[-1000 1000],'b--')
ylabel('Length (ft)')
xlabel('Axial (kip)')
xlim([-150 150])
ylim([0 L_col/12])
column_axial = [nodes([8 11 11 12],3)'/12
    A(:)'];

subplot(1,5,2)
box on
hold on
plot(Vy(:),nodes([8 11 11 12],3)/12,'k-','linewidth',2)
plot([0 0],[-1000 1000],'b--')
ylabel('Length (ft)')
xlabel('Shear Y (kip)')
xlim([-25 25])
ylim([0 L_col/12])
column_shear_y = [nodes([8 11 11 12],3)'/12
    Vy(:)'];

subplot(1,5,3)
box on
hold on
plot(Mz(:)/12,nodes([8 11 11 12],3)/12,'k-','linewidth',2)
title('Column')
plot([0 0],[-1000 1000],'b--')
ylabel('Length (ft)')
xlabel('Moment Z (kip*ft)')
xlim([-100 100])
ylim([0 L_col/12])
column_moment_z = [nodes([8 11 11 12],3)'/12
    Mz(:)'/12];

subplot(1,5,4)
box on
hold on
plot(Vz(:),nodes([8 11 11 12],3)/12,'k-','linewidth',2)
plot([0 0],[-1000 1000],'b--')
ylabel('Length (ft)')
xlabel('Shear Z (kip)')
xlim([-2 2])
ylim([0 L_col/12])
column_shear_z = [nodes([8 11 11 12],3)'/12
    Vz(:)'];

subplot(1,5,5)
box on
hold on
plot(My(:)/12,nodes([8 11 11 12],3)/12,'k-','linewidth',2)
plot([0 0],[-1000 1000],'b--')
ylabel('Length (ft)')
xlabel('Moment Y (kip*ft)')
xlim([-15 15])
ylim([0 L_col/12])
column_moment_y = [nodes([8 11 11 12],3)'/12
    My(:)'/12];



%% Cross member
A = el_loads([15 30],[1 7]);
A(:,1) = -A(:,1);
A = A';
V = el_loads([15 30],[2 8]);
V(:,2) = -V(:,2);
V = V';
M = el_loads([15 30],[6 12]);
M(:,1) = -M(:,1);
M = M';
V2 = el_loads([15 30],[3 9]);
V2(:,2) = -V2(:,2);
V2 = V2';
M2 = el_loads([15 30],[5 11]);
M2(:,1) = -M2(:,1);
M2 = M2';

figure(4)
clf

subplot(5,1,1)
box on
hold on
plot(nodes([13 14 14 27],2)/12,A(:),'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
title('Cross Reaction Bar')
xlabel('Length (ft)')
ylabel('Axial (kip)')
xlim([-L_top_rxn/2 L_top_rxn/2]/12)
ylim([-2 2])
cross_axial = [nodes([13 14 14 27],2)'/12
    A(:)'];

subplot(5,1,2)
box on
hold on
plot(nodes([13 14 14 27],2)/12,V(:),'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Shear (kip)')
xlim([-L_top_rxn/2 L_top_rxn/2]/12)
ylim([-125 125])
cross_shear_y = [nodes([13 14 14 27],2)'/12
    V(:)'];

subplot(5,1,3)
box on
hold on
plot(nodes([13 14 14 27],2)/12,M(:)/12,'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Moment (kip*ft)')
xlim([-L_top_rxn/2 L_top_rxn/2]/12)
ylim([-225 225])
cross_moment_z = [nodes([13 14 14 27],2)'/12
    M(:)'/12];

subplot(5,1,4)
box on
hold on
plot(nodes([13 14 14 27],2)/12,V2(:),'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Shear (kip)')
xlim([-L_top_rxn/2 L_top_rxn/2]/12)
ylim([-25 25])
cross_shear_z = [nodes([13 14 14 27],2)'/12
    V2(:)'];

subplot(5,1,5)
box on
hold on
plot(nodes([13 14 14 27],2)/12,M2(:)/12,'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Moment (kip*ft)')
xlim([-L_top_rxn/2 L_top_rxn/2]/12)
ylim([-25 25])
cross_moment_y = [nodes([13 14 14 27],2)'/12
    M2(:)'/12];


%% Braces
A1 = el_loads(8,[1 7]);
A1(1) = -A1(1);
V1 = el_loads(8,[2 8]);
V1(:,2) = -V1(:,2);
V1 = V1';
M1 = el_loads(8,[6 12]);
M1(:,1) = -M1(:,1);
M1 = M1';

figure(5)
clf

subplot(3,1,1)
box on
hold on
plot([0 L_brace]/12,A1,'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
title('Brace')
xlabel('Length (ft)')
ylabel('Axial (kip)')
xlim([0 L_brace/12])
ylim([-150 150])
brace1_axial = [[0 L_brace]/12
    A1(:)'];

subplot(3,1,2)
box on
hold on
plot([0 L_brace]/12,V1(:),'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Shear (kip)')
xlim([0 L_brace/12])
ylim([-125 125])
brace1_shear = [[0 L_brace]/12
    V1(:)'];

subplot(3,1,3)
box on
hold on
plot([0 L_brace]/12,M1(:)/12,'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Moment (kip*ft)')
xlim([0 L_brace/12])
ylim([-225 225])
brace1_moment = [[0 L_brace]/12
    M1(:)'/12];


A2 = el_loads(10,[1 7]);
A2(1) = -A2(1);
V2 = el_loads(10,[2 8]);
V2(:,2) = -V2(:,2);
V2 = V2';
M2 = el_loads(10,[6 12]);
M2(:,1) = -M2(:,1);
M2 = M2';

figure(6)
clf

subplot(3,1,1)
box on
hold on
plot([0 L_brace]/12,A2,'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
title('Brace')
xlabel('Length (ft)')
ylabel('Axial (kip)')
xlim([0 L_brace/12])
ylim([-150 150])
brace2_axial = [[0 L_brace]/12
    A2(:)'];

subplot(3,1,2)
box on
hold on
plot([0 L_brace]/12,V2(:),'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Shear (kip)')
xlim([0 L_brace/12])
ylim([-125 125])
brace2_shear = [[0 L_brace]/12
    V2(:)'];

subplot(3,1,3)
box on
hold on
plot([0 L_brace]/12,M2(:)/12,'k-','linewidth',2)
plot([-1000 1000],[0 0],'b--')
xlabel('Length (ft)')
ylabel('Moment (kip*ft)')
xlim([0 L_brace/12])
ylim([-225 225])
brace2_moment = [[0 L_brace]/12
    M2(:)'/12];





%%
% sled_axial
% sled_shear
% sled_moment
% column_axial
% column_shear_y
% column_moment_z
% column_shear_z
% column_moment_y
cross_axial
cross_shear_y
cross_moment_z
% cross_shear_z
% cross_moment_y
% brace1_axial
% brace1_shear
% brace1_moment
% brace2_axial
% brace2_shear
% brace2_moment

% DELTA_vertical = FEM_out.OUT.U(14*6 - 3)
% DELTA_lateral = FEM_out.OUT.U(14*6 - 5)








