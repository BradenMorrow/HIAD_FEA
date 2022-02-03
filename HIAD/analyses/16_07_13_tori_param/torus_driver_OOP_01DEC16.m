% Driver for torus analysis
% April 19, 2016

clear

%% START ANALYSIS
% warning('on','all')
t0 = tic;





%% GENERIC GEOMETRY
% General geometric inputs
n_cable = 8; % Number of radial cables
el_int = 10; % Number of elements between cable nodes
cable0 = 11.25; % Measure to first cable (deg)
theta_support0 = (11.25 + 22.5:90:360)'*pi/180;
theta_support_arc = 15/60;
theta_support = sort([theta_support0 - theta_support_arc/2; theta_support0 + theta_support_arc/2]);

theta0 = []; % linspace(80,90,10)'*pi/180;  % torus mesh refinement

thoopl = [11.25 + 45 + 22.5
    11.25 + 45 + 22.5 + 180]*pi/180;
d_th_oop = 2/60;
n_oop = 1;
theta_oop_load = [linspace(thoopl(1) - d_th_oop/2,thoopl(1) + d_th_oop/2,n_oop)'
    linspace(thoopl(2) - d_th_oop/2,thoopl(2) + d_th_oop/2,n_oop)'];


[theta,I_theta_cable,I_theta_support,I_theta_load] = gen_geo2(n_cable,cable0,el_int,theta_support,theta_oop_load,theta0);

theta2 = theta*180/pi;





%% MODEL INPUT
% Test identification
n = 10;
% % % test_ID = 1346;
test_ID = 10000;

% Torus geometry
r_i = 6.7;
p_i = 15; % 20; % 

beta = 69;
beta_i = beta;

alpha_i = [210 330]';

dR = 0; % Incrementally increase minor radius

% Test configuration
% % % load('test_post.mat')
% [test_out] = torus_data_post_proc_T3AP_5_torsion; % Function for specific test
[test_out] = torus_data_post_proc_oop;
% load('test_out_oop') % For: torus_data_post_proc_T3AP_5_torsion.m

% Out-of-plane loading
F_oop = 477/n_oop;

% Analysis inputs
job_title = sprintf('tor_%g',test_ID);

% Obtain torus test specimen specifications and initial shape
tor_test = eval(sprintf('test_out.%s;',job_title));
tor_test.dR = dR;
% % % [tor.nodes,tor.R,tor.Utor0,Rave,tor_cyl] = tor_spec_param(theta,tor_test);
[tor.nodes,tor.R,tor.Utor0,Rave,tor_cyl] = tor_spec_param2(theta,tor_test); % Turn test info into FE model

% % % tor.nodes(:,3) = 0;


% Torus specifications
tor.r = r_i; % Minor radius (in)
tor.p = p_i; % Inflation pressure (psi)
tor.beta = beta_i; % Braid angle (deg)
tor.alpha = alpha_i; % Location of cords (deg)

tor.ELong = 25; % 80; % 100; % Longitudinal shell modulus (lb/in)
tor.GLH = 2379; % 2670; % In-plane shear modulus (lb/in)
cable_pp = tor_test.pp; % Cable load response

tor.Nint = 3; % Number of integration points

% % % PERFECT INITIAL GEOMETRY
tor.Utor0 = tor.Utor0; % *0

% Generate FE model
FEM00 = gen_model(theta,I_theta_cable,I_theta_support,tor,cable_pp);
ind = FEM00.el_ind;


% FEM00.MODEL.nodes(:,3) = 0;


% FE controls
[FEM00.ANALYSIS] = FE_controls00;
[FEM00.PLOT] = plot_controls;

% Save plotting variables
FEM00.PLOT.Rave = Rave;
FEM00.PLOT.tor_cyl = tor_cyl;
FEM00.PLOT.P = tor_test.P;

% Initial visualizations
FE_plot_tor_pub(FEM00)
% % % FE_plot(FEM0)
visual_preshape(FEM00)

t_pre = toc(t0);

    
    
    
    
% % % %% ANALYSIS
% % % % Analysis00 - initial torus shape
% % % t1 = toc(t0);
% % % [FEM_out00] = increment_FE(FEM00);
% % % 
% % % FE_plot(FEM_out00)
% % % 
% % % t2 = toc(t0);
% % % fprintf('Initial shape analysis complete\nAnalysis time = %g s\n\n',t2 - t1)
% % % 
% % % figure(3)
% % % clf
t1 = toc(t0);
t2 = toc(t0);


figure(1000)
clf

%% Loop through analyses
for i = 1 %:n
    
    
    
    
    
    %%
    % Analysis0 - out of plane loading
    fprintf('\nOut-of-plane analysis\n')
    % % % % fprintf('\ni = %g\nF_oop = %g\n\n\n',i,F_oop(i))
    % % % FEM0 = FEM00; % Initial input
    % % % 
    % % % [U2] = reorg_vec(FEM_out00.OUT.U); % Reorganize U vector
    % % % 
    % % % % Update nodal locations
    % % % % Include out-of-plane
    % % % FEM0.MODEL.nodes = FEM0.MODEL.nodes + U2(:,1:3);
    % % % FEM0.MODEL.orientation(FEM0.el_ind.ind1,1:2) = FEM0.MODEL.nodes(FEM0.el_ind.ind1,1:2);
    % % % [FEM0.MODEL.orientation(FEM0.el_ind.ind1,:)] = orient_tor(FEM0.MODEL.orientation(FEM0.el_ind.ind1,:),U2(FEM0.el_ind.ind1,:));
    FEM0 = FEM00; % Initial input
    
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
    plot_tor_shape_09DEC16(FEM_out0)
    plot_tor_shape_post(tor_test,FEM_out0,theta_support)
    
    t3 = toc(t0);
    fprintf('Out-of-plane analysis complete\nAnalysis time = %g s\n\n',t3 - t2)
    
    FEM_out0.PLOT.def = 0;
    visual_postshape(FEM_out0)
    FEM_out0.PLOT.def = 1;

    T3_test_setup
    
    
    
    
    %%
    % Analysis1 - cable preload
    fprintf('\nCable preload analysis\n')
    FEM1 = FEM_out0; % Initial input
    
    % Include out-of-plane preload
    FEM1.MODEL.F_pre = FEM1.OUT.Fext_inc(:,end);
    
    % Load cable ends
    Fmag = 10; % Cable end force (preload)
    [FEM1.MODEL.F_pt] = cable_F(ind,theta,I_theta_cable,Fmag);
%     [FEM1.MODEL.F_pt] = Fcable_pt(ind,theta,I_theta_cable);
    
    % Controls
    [FEM1.ANALYSIS] = FE_controls1;
    FE_plot(FEM1)
    
    % Analyze
    [FEM_out1] = increment_FE(FEM1);
    
    FE_plot(FEM_out1)
    plot_tor_shape_09DEC16(FEM_out1)
    
    t3 = toc(t0);
    fprintf('Cable preload analysis complete\nAnalysis time = %g s\n\n',t3 - t2)
    
    FEM_out0.PLOT.def = 0;
    visual_postshape(FEM_out1)
    FEM_out0.PLOT.def = 1;

    T3_test_setup
    
    
    
    %%
    % Analysis2 - uniform cable displacement
    fprintf('\nCable displacement analysis\n')
    FEM2 = FEM_out1;
    
    FEM2.MODEL.F_pre = FEM2.OUT.Fext_inc(:,end);
    
    % Displace cable ends
    Umag = 3; % *.2378; % Cable end displacment
    
    [FEM2.MODEL.U_pt] = cable_disp(ind,theta,I_theta_cable,Umag); % Uniform cable end displacement
    % [FEM2.MODEL.U_pt] = cable_disp_tor_sine(ind,theta,I_theta_cable,Umag); % Sinusoidal torsion {1b 0b -1b... -1t 0t 1t...}
    % [FEM2.MODEL.U_pt] = cable_disp_tor_sine2(ind,theta,I_theta_cable,Umag); % Sinusoidal torsion {1b 1b -1b -1b... -1t -1t 1t 1t...}
    % [FEM2.MODEL.F_pt] = cable_F2(ind,theta,I_theta_cable,F_cable'); % Force controlled
    
    % FEM2.MODEL.F_pt = [FEM2.MODEL.F_pt FEM2.MODEL.F_pt(:,end)*1.2];
    
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
    plot_tor_shape_09DEC16(FEM_out2)
    
    t4 = toc(t0);
    fprintf('Cable displacement analysis complete\nAnalysis time = %g s\n\n',t4 - t3)
    
    FEM_out0.PLOT.def = 0;
    visual_postshape(FEM_out2)
    FEM_out0.PLOT.def = 1;

    T3_test_setup
    
    
% % %     %%
% % %     % Analysis2 - cable force
% % %     fprintf('\nCable load analysis\n')
% % %     FEM3 = FEM_out2;
% % %     
% % %     FEM3.MODEL.F_pre = FEM3.OUT.Fext_inc(:,end);
% % %     
% % %     % Displace cable ends
% % %     % Umag = 5*.2378; % Cable end displacment
% % %     % 
% % %     % [FEM2.MODEL.U_pt] = cable_disp(ind,theta,I_theta_cable,Umag); % Uniform cable end displacement
% % %     % [FEM2.MODEL.U_pt] = cable_disp_tor_sine(ind,theta,I_theta_cable,Umag); % Sinusoidal torsion {1b 0b -1b... -1t 0t 1t...}
% % %     % [FEM2.MODEL.U_pt] = cable_disp_tor_sine2(ind,theta,I_theta_cable,Umag); % Sinusoidal torsion {1b 1b -1b -1b... -1t -1t 1t 1t...}
% % %     % [FEM2.MODEL.F_pt] = cable_F2(ind,theta,I_theta_cable,F_cable'); % Force controlled
% % %     
% % %     % FEM2.MODEL.F_pt = [FEM2.MODEL.F_pt FEM2.MODEL.F_pt(:,end)*1.2];
% % %     
% % %     % Load cable ends
% % %     Fmag = 1; % Cable end force (preload)
% % %     [FEM3.MODEL.F_pt] = cable_F(ind,theta,I_theta_cable,Fmag);
% % %     
% % %     % Bound cable ends
% % %     cableB = [zeros(3,size(I_theta_cable,1)*2)
% % %         ones(3,size(I_theta_cable,1)*2)];
% % %     FEM3.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);
% % %     
% % %     % Controls
% % %     [FEM3.ANALYSIS] = FE_controls3;
% % %     FE_plot(FEM3)
% % %     
% % %     
% % %     
% % %     % Analyze
% % %     [FEM_out3] = increment_FE(FEM3);
% % %     
% % %     FE_plot(FEM_out3)
% % %     plot_tor_shape_09DEC16(FEM_out3)
% % %     
% % %     t4 = toc(t0);
% % %     fprintf('Cable displacement analysis complete\nAnalysis time = %g s\n\n',t4 - t3)
% % %     
% % %     FEM_out0.PLOT.def = 0;
% % %     visual_postshape(FEM_out3)
% % %     FEM_out0.PLOT.def = 1;
% % % 
% % %     T3_test_setup
    
    
    
    
    
% % %     %%
% % %     % Analysis3 - cable torsional displacement
% % %     fprintf('\nCable torsion analysis\n')
% % %     FEM3 = FEM_out2;
% % %     
% % %     FEM3.MODEL.F_pre = FEM3.OUT.Fext_inc(:,end);
% % %     
% % %     % Displace cable ends
% % %     Umag = 1.75; % Umag_i; % Cable end displacment
% % %     
% % %     % [FEM2.MODEL.U_pt] = cable_disp_tor(ind,theta,I_theta_cable,Umag); % Uniform cable end displacement
% % %     % [FEM2.MODEL.U_pt] = cable_disp_tor_sine(ind,theta,I_theta_cable,Umag); % Sinusoidal torsion {1b 0b -1b... -1t 0t 1t...}
% % %     [FEM3.MODEL.U_pt] = cable_disp_tor_sine2(ind,theta,I_theta_cable,Umag); % Sinusoidal torsion {1b 1b -1b -1b... -1t -1t 1t 1t...}
% % %     % [FEM2.MODEL.F_pt] = cable_F2(ind,theta,I_theta_cable,F_cable'); % Force controlled
% % %     
% % %     FEM3.MODEL.F_pt = [FEM3.MODEL.F_pt FEM3.MODEL.F_pt(:,end)*1.2];
% % %     
% % %     % Bound cable ends
% % %     cableB = [ones(3,size(I_theta_cable,1)*2)
% % %         ones(3,size(I_theta_cable,1)*2)];
% % %     FEM3.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);
% % %     
% % %     % Controls
% % %     [FEM3.ANALYSIS] = FE_controls3;
% % %     FE_plot(FEM3)
% % %     
% % %     % Analyze
% % %     [FEM_out2] = increment_FE(FEM3);
% % %     
% % %     FE_plot(FEM_out2)
% % %     plot_tor_shape_an_only(FEM_out2)
% % %     
% % %     t4 = toc(t0);
% % %     fprintf('Cable torsion analysis complete\nAnalysis time = %g s\n\n',t4 - t3)
% % %     
% % %     
% % %     
% % %     
% % %     
% % %     % %%
% % %     f = figure(1);
% % %     savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\FE_plot_%g',round(F_out)))
% % %     f = figure(2);
% % %     savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\ip_op_%g',round(F_out)))
% % %     f = figure(3);
% % %     savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\ave_rad_%g',round(F_out)))
% % %     
% % %     FEM_out2.PLOT.def = 0;
% % %     visual_postshape(FEM_out2)
% % %     T3_test_setup
% % %     f = figure(4);
% % %     savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\tor_rend_%g',round(F_out)))

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




