% Driver for HIAD non-axisymmetric tab study
% February 09, 2016

clear

warning('on','all')

t0 = tic;
% General geometric inputs
n_strap = 4; % Number of radial straps (divisible by 4)
n_strap2 = n_strap*4;
el_int = 3; % Number of elements between strap nodes

% Theta location of nodes
theta = linspace(0,2*pi,(n_strap2*el_int) + 1)';
theta(end) = [];
I_theta = (1:el_int:size(theta,1))'; % Strap indices

% Uniform pressure
p = .875; % .435;
% Total drag load
F_drag = 0; % 375000

% HIAD geometry
C = [185.185453 84.342298
	213.724769 94.729760
	242.558759 105.224474
	271.650278 115.812921
	300.963157 126.481936
	322.382105 124.113612];
r = [31.837/2 % Minor radii of tori
    31.837/2
    31.837/2
    31.837/2
    31.837/2
    12.735/2];


eps_in = [.0004386*3 % Loop1, aft1
    .0004386 % Loop1, aft2
    .0004386 % Loop1, aft3
    .0004386 % Loop1, fore1
    .0004386 % Loop1, fore2
    .0004386 % Loop1, fore3
    .0004386 % Loop2, aft1
    .0004386 % Loop2, aft2
    .0004386 % Loop2, aft3
    .0004386 % Loop2, fore1
    .0004386 % Loop2, fore2
    .0004386 % Loop2, fore3
    .0004386*5 % Radial, aft
    .0004386 % Chevron, aft
    .0004386 % Radial, fore
    .0004386]*2; % Chevron, fore

% Load elements
% Torus elements
[MODEL_tor1,EL_tor1] = tor1(theta,C(1,:),r(1));
[MODEL_tor2,EL_tor2] = tor2(theta,C(2,:),r(2));
[MODEL_tor3,EL_tor3] = tor3(theta,C(3,:),r(3));
[MODEL_tor4,EL_tor4] = tor4(theta,C(4,:),r(4));
[MODEL_tor5,EL_tor5] = tor5(theta,C(5,:),r(5));
[MODEL_tor6,EL_tor6] = tor6(theta,C(6,:),r(6));
consol_tor

% Interaction elements
[MODEL_int1,EL_int1] = int1(theta,C(1,:),r(1));
[MODEL_int2,EL_int2] = int2(theta,C(2,:));
[MODEL_int3,EL_int3] = int3(theta,C(3,:));
[MODEL_int4,EL_int4] = int4(theta,C(4,:));
[MODEL_int5,EL_int5] = int5(theta,C(5,:));
[MODEL_int6,EL_int6] = int6(theta,C(6,:));
consol_int

% Strap link elements
[MODEL_link,EL_link,str] = links(theta,I_theta,C,r);
consol_link

% Strap elements
[MODEL_strap,EL_strap,strap_ind] = straps(theta,I_theta,str);
consol_strap

% Element indices for post processing
FEM.MODEL.theta_ind = indices(theta,strap_ind,EL_link);

% FE controls
[FEM.ANALYSIS] = FE_controls;
[FEM.PLOT] = plot_controls;

% Visualize HIAD
% FE_plot(FEM)
post_proc_driver1


% FEM = apply_preten(FEM,eps_in);


t_pre = toc(t0);

% Analysis
[FEM_out] = increment_FE(FEM);


t_tot = toc(t0);
t_an = t_tot - t_pre;
fprintf('\nPreprocessor time = %g s\nAnalysis time = %g s\n\n',t_pre,t_an)
FEM_out.t = t_tot;


%% strap_ind


FEM_out.PLOT.fig = 1;
FEM_out.PLOT.undef = 1;
FEM_out.PLOT.def = 1;
FEM_out.PLOT.force = 0;
FEM_out.PLOT.scale = 100;
FEM_out.PLOT.els = [0 0 1 0]';
FE_plot(FEM_out)

% post_proc_driver2



% load('FEM_iter10.mat')
% FEM_out = FEM;

% % % job_title = 'out_05APR16_nonit_test';
% % % save(job_title,'FEM_out')
% % % 
% % % 
% % % setpref('Internet','E_mail','andrew.c.young1@maine.edu');
% % % setpref('Internet','SMTP_Server','mail');
% % % sendmail('2073192615@vtext.com','Analysis Complete',...
% % %     sprintf('\n%s complete.\n\n%s\n',job_title,datestr(now)))


%% To do
% X     Geometry
% X     Tori elements
% X     Link elements
% X     Strap elments
% X     Straps - tension only
% X     Pressure loading
% X     Follower loads
% X     First increment
% X     Save increment info [step res_error lambda cutbacks time]
% X     FE_plot view
% X     Convergence of interaction stiffness Izz
% X     Element indices for post processing
% X     Iterative versus non-iterative state determination process
% X     Change cutback size, 0.5 to 0.25 of LAMBDA0 - CANCELED
% X     Vectorization of follow force routines
% X     Fix Newton iteration warning
% Symmetry boundaries
% Further parallelize the assembly function
% Post processing results




% out_17MAR16_nonaxi1 = batch('HIAD_driver_09FEB16', 'Profile', 'local', 'Pool', 11);


