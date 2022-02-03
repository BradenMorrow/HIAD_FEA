% Driver for torus analysis
% April 19, 2016

clear

%% START ANALYSIS
% warning('on','all')
t0 = tic;

N = 32; % [8 16 32 64];
r = 6.7; % [6.7 13.14];
R = 60*2; % [60 120];
ID = sprintf('71_%g_1r_2R',N);



%% GENERIC GEOMETRY
% General geometric inputs
n_cable = N; % Number of radial cables
el_int = max([floor(40/n_cable) 1]); % 21; % Number of elements between cable nodes
cable0 = 11.25; % Measure to first cable (deg)
theta_support0 = (11.25 + 22.5:90:360)'*pi/180;
theta_support_arc = 15/60;
theta_support = sort([theta_support0 - theta_support_arc/2; theta_support0 + theta_support_arc/2]);

theta_oop_load = [11.25 + 45 + 22.5
    11.25 + 45 + 22.5 + 180]*pi/180;

[theta,I_theta_cable,I_theta_support,I_theta_load] = gen_geo2(n_cable,cable0,el_int,theta_support,theta_oop_load,[]);

theta2 = theta*180/pi;


%% MODEL INPUT
% Test identification
n = 10;
% % % test_ID = 1346;
test_ID = 10000;

% Torus geometry
r_i = r;
p_i = 15;

beta = 71;
beta_i = beta;

alpha_i = [210 330]';
R_i = R;

dR = 0; % Incrementally increase minor radius

% % % % Out-of-plane loading
% % % F_oop = 0;

% Analysis inputs
job_title = sprintf('tor_%g',test_ID);

[tor.nodes,tor.R,tor.Utor0,Rave,tor_cyl,pp] = tor_param(theta,R_i,n_cable);

% Torus specifications
tor.r = r_i; % Minor radius (in)
tor.p = p_i; % Inflation pressure (psi)
tor.beta = beta_i; % Braid angle (deg)
tor.alpha = alpha_i; % Location of cords (deg)

tor.ELong = 80; % 25; % Longitudinal shell modulus (lb/in)
tor.GLH = 2379; % 2670; % In-plane shear modulus (lb/in)
cable_pp = pp; % Cable load response

tor.Nint = 10; % Number of integration points

% % % PERFECT INITIAL GEOMETRY
tor.Utor0 = tor.Utor0*0; % 

% Generate FE model
FEM00 = gen_model(theta,I_theta_cable,I_theta_support,tor,cable_pp);
ind = FEM00.el_ind;

% FE controls
[FEM00.ANALYSIS] = FE_controls00;
[FEM00.PLOT] = plot_controls;

% Save plotting variables
FEM00.PLOT.Rave = Rave;
FEM00.PLOT.tor_cyl = tor_cyl;
% % % FEM00.PLOT.P = tor_test.P;

% % % % Initial visualizations
% % % FE_plot(FEM00)
% % % visual_preshape(FEM00)

t_pre = toc(t0);

t1 = toc(t0);
t2 = toc(t0);


%% Loop through analyses
for i = 1 %:n
    % %%
    % Analysis1 - cable preload
    fprintf('\nCable preload analysis\n')
    FEM1 = FEM00; % FEM_out0; % Initial input
    
    % Load cable ends
    Fmag = 0; % 500; % 11000/n_cable/2; % 10; % Cable end force (preload)
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
    % Analysis2 - uniform cable displacement
    fprintf('\nCable displacement analysis\n')
    FEM2 = FEM_out1;
    
    FEM2.MODEL.F_pre = FEM2.OUT.Fext_inc(:,end);
    
    % Displace cable ends
    Umag = 1.5; % 5; % Cable end displacment
    
    [FEM2.MODEL.U_pt] = cable_disp(ind,theta,I_theta_cable,Umag); % Uniform cable end displacement
    
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
    
    
    
% % %     % %%
% % %     f = figure(1);
% % %     savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\FE_plot_%g',round(F_out)))
% % %     f = figure(2);
% % %     savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\ip_op_%g',round(F_out)))
    f = figure(3);
    savefig(f,ID)
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




