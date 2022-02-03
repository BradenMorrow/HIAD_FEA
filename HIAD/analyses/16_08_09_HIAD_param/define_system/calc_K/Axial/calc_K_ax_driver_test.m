% function [K] = calc_K_ax_driver(r, inflation_P)
% function [K] = calc_K_ax_driver(n, I, A)
clear
n = 40;
I = 1e-8;
A = 1*100;




% Calculate the stiffness matrix for each element based on minor radius and inflation pressure.

%% Parameters

% Loading and elements
load = 1; % lb/in
inflation_P = 20; % psi  (This is an input)
load_width = 8; % in

% Geometry
r = 16; % Torus (minor) radius (in)  (This is an input)


%% Pre-process with quarter symmetry
% Pre-process geometry
[FEM, fix, arc_length] = torus_inp_calc_K_ax_test(n, I, A, inflation_P, load_width, r);

% Compile element types
bound = FEM.MODEL.B;
inflation_F = FEM.MODEL.F;
n_loaded_num = FEM.MODEL.n_loaded';
n_loaded = size(n_loaded_num,1);
FEM.ANALYSIS = FE_controls0_calc_K;
FEM.PLOT = plot_controls_calc_K;

FEM.OUT.U = bound*0;



%% Analyze, STEP 1 - initial shape
FEM0 = FEM;
FEM0.PASS.set_L = 1;

FEM0.OUT.Fext_inc = [bound bound]*0;

[FEM_out0] = increment_FE(FEM0);



%% Analyze, STEP 2 - Apply loading
FEM1 = FEM_out0;
FEM1.MODEL.F_pre = inflation_F;

FEM1.ANALYSIS = FE_controls1_calc_K;


force = fix*0;

force(end,2) = -load;
% remainder = (load_width/2)/arc_length - floor((load_width/2)/arc_length);
% last_node_width = arc_length*(1/2+remainder);
% 
% force((end-n_loaded+1):end, 2) = -load*(arc_length); % Calc the force on each node
% force(end,2) = force(end,2)/2; % Divide by 2 to account for quarter symmetry
% force((end-n_loaded+1),2) = -last_node_width*load;

F = force';
F = F(:);

FEM1.MODEL.F = F;
FEM1.MODEL.F_pt = [F*0 F];

FEM_out1 = increment_FE(FEM1);






%% Post proccess

Uinc = FEM_out1.OUT.Uinc;
Utip = -Uinc(n_loaded_num*6 - 4,:); % Displacement increments of the end of the torus
Utip = 2*Utip; % To account for the deflection on both sides of the structure
Utip(:,1) = []; % Remove zeros colum (We are not starting at 0 loading)
Utip = mean(Utip,1);

Finc = FEM_out1.OUT.Finc;
Ftip = Finc(2,:); % Load a the bottom support (this will be the total load on the structure in the y direction

% Fext = FEM_out1.OUT.Fext_inc;
% Fext = Fext(n_loaded_num*6-4,:);
% Ftip = sum(Fext,1); % Ftip is the sum of the external pressure applied

Ftip = 2*Ftip; % Because half the load was used for quarter symmetry
Ftip(:,1) = []; % Remove zeros colum




% figure(7)
% clf
% box on
% hold on

Fmax = min(Ftip);
Ftip = Ftip + (-Fmax);
% plot(Utip, Ftip, 'b-x');
% xlabel('Displacement (in)');
% ylabel('Load (lb)');




x = Utip';
y = Ftip';
B1 = polyfit(x,y,1);
K = B1(1);
Ycalc = B1(1)*x + B1(2);
% plot(x,Ycalc, 'rx-')

% legend('Actual delta','Best fit','location','northwest')


% fprintf('\nk = %g\n\n\n',K)











