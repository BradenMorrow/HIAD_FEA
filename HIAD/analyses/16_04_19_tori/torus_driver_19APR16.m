% Driver for torus analysis
% April 19, 2016

clear

%% START ANALYSIS
warning('on','all')
t0 = tic;


%% GENERIC GEOMETRY
% General geometric inputs
n_cable = 8; % Number of radial cables
el_int = 50; % Number of elements between strap nodes
cable0 = 0; % Measure to first cable (deg)
theta_support = [0 90 180 270]'*pi/180;

[theta,I_theta_cable,I_theta_support] = gen_geo(n_cable,cable0,el_int,theta_support);


%% MODEL INPUT
% Analysis inputs
job_title = 'torus_model_development_19APR16';

% Element indices
ind = indices(theta,I_theta_cable,I_theta_support);


%%%%
% MODIFY FOR REAL TORUS AND REAL TEST

% Torus major geometry
% Initially perfect
[tor.nodes,tor.R,tor.Utor0] = torus_geo(theta);

% Torus load history
% Initially uniform displacment
[U_pt] = cable_disp(ind,theta,I_theta_cable);
%%%%


% Torus minor geometry
% Representative inputs
tor.r = 6.67;
tor.p = 20;
tor.beta = 71;
tor.alpha = [210 330]';
tor.ELong = 80;
tor.GLH = 2670;
tor.Nint = 3;

% Generate FE model
FEM = gen_model(theta,I_theta_cable,I_theta_support,tor,U_pt);

% FE controls
[FEM.ANALYSIS] = FE_controls;
[FEM.PLOT] = plot_controls;
FE_plot(FEM)
visual_preshape

t_pre = toc(t0);


%% ANALYSIS
[FEM_out] = FE_solver(FEM);


%% POST PROCESS
t_tot = toc(t0);
t_an = t_tot - t_pre;
fprintf('\nPreprocessor time = %g s\nAnalysis time = %g s\n\n',t_pre,t_an)
FEM_out.t = t_tot;


% Post processing
% load('FEM_iter10.mat')
% FEM_out = FEM;
% save(job_title,'FEM_out')

% % Send text
% setpref('Internet','E_mail','andrew.c.young1@maine.edu');
% setpref('Internet','SMTP_Server','mail');
% sendmail('2073192615@vtext.com','Analysis Complete',...
%     sprintf('\n%s complete.\n\n%s\n',job_title,datestr(now)))

% system('shutdown -s')

