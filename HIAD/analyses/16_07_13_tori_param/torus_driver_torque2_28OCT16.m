% Driver for torus analysis
% April 19, 2016

clear

%% START ANALYSIS
% warning('on','all')
t0 = tic;


%% GENERIC GEOMETRY
% General geometric inputs
n_cable = 8; % Number of radial cables
el_int = 16; % 21; % Number of elements between cable nodes
cable0 = 11.25; % Measure to first cable (deg)
theta_support = (11.25 + 22.5:90:360)'*pi/180;

theta_oop_load = [11.25 + 45 + 22.5
    11.25 + 45 + 22.5 + 180]*pi/180;

[theta,I_theta_cable,I_theta_support,I_theta_load] = gen_geo2(n_cable,cable0,el_int,theta_support,theta_oop_load);

theta2 = theta*180/pi;


%% MODEL INPUT
% Test identification
n = 10;
test_ID = 1346;

% Torus geometry
r_i = 6.7;
p_i = 15;

beta = 69;
beta_i = beta;

alpha_i = [210 330]';

dR = 0; % Incrementally increase minor radius

% Test configuration
Umag_i = 4;
load('test_post.mat')

% Out-of-plane loading
F_oop = linspace(100,500,n)'*0;

% Analysis inputs
job_title = sprintf('tor_%g',test_ID);

% Obtain torus test specimen specifications and initial shape
tor_test = eval(sprintf('test_out.%s;',job_title));
tor_test.dR = dR;
[tor.nodes,tor.R,tor.Utor0,Rave,tor_cyl] = tor_spec_param(theta,tor_test);

% Torus specifications
tor.r = r_i; % Minor radius (in)
tor.p = p_i; % Inflation pressure (psi)
tor.beta = beta_i; % Braid angle (deg)
tor.alpha = alpha_i; % Location of cords (deg)

tor.ELong = 25; % 80; % Longitudinal shell modulus (lb/in)
tor.GLH = 2379; % 2670; % In-plane shear modulus (lb/in)
cable_pp = tor_test.pp; % Cable load response

tor.Nint = 3; % Number of integration points


% % % PERFECT INITIAL GEOMETRY
tor.Utor0 = tor.Utor0; % *0


% Generate FE model
FEM000 = gen_model(theta,I_theta_cable,I_theta_support,tor,cable_pp);
ind = FEM000.el_ind;

% FE controls
[FEM000.ANALYSIS] = FE_controls00;
[FEM000.PLOT] = plot_controls;

% Save plotting variables
FEM000.PLOT.Rave = Rave;
FEM000.PLOT.tor_cyl = tor_cyl;
FEM000.PLOT.P = tor_test.P;

% Initial visualizations
% % % FE_plot(FEM0)
% % % visual_preshape(FEM0)

t_pre = toc(t0);

    
    
    
    %% ANALYSIS
% Analysis00 - initial torus shape
t1 = toc(t0);
[FEM_out000] = increment_FE(FEM000);

FE_plot(FEM_out000)

t2 = toc(t0);
fprintf('Initial shape analysis complete\nAnalysis time = %g s\n\n',t2 - t1)

figure(3)
clf




%% Loop through analyses
for i = 1 %:n
    
    
    
    
    % %%
    % Analysis0 - out of plane loading
    % fprintf('\ni = %g\nF_oop = %g\n\n\n',i,F_oop(i))
    FEM0 = FEM000; % Initial input
    
    [U2] = reorg_vec(FEM_out000.OUT.U); % Reorganize U vector
    
    % Update nodal locations
    % Include out-of-plane
    FEM0.MODEL.nodes = FEM0.MODEL.nodes + U2(:,1:3);
    FEM0.MODEL.orientation(FEM0.el_ind.ind1,1:2) = FEM0.MODEL.nodes(FEM0.el_ind.ind1,1:2);
    [FEM0.MODEL.orientation(FEM0.el_ind.ind1,:)] = orient_tor(FEM0.MODEL.orientation(FEM0.el_ind.ind1,:),U2(FEM0.el_ind.ind1,:));
    
    % Load out-of-plane
    F_out = F_oop(i);
    FEM0.MODEL.F_pt((I_theta_load - 1)*6 + 3,2) = -F_out;
    
    % Unbound cable ends
    cableB = [zeros(3,size(I_theta_cable,1)*2)
        ones(3,size(I_theta_cable,1)*2)];
    FEM0.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);
    
    % Unbound torus
    torB = zeros(6,size(ind.ind1,1));
    % % % torB(3,:) = 1; % Bound out-of-plane
    FEM0.MODEL.B(1:ind.ind1(end)*6) = torB(:);
    
    % Controls
    [FEM0.ANALYSIS] = FE_controls0;
    FE_plot(FEM0)
    
    % Analyze
    [FEM_out0] = increment_FE(FEM0);
    
    FE_plot(FEM_out0)
    plot_tor_shape_an_only(FEM_out0)
    
    t3 = toc(t0);
    fprintf('Out-of-plane analysis complete\nAnalysis time = %g s\n\n',t3 - t2)
    
    
    
    
    % %%
    % Analysis1 - cable preload
    FEM1 = FEM_out0; % Initial input
    
    % Include out-of-plane preload
    FEM1.MODEL.F_pre = FEM1.OUT.Fext_inc(:,end);
    
    % Load cable ends
    Fmag = 10; % Cable end force (preload)
    [FEM1.MODEL.F_pt] = cable_F(ind,theta,I_theta_cable,Fmag);
    
    % Controls
    [FEM1.ANALYSIS] = FE_controls1;
    FE_plot(FEM1)
    
    % Analyze
    [FEM_out1] = increment_FE(FEM1);
    
    FE_plot(FEM_out1)
    plot_tor_shape_an_only(FEM_out1)
    
    t3 = toc(t0);
    fprintf('Cable preload analysis complete\nAnalysis time = %g s\n\n',t3 - t2)
    
    
    
    
    % %%
    % Analysis2 - cable displacement
    FEM2 = FEM_out1;
    
    FEM2.MODEL.F_pre = FEM2.OUT.Fext_inc(:,end);
    
    % Displace cable ends
    Umag = Umag_i; % Cable end displacment
    
    % [FEM2.MODEL.U_pt] = cable_disp_tor(ind,theta,I_theta_cable,Umag); % Uniform cable end displacement
    [FEM2.MODEL.U_pt] = cable_disp_tor_sine(ind,theta,I_theta_cable,Umag); % Sinusoidal torsion
    % [FEM2.MODEL.F_pt] = cable_F2(ind,theta,I_theta_cable,F_cable'); % Force controlled
    
    FEM2.MODEL.F_pt = [FEM2.MODEL.F_pt FEM2.MODEL.F_pt(:,end)*1.2];
    
    % Bound cable ends
    cableB = [ones(3,size(I_theta_cable,1)*2)
        ones(3,size(I_theta_cable,1)*2)];
    FEM2.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);
    
    % Controls
    [FEM2.ANALYSIS] = FE_controls2;
    FE_plot(FEM2)
    
    % Analyze
    [FEM_out2] = increment_FE(FEM2);
    
    FE_plot(FEM_out2)
    plot_tor_shape_an_only(FEM_out2)
    
    t4 = toc(t0);
    fprintf('Cable displacement analysis complete\nAnalysis time = %g s\n\n',t4 - t3)
    
    
    
    
    % %%
    f = figure(1);
    savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\FE_plot_%g',round(F_out)))
    f = figure(2);
    savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\ip_op_%g',round(F_out)))
    f = figure(3);
    savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\ave_rad_%g',round(F_out)))
    
    FEM_out2.PLOT.def = 0;
    visual_postshape(FEM_out2)
    T3_test_setup
    f = figure(4);
    savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\tor_rend_%g',round(F_out)))

%     figure(3)
%     clf
end











%% POST PROCESS
% Plot output
% % % FE_plot(FEM_out2)
% % % plot_tor_shape_an_only(FEM_out2)
% % % visual_postshape(FEM_out2)

% Analysis runtime information
t_tot = toc(t0);
t_an = t_tot - t_pre;
fprintf('\nPreprocessor time = %g s\nTotal analysis time = %g s\n\n',t_pre,t_an)
FEM_out2.t = t_tot;

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
% % % % Cable force plotting
% % % a = zeros(size(FEM_out2.OUT.Uinc,2),size(I_theta_cable,1)*2);
% % % b = permute(FEM_out2.OUT.fint_el(7,FEM_out2.el_ind.ind3,:),[3 1 2]);
% % % a(:) = b(:,1,:);
% % % a0 = a;
% % % a0(a0(:,1) < 9,:) = [];
% % % 
% % % 
% % % figure(4)
% % % hold on
% % % % plot(linspace(0,size(a0,1),size(a0,1))',a0,'kx--','linewidth',2)
% % % plot(linspace(0,1,size(a0,1) - 1)',a0(1:end - 1,:),'k--') % ,'linewidth',2)
% % % 
% % % xlabel('Cable end displacement (in)')
% % % ylabel('Cable load (lbf)')
% % % 
% % % xlim([0 1])
% % % ylim([0 350])
% % % 
% % % leg(1) = plot([-1 -1],[-1 -1],'b-');
% % % leg(2) = plot([-1 -1],[-1 -1],'k--');
% % % legend(leg,'Test','Model','location','northwest')




