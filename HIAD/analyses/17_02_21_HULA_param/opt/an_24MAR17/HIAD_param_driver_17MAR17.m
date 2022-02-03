% Driver script for parameterized HIAD analysis
% February 21, 2017


%% INPUTS (53)
% Internal inflation pressure (psi)
in.p_i = [15
    15
    15
    15
    15
    15
    15];

% Braid angle (deg)
in.beta_i = [69
    69
    69
    69
    69
    69
    69];

% Location of cords on cross-section (deg)
in.alpha_i = [210 330
    210 330
    210 330
    210 330
    210 330
    210 330
    210 330];

% Cord stiffness factor
in.k_cord_fac_i = [1
    1
    1
    1
    1
    1
    1];

% Number of loop straps (set 1)
in.n_loop1 = [32
    32
    32
    32] + 0;

% Number of loop straps (set 2)
in.n_loop2 = [32
    32
    32] + 0;

% Number of radial strap sets
in.n_rad = 32; % 36; % 

% Loop strap pretension (set 1)
in.PT_loop1 = [100
    100
    100
    100];

% Loop strap pretension (set 2)
in.PT_loop2 = [100
    100
    100];

% Radial strap pretension
in.PT_rad = 200;

% Strap stiffness factor (loop set 1) (scale strap width)
in.k_loop1_fac = [1
    1
    1
    1];

% Strap stiffness factor (loop set 2) (scale strap width)
in.k_loop2_fac = [1
    1
    1];

% Strap stiffness factor (fore radials) (scale strap width)
in.k_rad_fore_fac = 1;

% Strap stiffness factor (aft radials) (scale strap width)
in.k_rad_aft_fac = 1;

[X] = get_X(in);

[out0] = HIAD_X_22MAR17(X);


%% ANALYSIS
% Run analysis
X = population(1,3:end)';
[param] = build_param(X);


tic
% % % [out] = HIAD_param_21FEB17(in);
% [out1] = HIAD_X_17MAR17(X);
[out2] = HIAD_X_22MAR17(X);
toc

% [k,F_soft] = plot_inc(out.FEM_out)
% [con] = get_con_17MAR17(out.k_0,out.FU)

% % % %%
% % % X1 = []';
% % % [in1] = build_param(X1);
% % % [out1] = HIAD_param_21FEB17(in1);
% % % 
% % % [k,F_soft] = plot_inc(out1.FEM_out);

%%
figure(100)
clf
box on
hold on
plot(out0.FU(:,2),out0.FU(:,1),'r.-')
% plot(out1.FU(:,2),out1.FU(:,1),'b.-')
plot(out2.FU(:,2),out2.FU(:,1),'b.-')

plot([0 8],[0 8]*5000,'k:','linewidth',1.5)
plot([0 15],[1 1]*30000,'k--')

ylim([0 50000])

xlabel('T6 Vertical Displacement (in)')
ylabel('Applied Load, Z Component (lbf)')
















