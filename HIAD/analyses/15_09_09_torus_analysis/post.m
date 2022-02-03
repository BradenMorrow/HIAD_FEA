% Post process T4A-1 torus test data and analysis
% Andy Young
% September 12, 2015

% rmpath 'C:\Users\andrew.young\Desktop\T4A-1\2015-09-11 T4A-2 Buckle Test 1 apprx 19psi'
addpath 'C:\Users\andrew.young\Desktop\T4A-1\cable_point_coordinates'

%% TEST
%% Cable loads
i_max = 91;

p = xlsread('data_12SEP15');
p(1,:) = [];
ind = (1:i_max)';


t = p(ind,1);
str = (1:32)'; % (0:360/32:360 - 360/32)';
pL = p(ind,3:34);
pU = p(ind,35:66);
pU(:,23:24) = 0; %-1000;

figure(2)
clf
box on
hold on

for i = 1:32
    plot3(str(i)*ones(size(t)),t,pL(:,i),'b-')
    plot3(str(i)*ones(size(t)),t,pU(:,i),'r--')
end
    

xlim([1 32])
ylim([0 45])
zlim([0 150])

xlabel('Cable number')
ylabel('Time (s)')
zlabel('Cable force')

view(60,30)
% view(90,0)
% view(0,0)



T = sum(pU(end,:)) + sum(pL(end,:));
Tind = T/62;
T = T + Tind*2;

%% Displaced shape
figure(3)
clf

% subplot(2,1,1)
subplot(2,3,1:2)
box on
hold on
xlim([0 360])

% subplot(2,1,2)
subplot(2,3,4:5)
box on
hold on
xlim([0 360])



theta = [0:360/32:360 - 360/32 360]';
ind = (30:112)';

R = zeros(33,i_max);

count = 1;
for i = 1:86:87 % Good to 91? Jump at 87 % 1:i_max % 
    xyz = load(sprintf('cg%g.dat',i));
    r = (xyz(:,1).^2 + xyz(:,2).^2).^.5;
    z = xyz(:,3);
    R(:,i) = r;
    
    if count == 1
%         subplot(2,1,1)
        subplot(2,3,1:2)
        plot(theta,r,'bx','linewidth',3,'markersize',8)

%         subplot(2,1,2)
        subplot(2,3,4:5)
        plot(theta,z,'bx','linewidth',3,'markersize',8)
    else
%         subplot(2,1,1)
        subplot(2,3,1:2)
        plot(theta,r,'go','linewidth',3,'markersize',3)

%         subplot(2,1,2)
        subplot(2,3,4:5)
        plot(theta,z,'go','linewidth',3,'markersize',3)
    end
    
    if rem(i,5) == 0
        a = 1;
    end
    
    if i == 87
        a = 1;
    end
    count = count + 1;
end

%% MODEL
load('out_14SEP15_2.mat')
% load('out_14SEP15_2_no_shape.mat')
inc = size(FEM_out_load.OUT.Uinc,2);

%% Cable loads
c_ind = FEM_out_load.SPRING(2).ind;
C = zeros(64,inc);

for i = 1:inc
    C(:,i) = FEM_out_load.OUT.fint_el(7,c_ind,i);
end

pLt = C(1:2:end,:);
pUt = C(2:2:end,:);


figure(2)
hold on
ti = linspace(0,t(end),inc);
for i = 1:32
    plot3(str(i)*ones(size(t)),t,interp1(ti,pLt(i,:),t),'g-')
    plot3(str(i)*ones(size(t)),t,interp1(ti,pUt(i,:),t),'g--')
end

%% Displaced shape
tor_ind = FEM_out_load.CONFIG.ind;

% U = FEM_out_load.OUT.Uinc(1:tor_ind(length(tor_ind))*6,1);
% U2 = zeros(length(tor_ind),6);
% for j = 1:6
%     U2(:,j) = U(j:6:length(U));
% end


nodes = FEM_out_load.GEOM.nodes(tor_ind,:);
Ri = (nodes(:,1).^2 + nodes(:,2).^2).^.5;
Zi = nodes(:,3);

theta_i = zeros(size(nodes,1),1);
for i = 1:size(nodes,1)
    theta_i(i) = atan2(nodes(i,2),nodes(i,1))*180/pi;
end
theta_i(theta_i < 0) = theta_i(theta_i < 0) + 360;
theta_i = [theta_i; 360];

U2i = zeros(length(tor_ind),6,inc);
ri = zeros(length(tor_ind),inc);
zi = zeros(length(tor_ind),inc);

for i = 1:inc
    U = FEM_out_load.OUT.Uinc(1:tor_ind(end)*6,i);
    U2 = zeros(length(tor_ind),6);
    for j = 1:6
        U2(:,j) = U(j:6:length(U));
    end
    
    U2i(:,:,i) = U2;
    
    ri(:,i) = Ri + U2(:,1).*cosd(theta_i(1:end - 1)) + U2(:,2).*sind(theta_i(1:end - 1)); % (U2(:,1).^2 + U2(:,2).^2).^.5;
    zi(:,i) = Zi + U2(:,3);
end



figure(3)
hold on

M_ind = 31;
for i = 1:6:32
    if i == 1
%         subplot(2,1,1)
        subplot(2,3,1:2)
        plot(theta_i,[ri(:,i); ri(1,i)],'b--','linewidth',2)

%         subplot(2,1,2)
        subplot(2,3,4:5)
        plot(theta_i,[zi(:,i); zi(1,i)],'b--','linewidth',2)
    elseif i ~= M_ind
%         subplot(2,1,1)
        subplot(2,3,1:2)
        plot(theta_i,[ri(:,i); ri(1,i)],'r-')

%         subplot(2,1,2)
        subplot(2,3,4:5)
        plot(theta_i,[zi(:,i); zi(1,i)],'r-')
    else
%         i = i + 1;
%         subplot(2,1,1)
        subplot(2,3,1:2)
        plot(theta_i,[ri(:,i); ri(1,i)],'g--','linewidth',2)

%         subplot(2,1,2)
        subplot(2,3,4:5)
        plot(theta_i,[zi(:,i); zi(1,i)],'g--','linewidth',2)
    end
end

% subplot(2,1,1)
subplot(2,3,1:2)
xlabel('\theta (deg)')
ylabel('r (in)')

% subplot(2,1,2)
subplot(2,3,4:5)
xlabel('\theta (deg)')
ylabel('z (in)')

subplot(2,3,[3 6])

hold on
plot([-100 -100],[-100 -100],'bx','linewidth',3,'markersize',8);
plot([-100 -100],[-100 -100],'go','linewidth',3,'markersize',3);
plot([-100 -100],[-100 -100],'b--','linewidth',2);
plot([-100 -100],[-100 -100],'r-');
plot([-100 -100],[-100 -100],'g--','linewidth',2);

legend('Measured, no load',...
    'Measured, 4,752 lb',...
    'Model, no load',...
    'Model, intermediate',...
    'Model, 4,985 lb',... % 'Model, 5,219 lb',... % 
    'location','west')

axis off


Ti = sum(pLt(:,M_ind)) + sum(pUt(:,M_ind));
Ti

%% Track radial displacement
% Cable 14
ind_T = 14;
ind_M = 34;
% theta(ind_T)
% theta_i(ind_M)

% Test
P_T = sum(pL' + pU')';
P_T = P_T/62*64;
R_T = R(ind_T,1) - R(ind_T,:)';

P_T(end - 3) = [];
R_T(end - 3) = [];

% Model
P_mod = sum(pLt + pUt)';
R_mod = ri(ind_M,1) - ri(ind_M,:)';


% Plot
figure(12)
clf
box on
hold on
plot(R_T,P_T,'b-')
plot(R_mod,P_mod,'r-')


xlabel('Radial displacement (in)')
ylabel('Total cable load (lbf)')
title('Load displacement, cable 14')
xlim([-.1 2.5])
ylim([0 5500])

legend('Test','Model','location','southeast')
set(gcf, 'Position', [700, 300, 400, 200]);





% Cable 1
ind_T = 1;
ind_M = 1;
% theta(ind_T)
% theta_i(ind_M)

% Test
P_T = sum(pL' + pU')';
P_T = P_T/62*64;
R_T = R(ind_T,1) - R(ind_T,:)';

P_T(end - 3) = [];
R_T(end - 3) = [];

% Model
P_mod = sum(pLt + pUt)';
R_mod = ri(ind_M,1) - ri(ind_M,:)';


% Plot
figure(13)
clf
box on
hold on
plot(R_T,P_T,'b-')
plot(R_mod,P_mod,'r-')


xlabel('Radial displacement (in)')
ylabel('Total cable load (lbf)')
title('Load displacement, cable 1')
xlim([-.1 2.5])
ylim([0 5500])

legend('Test','Model','location','southeast')
set(gcf, 'Position', [800, 300, 400, 200]);



% Cable 19
ind_T = 19;
ind_M = 47;
% theta(ind_T)
% theta_i(ind_M)

% Test
P_T = sum(pL' + pU')';
P_T = P_T/62*64;
R_T = R(ind_T,1) - R(ind_T,:)';

P_T(end - 3) = [];
R_T(end - 3) = [];

% Model
P_mod = sum(pLt + pUt)';
R_mod = ri(ind_M,1) - ri(ind_M,:)';


% Plot
figure(14)
clf
box on
hold on
plot(abs(R_T),P_T,'b-')
% plot(R_T(87),P_T(87),'bx')
plot(abs(R_mod),P_mod,'rx-')


xlabel('Radial displacement (in)')
ylabel('Total cable load (lbf)')
title('Load displacement, cable 19')
xlim([-.1 2.5])
ylim([0 5500])

legend('Test','Model','location','southeast')
set(gcf, 'Position', [900, 300, 400, 200]);











