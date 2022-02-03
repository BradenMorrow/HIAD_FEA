% Driver for torus analysis
% April 19, 2016

clear

%% START ANALYSIS
set_working_dir
warning('on','all')
t0 = tic;


%% GENERIC GEOMETRY
% General geometric inputs
n_cable = 8; % Number of radial cables
el_int = 21; % 21; % Number of elements between cable nodes
cable0 = 11.25; % Measure to first cable (deg)
theta_support = (45:90:360)'*pi/180;

[theta,I_theta_cable,I_theta_support] = gen_geo(n_cable,cable0,el_int,theta_support);


%% MODEL INPUT
% Analysis inputs
job_title = 'torus_model_development_10MAY16';

% % % % Create variables for plotting test data
% % % tor_test_plot(theta)

% Obtain torus test specimen specifications and initial shape
[tor.nodes,tor.R,tor.Utor0] = tor_spec(theta);

% Torus specifications
tor.r = 6.7; % Minor radius (in)
tor.p = 20; % Inflation pressure (psi)
tor.beta = 71; % Braid angle (deg)
tor.alpha = [210 330]'; % Location of cords (deg)
tor.ELong = 80; % Longitudinal shell modulus (lb/in)
tor.GLH = 2670; % In-plane shear modulus (lb/in)
tor.Nint = 3; % Number of integration points

% Generate FE model
FEM0 = gen_model(theta,I_theta_cable,I_theta_support,tor);
ind = FEM0.el_ind;

% FE controls
[FEM0.ANALYSIS] = FE_controls0;
[FEM0.PLOT] = plot_controls;
FE_plot(FEM0)
visual_preshape(FEM0)

t_pre = toc(t0);


%% ANALYSIS
[FEM0.ANALYSIS] = FE_controls_prestrain;
U2 = reorg_vec(FEM0.MODEL.U_pt(1:size(theta,1)*6,2));
R = hypot(U2(:,1),U2(:,2));
u = [U2(:,1)./R U2(:,2)./R];
th2 = atan2(u(:,2),u(:,1)) - theta;

%%
th3 = ones(size(th2));
th3(th2 > -3.15 & th2 < -3.14 | th2 < -9.4) = -1;
R = R.*th3;
% 
% figure(7)
% clf
% box on
% hold on
% plot(R)
% plot(th3)

%%

% th3(th3 < -9.4) = -1;


for i = 1:size(theta,1)
    FEM0.EL(i).el_in0.flex.e = FEM0.EL(i).el_in0.flex.e + R(i)*.005;
end
[FEM_out0] = FE_solver(FEM0);
FE_plot(FEM_out0)
plot_tor_shape(FEM_out0)


for j = 1:3
    for i = 1:size(theta,1)
        FEM_out0.EL(i).el_in0.flex.e = FEM0.EL(i).el_in0.flex.e + R(i)*.005;
    end
    [FEM_out0] = FE_solver(FEM_out0);
    FE_plot(FEM_out0)
    plot_tor_shape(FEM_out0)
end



% % % %%
% % % % Analysis0 - initial torus shape
% % % t1 = toc(t0);
% % % [FEM_out0] = FE_solver(FEM0);
% % % 
% % % FE_plot(FEM_out0)
% % % plot_tor_shape(FEM_out0)
% % % 
% % % t2 = toc(t0);
% % % fprintf('Initial shape analysis complete\nAnalysis time = %g s\n\n',t2 - t1)

figure(3)
clf


%%
% Analysis1 - 10 lb pre-load
FEM1 = FEM0; % Initial input
[U2] = reorg_vec(FEM_out0.OUT.U); % Reorganize U vector

% Update nodal locations
FEM1.MODEL.nodes = FEM1.MODEL.nodes + U2(:,1:3);
FEM1.MODEL.orientation(FEM1.el_ind.ind1,1:2) = FEM1.MODEL.nodes(FEM1.el_ind.ind1,1:2);
[FEM1.MODEL.orientation(FEM1.el_ind.ind1,:)] = orient_tor(FEM1.MODEL.orientation(FEM1.el_ind.ind1,:),U2(FEM1.el_ind.ind1,:));

% Load cable ends
Fmag = 10; % Cable end force
[FEM1.MODEL.F_pt] = cable_F(ind,theta,I_theta_cable,Fmag);

% Bound cable ends
cableB = [zeros(3,size(I_theta_cable,1)*2)
    ones(3,size(I_theta_cable,1)*2)];
FEM1.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);

% Unbound torus
torB = zeros(6,size(ind.ind1,1));
FEM1.MODEL.B(1:ind.ind1(end)*6) = torB(:);

% Controls
[FEM1.ANALYSIS] = FE_controls1;
FE_plot(FEM1)

% Analyze
[FEM_out1] = FE_solver(FEM1);

FE_plot(FEM_out1)
plot_tor_shape(FEM_out1)

t3 = toc(t0);
fprintf('Cable preload analysis complete\nAnalysis time = %g s\n\n',t3 - t2)



%%
% Analysis2 - cable displacement
FEM2 = FEM_out1;
FEM2.MODEL.F_pre = FEM2.OUT.Fext_inc(:,end);

% Displace cable ends
Umag = 1; % Cable end displacment
[FEM2.MODEL.U_pt] = cable_disp(ind,theta,I_theta_cable,Umag);

% Bound cable ends
cableB = [ones(3,size(I_theta_cable,1)*2)
    ones(3,size(I_theta_cable,1)*2)];
FEM2.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);

% Controls
[FEM2.ANALYSIS] = FE_controls2;
FE_plot(FEM2)

% Analyze
[FEM_out2] = FE_solver(FEM2);

FE_plot(FEM_out2)
plot_tor_shape(FEM_out2)

t4 = toc(t0);
fprintf('Cable displacement analysis complete\nAnalysis time = %g s\n\n',t4 - t3)




%% POST PROCESS
% Plot output
FE_plot(FEM_out2)
plot_tor_shape(FEM_out2)
visual_postshape(FEM_out2)

% Analysis runtime information
t_tot = toc(t0);
t_an = t_tot - t_pre;
fprintf('\nPreprocessor time = %g s\nTotal analysis time = %g s\n\n',t_pre,t_an)
FEM_out2.t = t_tot;



% permute(sum(FEM_out2.OUT.fint_el(7,FEM_out2.el_ind.ind3,:)),[3,2,1])


% % % % Save analysis
% % % save(job_title,'FEM_out2')

% % % % Send text
% % % setpref('Internet','E_mail','andrew.c.young1@maine.edu');
% % % setpref('Internet','SMTP_Server','mail');
% % % sendmail('2073192615@vtext.com','Analysis Complete',...
% % %     sprintf('\n%s complete.\n\n%s\n',job_title,datestr(now)))

% % % % Shutdown after analysis
% % % system('shutdown -s')











