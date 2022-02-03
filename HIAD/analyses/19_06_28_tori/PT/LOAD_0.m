function [obj] = LOAD_0(eps0)

% Driver for parameterized HIAD analyses
% August 9, 2016
% clear

%% USER INPUT
% Define centerbody tieback location and torus centers
% [X Z] locations
d_alpha = eps0(end);
eps0 = eps0(1:end - 1);

[C,r] = load_test_config(d_alpha);


alpha_cone = 0; % HIAD angle with vertical

% Define torus connectivities
Ccon = [1 2]; % T1 to T2

% Define torus properties
tor = define_tor(C,r);

% Find the number of nodes - every torus has an equal number of nodes
min_nodes = 100; % Minimum number of torus nodes


% Define strap sets
% % % straps = define_straps_PT2(C,r,alpha_cone);
% % % % strap_response_22SEP16(150400,100,0,5300,.09375);

% straps = define_straps_22JUN17(C,r,alpha_cone);
straps = define_straps_05JUL17(C,r,alpha_cone,eps0);

% Define HIAD loading
% Total Z direction reaction
% Rz = 0; % 375000; % lbf
% load = define_press(C,r,alpha_cone,Rz);

% END USER INPUT


%% BUILD MODEL


% Assemble torus elements
[FEM, theta] = build_tor(C,tor,straps,0,min_nodes);

% Assemble interaction elements
C1 = [C(2:end,1) - C(1:end - 1,1) C(2:end,2) - C(1:end - 1,2)].^2;
C1 = (C1(:,1) + C1(:,2)).^.5;
r1 = [r(1) + r(2)];

pre_str = (C1 - r1)./r1;
% pre_str = zeros(size(tor,1),1); % Interaction element prestrain

[FEM] = build_int_TT(FEM,theta,C,tor,pre_str,Ccon);

% Assemble link and strap elements
[FEM,strap_type,strap_EL_1] = build_links_straps(FEM,theta,C,tor,straps);

% Modeling controlls
FEM.ANALYSIS = FE_controls_PT;
FEM.PLOT = plot_controls0;



% Initialize cord force arrays
FEM.OUT.cord_f = zeros(50,7);
th = size(FEM.MODEL.theta,1);
for i = 1:2
    FEM.OUT.cord_f(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(1);
end

FEM.OUT.cord_f2 = zeros(50,7);
th = size(FEM.MODEL.theta,1);
for i = 1:2
    FEM.OUT.cord_f2(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(2);
end


a = 1;

post_proc_driver1
FE_plot(FEM)
% post_proc_driver_dis

% END BUILD MODEL


%% RUN ANALYSIS
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
    mean(f(strap_type == 20))]

% % % f_target = 20*ones(size(f_strap));
% % % f_target(end - 1:end) = f_target(end - 1:end)*2;

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

% df = f_strap - f_target

obj_f = sum((f_target - f_strap).^2);


% Shape objective
U2 = reorg_vec(FEM_out.OUT.U);

ind = ((1:size(C,1) - 1)' - 1)*size(theta,1)' + 1;
n0 = FEM.MODEL.nodes(ind,:);
n1 = n0 + U2(ind,1:3);

[obj_d] = get_def_con(n0,n1,alpha_cone);


figure(1)
clf
box on
hold on
plot(n0(:,1),n0(:,3),'bx')
plot(n1(:,1),n1(:,3),'ro')
plot([0 80],[0 80*tand(20)] - tand(20)*n0(1,1) + n0(1,3),'k-')

% % % x0 = n0(1,1) - r(1)*sind(alpha_cone);
% % % z0 = n0(1,3) - r(1)*cosd(alpha_cone);
% % % alpha = [atan2d(n1(1,3) - z0,n1(1,1) - x0) - 20
% % %     atan2d(n1(2,3) - z0,n1(2,1) - x0) - 20
% % %     atan2d(n1(3,3) - z0,n1(3,1) - x0) - 20
% % %     atan2d(n1(4,3) - z0,n1(4,1) - x0) - 20
% % %     atan2d(n1(5,3) - z0,n1(5,1) - x0) - 20
% % %     atan2d(n1(6,3) - z0,n1(6,1) - x0) - 20
% % %     atan2d(n1(7,3) - z0,n1(7,1) - x0) - 20];
% % % 
% % % obj_d = sum(alpha.^2)*10;

obj = obj_f + obj_d;


% % % if true
% % %     th = linspace(0,2*pi,100)';
% % %     
% % %     figure(101)
% % %     clf
% % %     box on
% % %     hold on
% % %     axis equal
% % %     
% % %     for i = 1:size(n0,1)
% % %         plot(n0(i,1) + r(i)*cos(th),n0(i,3) + r(i)*sin(th),'k-')
% % %         plot(n1(i,1) + r(i)*cos(th),n1(i,3) + r(i)*sin(th),'k--')
% % %         
% % %     end
% % %     
% % % end


end









