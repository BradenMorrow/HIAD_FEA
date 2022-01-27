% Driver for torus analysis
% April 19, 2016

clear

%% START ANALYSIS
set_working_dir
warning('on','all')
dir0 = 'C:\Users\andrew.young\Desktop\Repo\1115_NASA\16_04_19_tori';
t0 = tic;


%% GENERIC GEOMETRY
% General geometric inputs
n_cable = 1; % Number of radial cables
el_int = 100; % 21; % Number of elements between cable nodes
cable0 = 0; % Measure to first cable (deg)
theta_support = (45:90:360)'*pi/180;

[theta,I_theta_cable,I_theta_support] = gen_geo(n_cable,cable0,el_int,theta_support);


%% MODEL INPUT
% Analysis inputs
job_title = 'torus_PS_06JUN16';

% % % % Create variables for plotting test data
% % % tor_test_plot(theta)

% Obtain torus test specimen specifications and initial shape
[tor.nodes,tor.R,tor.Utor0] = tor_spec(theta);

% Torus specifications
tor.r = 6.7; % Minor radius (in)
tor.p = 20; % Inflation pressure (psi)
tor.beta = 71; % Braid angle (deg)
tor.alpha = 271; % [210 330]'; % Location of cords (deg)
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
% visual_preshape(FEM0,dir0)

t_pre = toc(t0);


%% ANALYSIS
[FEM0.ANALYSIS] = FE_controls0;

% Analyze
[FEM_out0] = FE_solver(FEM0);
FE_plot(FEM_out0)

visual_postshape(FEM_out0,dir0)

a = 1;


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
% % % 
% % % figure(3)
% % % clf


%%
% % % [F_cable] = tor_test_plot(theta);
% % % 
% % % % Analysis1 - 10 lb pre-load
% % % FEM1 = FEM0; % Initial input
% % % [U2] = reorg_vec(FEM_out0.OUT.U); % Reorganize U vector
% % % 
% % % % Update nodal locations
% % % FEM1.MODEL.nodes = FEM1.MODEL.nodes + U2(:,1:3);
% % % FEM1.MODEL.orientation(FEM1.el_ind.ind1,1:2) = FEM1.MODEL.nodes(FEM1.el_ind.ind1,1:2);
% % % [FEM1.MODEL.orientation(FEM1.el_ind.ind1,:)] = orient_tor(FEM1.MODEL.orientation(FEM1.el_ind.ind1,:),U2(FEM1.el_ind.ind1,:));
% % % 
% % % % Load cable ends
% % % Fmag = 10; % Cable end force
% % % [FEM1.MODEL.F_pt] = cable_F(ind,theta,I_theta_cable,Fmag);
% % % 
% % % % Bound cable ends
% % % cableB = [zeros(3,size(I_theta_cable,1)*2)
% % %     ones(3,size(I_theta_cable,1)*2)];
% % % FEM1.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);
% % % 
% % % % Unbound torus
% % % torB = zeros(6,size(ind.ind1,1));
% % % torB(3,:) = 1; % Bound out-of-plane
% % % FEM1.MODEL.B(1:ind.ind1(end)*6) = torB(:);
% % % 
% % % % Controls
% % % [FEM1.ANALYSIS] = FE_controls1;
% % % FE_plot(FEM1)
% % % 
% % % % Analyze
% % % [FEM_out1] = FE_solver(FEM1);
% % % 
% % % FE_plot(FEM_out1)
% % % plot_tor_shape(FEM_out1)
% % % 
% % % t3 = toc(t0);
% % % fprintf('Cable preload analysis complete\nAnalysis time = %g s\n\n',t3 - t2)
% % % 
% % % 
% % % 
% % % %%
% % % % Analysis2 - cable displacement
% % % FEM2 = FEM_out1;
% % % 
% % % FEM2.MODEL.F_pre = FEM2.OUT.Fext_inc(:,end);
% % % 
% % % % Displace cable ends
% % % Umag = 1; % Cable end displacment
% % % [FEM2.MODEL.U_pt] = cable_disp(ind,theta,I_theta_cable,Umag);
% % % [FEM2.MODEL.F_pt] = cable_F2(ind,theta,I_theta_cable,F_cable');
% % % FEM2.MODEL.F_pt = [FEM2.MODEL.F_pt FEM2.MODEL.F_pt(:,end)*1.2];
% % % 
% % % 
% % % % % % % Bound cable ends
% % % % % % cableB = [ones(3,size(I_theta_cable,1)*2)
% % % % % %     ones(3,size(I_theta_cable,1)*2)];
% % % % % % FEM2.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);
% % % 
% % % % Controls
% % % [FEM2.ANALYSIS] = FE_controls2;
% % % FE_plot(FEM2)
% % % 
% % % % Analyze
% % % [FEM_out2] = FE_solver(FEM2);
% % % 
% % % FE_plot(FEM_out2)
% % % plot_tor_shape(FEM_out2)
% % % 
% % % t4 = toc(t0);
% % % fprintf('Cable displacement analysis complete\nAnalysis time = %g s\n\n',t4 - t3)




%% POST PROCESS
% Plot output
FE_plot(FEM_out0)
% % % plot_tor_shape(FEM_out2)
visual_postshape(FEM_out0,dir0)

% % % % Analysis runtime information
% % % t_tot = toc(t0);
% % % t_an = t_tot - t_pre;
% % % fprintf('\nPreprocessor time = %g s\nTotal analysis time = %g s\n\n',t_pre,t_an)
% % % FEM_out2.t = t_tot;
% % % 
% % % a = zeros(size(FEM_out2.OUT.Uinc,2),size(I_theta_cable,1)*2);
% % % b = permute(FEM_out2.OUT.fint_el(7,FEM_out2.el_ind.ind3,:),[3 1 2]);
% % % a(:) = b(:,1,:);
% % % a0 = a;
% % % a0(a0(:,1) < 9,:) = [];

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



% % % %%
% % % figure(4)
% % % hold on
% % % plot(linspace(0,1,size(a0,1))',a0,'k--','linewidth',2)






