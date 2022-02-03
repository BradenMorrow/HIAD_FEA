% Post process T4A-1 torus test data and analysis
% Andy Young
% September 12, 2015

addpath 'C:\Users\andrew.young\Desktop\T4A-1\cable_point_coordinates'

% Preallocate
xL = zeros(91,32);
yL = zeros(91,32);
zL = zeros(91,32);

xU = zeros(91,32);
yU = zeros(91,32);
zU = zeros(91,32);

% Load data
for i = 1:91
    d = load(sprintf('cables%g.dat',i));
    xL(i,:) = d(1:32,1)';
    yL(i,:) = d(1:32,2)';
    zL(i,:) = d(1:32,3)';
    
    xU(i,:) = d(33:64,1)';
    yU(i,:) = d(33:64,2)';
    zU(i,:) = d(33:64,3)';
end



rL = (xL.^2 + yL.^2).^.5;
rU = (xU.^2 + yU.^2).^.5;

rL0 = rL(1,:);
rU0 = rU(1,:);
for i = 1:91
    rL(i,:) = rL(i,:) - rL0;
    rU(i,:) = rU(i,:) - rU0;
end

rL64 = rL(64,:) - rL(63,:);
rU64 = rU(64,:) - rU(63,:);
for i = 64:91
    rL(i,:) = rL(i,:) - rL64;
    rU(i,:) = rU(i,:) - rU64;
end


xL(isnan(xL)) = 0;
yL(isnan(yL)) = 0;
zL(isnan(zL)) = 0;

xU(isnan(xU)) = 0;
yU(isnan(yU)) = 0;
zU(isnan(zU)) = 0;

% rL(64:end,:) = rL(64:end,:) + (rL(64:end,:) - rL(63,:));

t = [0.180010000000000,0.680039000000000,1.18006800000000,1.68009600000000,2.18012500000000,2.68015300000000,3.18018200000000,3.68021100000000,4.18023900000000,4.68026800000000,5.18029600000000,5.68032500000000,6.18035400000000,6.68038200000000,7.18041100000000,7.68043900000000,8.18046800000000,8.68049600000000,9.18052500000000,9.67955400000000,10.1795820000000,10.6796110000000,11.1796390000000,11.6796680000000,12.1796970000000,12.6797250000000,13.1797540000000,13.6797820000000,14.1798110000000,14.6798400000000,15.1798680000000,15.6798970000000,16.1799250000000,16.6799540000000,17.1799830000000,17.6800110000000,18.1800400000000,18.6800680000000,19.1800970000000,19.6801260000000,20.1801540000000,20.6801830000000,21.1802120000000,21.6802400000000,22.1802690000000,22.6802970000000,23.1803260000000,23.6803550000000,24.1803830000000,24.6804120000000,25.1804400000000,25.6804690000000,26.1804980000000,26.6805260000000,27.1795540000000,27.6795830000000,28.1796120000000,28.6796400000000,29.1796690000000,29.6796980000000,30.1797260000000,30.6797550000000,31.1797830000000,31.6798120000000,32.1798410000000,32.6798690000000,33.1798980000000,33.6799260000000,34.1799550000000,34.6799840000000,35.1800120000000,35.6800410000000,36.1800690000000,36.6800980000000,37.1801270000000,37.6801550000000,38.1801840000000,38.6802120000000,39.1802410000000,39.6802700000000,40.1802980000000,40.6803270000000,41.1803560000000,41.6803840000000,42.1804130000000,42.6804410000000,43.1804700000000,43.6804980000000,44.1805270000000,44.6795550000000,45.1795840000000]';

%%
figure(4)
clf
box on
hold on

for i = 1:32
    plot3(i*ones(91,1),t,rL(:,i),'r--')
    plot3(i*ones(91,1),t,rU(:,i),'b-')
end



xlim([1 32])
ylim([0 45])
zlim([-4 2])

xlabel('Cable number')
ylabel('Time (s)')
zlabel('Radial displacement (in)')

view(60,30)
% view(90,0)
% view(0,0)


% ind = 63
% plot3(28,t(ind),rU(ind,28),'go','markersize',5,'linewidth',3)



%% 
% rL(isnan(rL)) = 0;
% rU(isnan(rU)) = 0;
rLmax = rL;
rUmax = rU;
rLmax(t >= 40,:) = [];
rUmax(t >= 40,:) = [];







rL1 = rLmax(end,:)';
rU1 = rUmax(end,:)';


figure(5)
clf

subplot(2,1,1)
box on
hold on
plot(rL1,'bx','markersize',10,'linewidth',3)

xlim([1 32])
ylim([-5 1])

subplot(2,1,2)
box on
hold on
plot(rU1,'bx','markersize',10,'linewidth',3)

xlim([1 32])
ylim([-5 1])




rL1_int = rL1;
rL1_int(1) = (rL1(29) - rL1(2))/5*1 + rL1(2);
rL1_int(32) = (rL1(29) - rL1(2))/5*2 + rL1(2);
rL1_int(31) = (rL1(29) - rL1(2))/5*3 + rL1(2);
rL1_int(30) = (rL1(29) - rL1(2))/5*4 + rL1(2);

rL1_int(8) = (rL1(10) - rL1(7))/3*1 + rL1(7);
rL1_int(9) = (rL1(10) - rL1(7))/3*2 + rL1(7);

rL1_int(16) = (rL1(18) - rL1(15))/3*1 + rL1(15);
rL1_int(17) = (rL1(18) - rL1(15))/3*2 + rL1(15);


subplot(2,1,1)
box on
hold on
plot([1 8 9 16 17 30 31 32],rL1_int([1 8 9 16 17 30 31 32]),'go','markersize',5,'linewidth',3)




%% Fourier
rL_in = [rL1_int; rL1_int(1)];
rU_in = [rU1; rU1(1)];


numpts = 100; % Number of spline points
n_wave = 4; % Number of waves
nn = 1 + 32; % Number of nodes

th = linspace(0,360,numpts)'; % Interpolation theta
theta = linspace(0,360,33)';

% Radius
r_spline = spline(theta,rL_in); % Create spline
r_int = ppval(r_spline,th); % Interpolate
[RL] = fourier(th*pi/180,r_int,n_wave,theta(1:32)*pi/180); % Fourier expansion

r_spline = spline(theta,rU_in); % Create spline
r_int = ppval(r_spline,th); % Interpolate
[RU] = fourier(th*pi/180,r_int,n_wave,theta(1:32)*pi/180); % Fourier expansion





figure(5)
subplot(2,1,1)
plot(RL,'cs-')
% plot(linspace(1,33,length(r_int)),r_int,'r')

xlabel('Cable number')
ylabel('Radial displacement (in)')
title('Bottom Cables')


figure(5)
subplot(2,1,2)
plot(RU,'cs-')
% plot(linspace(1,33,length(r_int)),r_int,'r')

xlabel('Cable number')
ylabel('Radial displacement (in)')
title('Top Cables')

subplot(2,1,2)
leg(1) = plot([-100 -100],[-100 -100],'bx','markersize',10,'linewidth',3);
leg(2) = plot([-100 -100],[-100 -100],'go','markersize',5,'linewidth',3);
leg(3) = plot([-100 -100],[-100 -100],'cs-');

legend(leg,...
    sprintf('Measured radial\ndisplacement'),...
    sprintf('Missing,\ninterpolated data'),...
    sprintf('Fourier exansion\n(n = 4)'),...
    'location','south','orientation','horizontal')


















%% Loop

ind = 87;

RL = zeros(ind,32);
RU = zeros(ind,32);

for i = 1:ind

    rL1 = rL(i,:)';
    rU1 = rU(i,:)';





    % Interpolate missing data
    rL1_int = rL1;
    rL1_int(1) = (rL1(29) - rL1(2))/5*1 + rL1(2);
    rL1_int(32) = (rL1(29) - rL1(2))/5*2 + rL1(2);
    rL1_int(31) = (rL1(29) - rL1(2))/5*3 + rL1(2);
    rL1_int(30) = (rL1(29) - rL1(2))/5*4 + rL1(2);

    rL1_int(8) = (rL1(10) - rL1(7))/3*1 + rL1(7);
    rL1_int(9) = (rL1(10) - rL1(7))/3*2 + rL1(7);

    rL1_int(16) = (rL1(18) - rL1(15))/3*1 + rL1(15);
    rL1_int(17) = (rL1(18) - rL1(15))/3*2 + rL1(15);



    % Fourier
    rL_in = [rL1_int; rL1_int(1)];
    rU_in = [rU1; rU1(1)];


    numpts = 100; % Number of spline points
    n_wave = 4; % Number of waves
    nn = 1 + 32; % Number of nodes

    th = linspace(0,360,numpts)'; % Interpolation theta
    theta = linspace(0,360,33)';

    % Radius
    r_spline = spline(theta,rL_in); % Create spline
    r_int = ppval(r_spline,th); % Interpolate
    [RLi] = fourier(th*pi/180,r_int,n_wave,theta(1:32)*pi/180); % Fourier expansion
    
    RL(i,:) = RLi';
    
    r_spline = spline(theta,rU_in); % Create spline
    r_int = ppval(r_spline,th); % Interpolate
    [RUi] = fourier(th*pi/180,r_int,n_wave,theta(1:32)*pi/180); % Fourier expansion
    
    RU(i,:) = RUi';

% % %         figure(5)
% % %         clf
% % % 
% % %         subplot(2,1,1)
% % %         box on
% % %         hold on
% % %         plot(rL1,'bx','markersize',10,'linewidth',3)
% % % 
% % %         xlim([1 32])
% % %         ylim([-5 1])
% % % 
% % %         subplot(2,1,2)
% % %         box on
% % %         hold on
% % %         plot(rU1,'bx','markersize',10,'linewidth',3)
% % % 
% % %         xlim([1 32])
% % %         ylim([-5 1])
% % % 
% % %         subplot(2,1,1)
% % %         box on
% % %         hold on
% % %         plot([1 8 9 16 17 30 31 32],rL1_int([1 8 9 16 17 30 31 32]),'go','markersize',5,'linewidth',3)
% % % 
% % %         figure(5)
% % %         subplot(2,1,1)
% % %         plot(RLi,'c-')
% % %         % plot(linspace(1,33,length(r_int)),r_int,'r')
% % % 
% % %         xlabel('Cable number')
% % %         ylabel('Radial displacement (in)')
% % %         title('Bottom Cables')
% % % 
% % % 
% % %         figure(5)
% % %         subplot(2,1,2)
% % %         plot(RUi,'c-')
% % %         % plot(linspace(1,33,length(r_int)),r_int,'r')
% % % 
% % %         xlabel('Cable number')
% % %         ylabel('Radial displacement (in)')
% % %         title('Top Cables')
% % % 
% % %         subplot(2,1,2)
% % %         leg(1) = plot([-100 -100],[-100 -100],'bx','markersize',10,'linewidth',3);
% % %         leg(2) = plot([-100 -100],[-100 -100],'go','markersize',5,'linewidth',3);
% % %         leg(3) = plot([-100 -100],[-100 -100],'c-');
% % % 
% % %         legend(leg,...
% % %             sprintf('Measured radial\ndisplacement'),...
% % %             sprintf('Missing,\ninterpolated data'),...
% % %             sprintf('Fourier exansion\n(n = 4)'),...
% % %             'location','south','orientation','horizontal')
% % % 
% % % 
% % %         if rem(i,10) == 0
% % %             a = 1;
% % %         end

end

dt = (t(ind) - t(ind - 1));
kL = (RL(end,:) - RL(end - 1,:))/dt;
kU = (RU(end,:) - RU(end - 1,:))/dt;

% t2 = [t(1:ind)
%     100 + t(ind)];
% RL2 = [RL
%     kL*100 + RL(end,:)];
% RU2 = [RU
%     kU*100 + RU(end,:)];

t2 = [t; (t(end) + dt:dt:t(end) + dt*40)'];
RL0 = kL.*dt;
RU0 = kU*dt;

RL2 = RL;
RU2 = RU;

while size(RL2,1) < length(t2)
    RL2 = [RL2; RL2(end,:) + RL0];
    RU2 = [RU2; RU2(end,:) + RU0];
end


%%
figure(6)
clf
box on
hold on

for i = 1:32
    plot3(i*ones(91,1),t,rL(:,i),'r--')
    plot3(i*ones(91,1),t,rU(:,i),'b-')
    plot3(i*ones(ind,1),t(1:ind),RL(:,i),'c--','linewidth',2)
    plot3(i*ones(ind,1),t(1:ind),RU(:,i),'m-','linewidth',2)
end



view(60,30)
% view(90,0)
% view(0,0)



% for i = 1:32
%     figure
% %     clf
% %     box on
%     hold on
% 
%     plot(t,rL(:,i),'r--')
%     plot(t,rU(:,i),'bx-')
%     plot(t2,RL2(:,i),'cx-','linewidth',2)
%     plot(t2,RU2(:,i),'mx-','linewidth',2)
%     
%     xlim([0 70])
% end










% U_pt
theta_st = theta(1:end - 1);

U_strap_xL = zeros(size(RL2));
U_strap_yL = zeros(size(RL2));
U_strap_xU = zeros(size(RU2));
U_strap_yU = zeros(size(RU2));

for i = 1:32
    U_strap_xL(:,i) = RL2(:,i)*cos(theta_st(i)*pi/180);
    U_strap_yL(:,i) = RL2(:,i)*sin(theta_st(i)*pi/180);
    U_strap_xU(:,i) = RU2(:,i)*cos(theta_st(i)*pi/180);
    U_strap_yU(:,i) = RU2(:,i)*sin(theta_st(i)*pi/180);
end


% U_pt0 = zeros(64*6,ind + 1);
U_pt0 = zeros(64*6,size(U_strap_xL,1));

count = 1;
for i = 1:12:64*6
    U_pt0(i,:) = U_strap_xL(:,count)';
    U_pt0(i + 1,:) = U_strap_yL(:,count)';
    
    U_pt0(i + 6,:) = U_strap_xU(:,count)';
    U_pt0(i + 7,:) = U_strap_yU(:,count)';
    
    count = count + 1;
end







a = 1;




