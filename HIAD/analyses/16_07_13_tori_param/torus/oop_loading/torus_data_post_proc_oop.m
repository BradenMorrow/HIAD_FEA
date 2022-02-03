function [test_out] = torus_data_post_proc_oop
% Script for post processing torus data
% June 23, 2016

%% Test data
%  Specify indices of interest
% Out-of-plane loading portion
% ind = (1:801)';
ind = (1:590)';
% % % ind1 = (105:435)';
load('cgall_1.mat')
d = csvread('oop_out1.csv',0,1);





%% Torus geometry
[U,P,R,theta,z,cg_cyl,cg] = proc_torus(d,cgall,ind);



%% Cable stiffness
% In-plane loading portion
% ind = (1:599)';
ind1 = (1:500)'; % 599)'; % 
ind2 = (105:435)'; % 500)'; %
load('cgall_2.mat')
d1 = csvread('oop_out2.csv',0,1);

[U1,P1,R1,theta1,z1,cg_cyl1,cg1,gamma1] = proc_torus(d1,cgall,ind1);


[d_tor] = get_disp(cg1(:,:,ind2),U1(ind2,:),gamma1(:,ind1),6.7);

p_r = 0; % Percent data removed from the end
alias1 = 20; %20; % Number of points used
smooth_n = 5; % Used in smooth
lim = 2; % Limit of lines

[pp] = cable_stiff_02DEC16(d_tor,P1(ind2,:),p_r,alias1,smooth_n,lim,1000);



%% Store for analysis
tor_10000.U = U;
tor_10000.P = P;
tor_10000.cg = cg;
tor_10000.cg_cyl = cg_cyl;
tor_10000.cg_test = cg;
tor_10000.pp = pp;

test_out.tor_10000 = tor_10000;

% save('C:\Users\andrew.young\Desktop\Repo\1115_NASA\HIAD_FE\analyses\16_07_13_tori_param\torus\oop_loading\test_out_oop','test_out')
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





% Plot test output
figure(5)
clf

% Plotting r vs theta.
subplot(2,1,1)
box on
hold on
for i = 1:size(R1,1)
    % plot(theta1{i}*180/pi,R1{i})
    plot(cg_cyl1(:,2,i)*180/pi,cg_cyl1(:,1,i));
end

xlim([0 360])
title('r vs theta')
xlabel('theta')
ylabel('radius')

% Plotting z vs theta.
subplot(2,1,2)
box on
hold on
for i = 1:size(R1,1)
    % plot(theta1{i}*180/pi,z1{i})
    plot(cg_cyl1(:,2,i)*180/pi,cg_cyl1(:,3,i));
end

xlim([0 360])
title('z vs theta')
xlabel('theta')
ylabel('elevation')



%%
plot_ind = [ind(1) ind(end)]';

figure(1000)
% figure(1000)
% clf

% Plotting r vs theta.
subplot(2,1,1)
box on
hold on
for i = 1:size(plot_ind,1)
    % plot(theta{plot_ind(i)}*180/pi,R{plot_ind(i)},'--','linewidth',2)
    plot(cg_cyl(:,2,plot_ind(i))*180/pi,cg_cyl(:,1,plot_ind(i)),'-','linewidth',1)
end

xlim([0 2*pi*180/pi])
title('r vs theta')
xlabel('theta (degrees)')
ylabel('radius (inches)')

% Plotting z vs theta.
z_bar = 0; % mean(cg_cyl(:,3,plot_ind(1))); % -.35; % 
subplot(2,1,2)
box on
hold on
for i = 1:size(plot_ind,1)
    % plot(theta{plot_ind(i)}*180/pi,z{plot_ind(i)},'--','linewidth',2)
    plot(cg_cyl(:,2,plot_ind(i))*180/pi,cg_cyl(:,3,plot_ind(i)) - z_bar,'-','linewidth',1)
end

xlim([0 2*pi*180/pi])
title('z vs theta')
xlabel('theta (degrees)')
ylabel('Z location (inches)')



t1 = cg_cyl(:,2,plot_ind(2))*180/pi;
r1 = cg_cyl(:,1,plot_ind(2));
z1 = cg_cyl(:,3,plot_ind(2)) - z_bar;

t2 = cg_cyl1(:,2,end)*180/pi;
r2 = cg_cyl1(:,1,end);
z2 = cg_cyl1(:,3,end);

RZ_test = [t1 r1 z1 t2 r2 z2];

save('test1','RZ_test');


% % % legend('Test, initial', ...
% % %     'Test, final', ...
% % %     'location','south', ...
% % %     'orientation','horizontal')

% % % subplot(2,1,1)
% % % ylim([58 61])
% % % subplot(2,1,2)
% % % ylim([-2 1])
% % % 
% % % plot(.46405*[1 1]*180/pi,[-10 10],'k--')
% % % plot(.71405*[1 1]*180/pi,[-10 10],'k--')
% % % plot(2.0348*[1 1]*180/pi,[-10 10],'k--')
% % % plot(2.2848*[1 1]*180/pi,[-10 10],'k--')
% % % plot(3.6056*[1 1]*180/pi,[-10 10],'k--')
% % % plot(3.8556*[1 1]*180/pi,[-10 10],'k--')
% % % plot(5.1764*[1 1]*180/pi,[-10 10],'k--')
% % % plot(5.4264*[1 1]*180/pi,[-10 10],'k--')

% plot([0 360],[0 0],'k-')


%%
% Plot cable load versus displacement
figure(7)
clf
box on
hold on
for i = 1:size(U,2)
    plot(-(U(:,i) - U(1,i)),P(:,i))
end


% Plot total cable load
figure(6)
clf
box on
hold on
plot(sum(P1,2),'b-')

figure(8)
clf
box on
hold on
plot(U1(:,1))


end