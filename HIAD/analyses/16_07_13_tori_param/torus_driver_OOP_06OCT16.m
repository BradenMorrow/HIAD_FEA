% Driver for torus analysis
% April 19, 2016

clear

%% START ANALYSIS
warning('on','all')
t0 = tic;


%% GENERIC GEOMETRY
% General geometric inputs
n_cable = 8; % Number of radial cables
el_int = 10; % 21; % Number of elements between cable nodes
cable0 = 11.25; % Measure to first cable (deg)
theta_support = (45:90:360)'*pi/180;

theta_oop_load = [90 270]'*pi/180;

[theta,I_theta_cable,I_theta_support,I_theta_load] = gen_geo2(n_cable,cable0,el_int,theta_support,theta_oop_load);


%% MODEL INPUT
% Test identification
n = 10;
test_ID = 1346*ones(n,1);

% Torus geometry
r_i = 6.7*ones(size(test_ID));
p_i = 15*ones(size(test_ID));

beta = 69;
beta_i = beta*ones(size(test_ID));

alpha_i = cell(size(test_ID));

for i = 1:n
    alpha_i{i} = [210 330]';
end

dR = .008*ones(size(test_ID));

% Torus properties
% ELong_i = 25*ones(size(test_ID));
GLH_i = 2379*ones(size(test_ID)); % In-plane shear modulus (lb/in)

% Test configuration
Umag_i = 0.75*ones(size(test_ID));
load('test_post.mat')


% Out-of-plane loading
F_oop = linspace(100,500,n)';

%% Loop through analyses
for i = 1 % 1:size(test_ID,1)
    
    i
    
    % Analysis inputs
    job_title = sprintf('tor_%g',test_ID(i));
    
    % Obtain torus test specimen specifications and initial shape
    tor_test = eval(sprintf('test_out.%s;',job_title));
    tor_test.dR = dR(i);
    [tor.nodes,tor.R,tor.Utor0,Rave,tor_cyl] = tor_spec_param(theta,tor_test);
    
    % Torus specifications
    tor.r = r_i(i); % Minor radius (in)
    tor.p = p_i(i); % Inflation pressure (psi)
    tor.beta = beta_i(i); % Braid angle (deg)
    tor.alpha = alpha_i{i}; % Location of cords (deg)
    
    tor.ELong = 25; % 80; % Longitudinal shell modulus (lb/in)
    tor.GLH = GLH_i(i); % 2670; % In-plane shear modulus (lb/in)
    cable_pp = tor_test.pp; % Cable load response
    
    tor.Nint = 3; % Number of integration points
    
    
    
    % Generate FE model
    FEM0 = gen_model(theta,I_theta_cable,I_theta_support,tor,cable_pp);
    ind = FEM0.el_ind;
    
    % FE controls
    [FEM0.ANALYSIS] = FE_controls0;
    [FEM0.PLOT] = plot_controls;
    
    % Save plotting variables
    FEM0.PLOT.Rave = Rave;
    FEM0.PLOT.tor_cyl = tor_cyl;
    FEM0.PLOT.P = tor_test.P;
    
    % Initial visualizations
    FE_plot(FEM0)
    visual_preshape(FEM0)
    
    t_pre = toc(t0);
    
    
    %% ANALYSIS
    % Analysis0 - initial torus shape
    t1 = toc(t0);
    [FEM_out0] = increment_FE(FEM0);
    
    FE_plot(FEM_out0)
    
    t2 = toc(t0);
    fprintf('Initial shape analysis complete\nAnalysis time = %g s\n\n',t2 - t1)
    
% % %     figure(3)
% % %     clf
    
    
    %%
    % Analysis00 - out of plane loading
    FEM00 = FEM0; % Initial input

    if(FEM0.ANALYSIS.save_FE_info)
        FEM00.iter_info = FEM_out0.iter_info;
    end
    [U2] = reorg_vec(FEM_out0.OUT.U); % Reorganize U vector
    
    % Update nodal locations
    % Include out-of-plane
    FEM00.MODEL.nodes = FEM00.MODEL.nodes + U2(:,1:3);
    FEM00.MODEL.orientation(FEM00.el_ind.ind1,1:2) = FEM00.MODEL.nodes(FEM00.el_ind.ind1,1:2);
    [FEM00.MODEL.orientation(FEM00.el_ind.ind1,:)] = orient_tor(FEM00.MODEL.orientation(FEM00.el_ind.ind1,:),U2(FEM00.el_ind.ind1,:));
    
    % Load out-of-plane
    F_out = F_oop(i);
    FEM00.MODEL.F_pt((I_theta_load - 1)*6 + 3,2) = -F_out;
    
    % Bound cable ends
    cableB = [zeros(3,size(I_theta_cable,1)*2)
        ones(3,size(I_theta_cable,1)*2)];
    FEM00.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);
    
    % Unbound torus
    torB = zeros(6,size(ind.ind1,1));
    % % % torB(3,:) = 1; % Bound out-of-plane
    FEM00.MODEL.B(1:ind.ind1(end)*6) = torB(:);
    
    % Controls
    [FEM00.ANALYSIS] = FE_controls00;
    FE_plot(FEM00)
    
    % Analyze
    [FEM_out00] = increment_FE(FEM00);
    
    FE_plot(FEM_out00)
    plot_tor_shape(FEM_out00)
    
    t3 = toc(t0);
    fprintf('Out-of-plane analysis complete\nAnalysis time = %g s\n\n',t3 - t2)
    
    
    
    
    %%
    % Analysis1 - 10 lb pre-load
    FEM1 = FEM_out00; % Initial input
    
    FEM1.MODEL.F_pre = FEM1.OUT.Fext_inc(:,end);
    
    if(FEM0.ANALYSIS.save_FE_info)
        FEM1.iter_info = FEM_out0.iter_info;
    end
    [U2] = reorg_vec(FEM_out0.OUT.U); % Reorganize U vector
    
    % Update nodal locations
    % Include out-of-plane
    FEM1.MODEL.nodes = FEM1.MODEL.nodes + U2(:,1:3);
    FEM1.MODEL.orientation(FEM1.el_ind.ind1,1:2) = FEM1.MODEL.nodes(FEM1.el_ind.ind1,1:2);
    [FEM1.MODEL.orientation(FEM1.el_ind.ind1,:)] = orient_tor(FEM1.MODEL.orientation(FEM1.el_ind.ind1,:),U2(FEM1.el_ind.ind1,:));
    
    % % Don't include out-of-plane
    % FEM1.MODEL.nodes = FEM1.MODEL.nodes + [U2(:,1:2) zeros(size(U2,1),1)];
    % FEM1.MODEL.orientation(FEM1.el_ind.ind1,1:2) = FEM1.MODEL.nodes(FEM1.el_ind.ind1,1:2);
    
    % Load cable ends
    Fmag = 10; % Cable end force
    [FEM1.MODEL.F_pt] = cable_F(ind,theta,I_theta_cable,Fmag);
    
    % Bound cable ends
    cableB = [zeros(3,size(I_theta_cable,1)*2)
        ones(3,size(I_theta_cable,1)*2)];
    FEM1.MODEL.B(ind.ind2(end)*6 + 1:ind.ind3(end)*6) = cableB(:);
    
    % Unbound torus
    torB = zeros(6,size(ind.ind1,1));
    % % % torB(3,:) = 1; % Bound out-of-plane
    FEM1.MODEL.B(1:ind.ind1(end)*6) = torB(:);
    
    % Controls
    [FEM1.ANALYSIS] = FE_controls1;
    FE_plot(FEM1)
    
    % Analyze
    [FEM_out1] = increment_FE(FEM1);
    
    FE_plot(FEM_out1)
    plot_tor_shape(FEM_out1)
    
    t3 = toc(t0);
    fprintf('Cable preload analysis complete\nAnalysis time = %g s\n\n',t3 - t2)
    
    
    
    %%
    % Analysis2 - cable displacement
    FEM2 = FEM_out1;
    
    FEM2.MODEL.F_pre = FEM2.OUT.Fext_inc(:,end);
    
    % Displace cable ends
    Umag = Umag_i(i); % Cable end displacment
    
    [FEM2.MODEL.U_pt] = cable_disp(ind,theta,I_theta_cable,Umag);
    % [FEM2.MODEL.F_pt] = cable_F2(ind,theta,I_theta_cable,F_cable');
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
    plot_tor_shape(FEM_out2)
    
    t4 = toc(t0);
    fprintf('Cable displacement analysis complete\nAnalysis time = %g s\n\n',t4 - t3)
    
    
    
    f = figure(3);
    savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\ave_rad_%g',round(F_out)))
    clf
    f = figure(4);
    savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\FE_plot_%g',round(F_out)))
    clf
    f = figure(2);
    savefig(f,sprintf('C:\\Users\\andrew.young\\Desktop\\Repo\\1115_NASA\\HIAD_FE\\analyses\\16_07_13_tori_param\\output\\ip_op_%g',round(F_out)))
    clf
end











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




