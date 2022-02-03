% Post process analysis
% June 29, 2015
% 60 degrees, 20 psi, T5C-1

% Load output
load('inc_out_28JUN15.mat')

% Deformed shape
FEM.PLOT.scale = 1;
FE_plot(FEM)

% Load - deformation plot
eval(FEM.PLOT.plot_shape)
xlim([0 1])




%% Deformation
N_tor = FEM.GEOM.nodes(FEM.CONFIG.ind,:);
theta = linspace(0,2*pi,size(FEM.CONFIG.ind,1))';

R0 = sum(N_tor(:,1:2).^2,2).^.5;

figure(100)
clf

subplot(2,1,1)
box on
hold on
plot(theta*180/pi,R0,'r-')
xlim([0 360])
ylim([75 85])
xlabel('Angle')
ylabel('R')

subplot(2,1,2)
box on
hold on
plot(theta*180/pi,N_tor(:,3),'r-')
xlim([0 360])
ylim([-1 3])
xlabel('Angle')
ylabel('Z')



for i  = 1:size(FEM.OUT.Uinc,2)
    U = FEM.OUT.Uinc(:,i);
    U2 = zeros(length(U)/6,6);
    for j = 1:6
        U2(:,j) = U(j:6:length(U));
    end
    U_tor = U2(FEM.CONFIG.ind,:);
    R = sum((U_tor(:,1:2) + N_tor(:,1:2)).^2,2).^.5;
    
    if i == 1
        C = 'r-';
        LW = 2;
    elseif i == size(FEM.OUT.Uinc,2)
        C = 'g-';
        LW = 1;
    else
        C = 'b--';
        LW = 1;
    end
    subplot(2,1,1)
    box on
    hold on
    plot(theta*180/pi,R,C,'linewidth',LW)
    
    subplot(2,1,2)
    box on
    hold on
    plot(theta*180/pi,N_tor(:,3) + U_tor(:,3),C,'linewidth',LW)
end

%% Strap forces
f1 = zeros(64,size(FEM.OUT.fint_el,3));
ind1 = FEM.SPRING(2).ind(1);

f = sum(FEM.OUT.fint_el(7:9,ind1:ind1 + 63,:).^2).^.5;
ind1 = linspace(0,1,size(f,3))';
for k = 1:size(f,3)
    f1(:,k) = f(1,:,k)';
end

d = csvread('130815_141249_20_T5C1_20PSI_COMP3.csv',6,12);
d(:,65:end) = [];
d = d';
d = d(:,780:1400);
ind2 = linspace(0,1,size(d,2))';

figure(10)
clf
box on
hold on

for i = 1:64
%     plot(ind1,f1(i,:),'b-')
    plot(ind2,d(i,:),'g-')
end

ylabel('Cable force (lbf)')
xlim([0 1])
ylim([0 140])
