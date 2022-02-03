function [test_out] = torus_data_post_proc_T3AP_5_torsion
% Script for post processing torus data
% June 23, 2016

%% Test data
% Set directory
dir0 = 'C:\Users\ayoung\Desktop\Repo\1115_NASA\HIAD_FE';
dir_working = '.\analyses\16_07_13_tori_param\torus\torsion_test';
mat_file_ID = 10000;
csv_file_ID = '2016-11-07_15.04.26_T3AP-5_Buckling_15psi_1_Mat.csv';

%  Specify indices of interest
ind = (1:344)';
ind1 = (93:208)';

% Go to analysis directory
cd(dir_working)

% Load data
d = csvread(csv_file_ID,0,1);
d = d(ind,:);

% Get cable displacement
U = d(:,71 - 2:71 + 15 - 2);

% Get cable forces
% P = d(ind,8:4:8 + 15*4);
P = d(:,8 - 2:4:8 + 15*4 - 2);

% Load torus shape
load('cgall.mat')
% % % cgall0 = cgall;
% % % cg0 = cgall{1};
cgall = cgall(ind);

% Check data
for i = 1:size(cgall,1)
    cgall{i}(abs(cgall{i}(:,1)) > 100,:) = [];
    cgall{i}(abs(cgall{i}(:,2)) > 100,:) = [];
    cgall{i}(abs(cgall{i}(:,3)) > 100,:) = [];
end

% Save data
% % % save(sprintf('torus_%g',mat_file_ID),'U','P','cgall');
cd(dir0)



%% Geometry
% Calculate R, theta and z
R = cell(size(cgall));
theta = cell(size(cgall));
z = cell(size(cgall));
for j = 1:size(cgall,1)
    R{j} = hypot(cgall{j}(:,1),cgall{j}(:,2));
    theta{j} = atan2(cgall{j}(:,2),cgall{j}(:,1));
    z{j} = cgall{j}(:,3);
    
    % Arrange theta values as 0-2pi
    theta{j}(theta{j} < 0) = theta{j}(theta{j} < 0) + 2*pi;
end

% Reinterpolate geometry
n = 500;
cg_cyl = zeros(n,3,size(cgall,1));
cg = zeros(n,3,size(cgall,1));
for k = 1:size(cgall,1)
    % In cylindrical coordinates
    th = linspace(theta{k}(1),theta{k}(end),n)';
    cg_cyl(:,1,k) = interp1(theta{k},R{k},th)';
    cg_cyl(:,2,k) = th;
    cg_cyl(:,3,k) = interp1(theta{k},z{k},th)';
    
    % In cartesian
    cg(:,1,k) = cg_cyl(:,1,k).*cos(th);
    cg(:,2,k) = cg_cyl(:,1,k).*sin(th);
    cg(:,3,k) = cg_cyl(:,3,k);
end



%% Cable stiffness
[d_tor] = get_disp(cg(:,:,ind1),U(ind1,:));

p_r = 0; % Percent data removed from the end
alias1 = 200; %20; % Number of points used
smooth_n = 5; % Used in smooth
lim = 2; % Limit of lines

[pp] = cable_stiff_22NOV16(d_tor,P(ind1,:),p_r,alias1,smooth_n,lim,1000);



%% Store for analysis
tor_10000.U = U;
tor_10000.P = P;
tor_10000.cg = cg;
tor_10000.cg_cyl = cg_cyl;
tor_10000.cg_test = cg;
tor_10000.pp = pp;

test_out.tor_10000 = tor_10000;

save('C:\Users\andrew.young\Desktop\Repo\1115_NASA\HIAD_FE\analyses\16_07_13_tori_param\torus\torsion_test\test_out_10000','test_out')
% % % load('test_out_10000')



%% Plot cable displacement and force
% Plotting displacement
figure(1)
clf
subplot(2,1,1)
box on
hold on
plot(U,'-')
title('Cable end displacement')
ylabel('Displacement')
xlabel('Points of interest')

%Plotting force
subplot(2,1,2)
box on
hold on
plot(P)
title('Cable Force')
ylabel('Force')
xlabel('Points of interest')



%% Visualize results
% Plot test output
figure(3)
clf

% Plotting r vs theta.
subplot(2,1,1)
box on
hold on
for i = 1:size(R,1)
    plot(theta{i}*180/pi,R{i})
end

xlim([0 360])
title('r vs theta')
xlabel('theta')
ylabel('radius')

% Plotting z vs theta.
subplot(2,1,2)
box on
hold on
for i = 1:size(R,1)
    plot(theta{i}*180/pi,z{i})
end

xlim([0 360])
title('z vs theta')
xlabel('theta')
ylabel('elevation')



%%
plot_ind = [1 207]';

figure(4)
clf

% Plotting r vs theta.
subplot(2,1,1)
box on
hold on
for i = 1:size(plot_ind,1)
    % plot(theta{plot_ind(i)}*180/pi,R{plot_ind(i)},'--','linewidth',2)
    plot(cg_cyl(:,2,plot_ind(i))*180/pi,cg_cyl(:,1,plot_ind(i)),'-','linewidth',2)
end

xlim([0 2*pi*180/pi])
title('r vs theta')
xlabel('theta (degrees)')
ylabel('radius (inches)')

% Plotting z vs theta.
z_bar = mean(cg_cyl(:,3,plot_ind(1)));
subplot(2,1,2)
box on
hold on
for i = 1:size(plot_ind,1)
    % plot(theta{plot_ind(i)}*180/pi,z{plot_ind(i)},'--','linewidth',2)
    plot(cg_cyl(:,2,plot_ind(i))*180/pi,cg_cyl(:,3,plot_ind(i)) - z_bar,'-','linewidth',2)
end

xlim([0 2*pi*180/pi])
title('z vs theta')
xlabel('theta (degrees)')
ylabel('Z location (inches)')


% % % % Plot cable load versus displacement
% % % figure(5)
% % % clf
% % % box on
% % % hold on
% % % for i = 1:size(U,2)
% % %     plot(-(U(:,i) - U(1,i)),P(:,i))
% % % end


% Plot total cable load
figure(6)
clf
box on
hold on
plot(sum(P,2),'bx-')




end