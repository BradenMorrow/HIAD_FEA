function [K] = calc_K_shear_driver(r, inflation_P)
% function [K] = calc_K_shear_driver(n, I, A)
% clear
n = 31;
I = 1e-7;
A = 1;



% Calculate the stiffness matrix for each element based on minor radius and inflation pressure.


% clear

%% Parameters

% Loading and elements
load = 1; % lb/in
% inflation_P = 20; % psi   (This is an input)
load_width = 8; % in

% Geometry
% r = 16; % Torus (minor) radius (in)   (This is an input)


%% Pre-process with quarter symmetry
% Pre-process geometry
[FEM, fix] = torus_inp_calc_K_shear(n, I, A, inflation_P, load_width, r);

bound = FEM.MODEL.B;
inflation_F = FEM.MODEL.F;

FEM.ANALYSIS = FE_controls0_calc_K;
FEM.PLOT = plot_controls_calc_K;

FEM.OUT.U = bound*0;



%% Analyze, STEP 1 - pressurize
FEM0 = FEM;
FEM0.PASS.set_L = 1;

FEM0.OUT.Fext_inc = [bound bound]*0;

[FEM_out0] = increment_FE(FEM0);

% FE_plot(FEM_out0)


%% Analyze, STEP 2 - Apply loading
FEM1 = FEM_out0;
FEM1.MODEL.F_pre = inflation_F;

% [U2] = reorg_vec(FEM_out0.OUT.U); % Reorganize U vector
% FEM1.MODEL.nodes = FEM1.MODEL.nodes + U2(:,1:3); % Update nodal locations
% FEM1.MODEL.orientation(:,1:2) = FEM1.MODEL.nodes(:,1:2);

FEM1.ANALYSIS = FE_controls1_calc_K;

force = fix*0;
m_node = floor(n/2) + rem(n,2);
force(m_node,1) = load;

F = force';
F = F(:);

FEM1.MODEL.F = F;
FEM1.MODEL.F_pt = [F*0 F];

FEM_out1 = increment_FE(FEM1);


% FE_plot(FEM_out1)



%% Post proccess

Uinc = FEM_out1.OUT.Uinc;
Utip = Uinc(m_node*6 - 5,:); % Displacement increments of the top of section
Utip = Utip*2; % Double displacement to account for bot sides of section
Utip(:,1) = []; % Remove zeros colum (We are not starting at 0 loading)
Utip = mean(Utip,1);

Finc = FEM_out1.OUT.Finc;
Ftip = Finc(m_node*6 - 5,:); % Load on the structure in the x direction at the top middle node
Ftip(:,1) = []; % Remove zeros colum


% figure(5)
% clf
% box on
% hold on

% % % Fmin = min(Ftip);
% % % Ftip = Ftip + (-Fmin);
% plot(Utip, Ftip, 'b-x');
% xlabel('Displacement (in)');
% ylabel('Load (lb)');



x = Utip';
y = Ftip';
% B1 = polyfit(x,y,1);
% K = B1(1);
K = (y(2) - y(1))/(x(2) - x(1));

% Ycalc = B1(1)*x + B1(2);
% plot(x,Ycalc, 'rx-')

% legend('Actual delta','Best fit','location','northwest')


% fprintf('\nk = %g\n\n\n',K)










