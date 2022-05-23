function [k] = plot_out(FEM)
% HIAD analysis plotting function

Ufac = 25.4; % 1; % 
Ffac = 0.004448; % 1; % 

% Z direction reaction
RZ_ind = (3:6:size(FEM.OUT.Fext_inc,1))';
Rz = sum(FEM.OUT.Fext_inc(RZ_ind,:))';

% +Y and -Y vertical displacement of T5
theta = FEM.MODEL.theta;
ind0 = round(interp1(theta,(1:size(theta,1))',[pi/2 3*pi/2]'));
ind = size(theta,1)*6*6 + (ind0 - 1)*6 + 3;
Uz = FEM.OUT.Uinc(ind,:);
Uzp = Uz(1,:)';
Uzm = Uz(2,:)';



d = csvread('HAID Static Load Test -3.7m No TPS - Run[14] All 12 psi,No Tri-Torus,Cord Shunt.csv',1,0);
Uvert0 = d(:,53);
Uvert90 = d(:,54);
% Uvert180 = d(:,55);
Uvert270 = d(:,56);
ram = d(:,102);
% ram = ram - mean(ram(1:500));
ram = ram - max(ram);

ind = (542:1306)';
ram = ram - ram(ind(1));

% Plot results
figure(FEM.PLOT.fig + 1)
clf
box on
hold on

% Test data
Utest = mean([(Uvert0(ind) - Uvert0(ind(1))) (Uvert90(ind) - Uvert90(ind(1))) (Uvert270(ind) - Uvert270(ind(1)))],2);
plot(Utest*Ufac,-ram(ind)*Ffac,'k-','linewidth',2)
% % % plot((Uvert0(ind) - Uvert0(ind(1)))*Ufac,-ram(ind)*Ffac,'b-','linewidth',2)
% % % plot((Uvert90(ind) - Uvert90(ind(1)))*Ufac,-ram(ind)*Ffac,'b-','linewidth',2)
% % % plot((Uvert270(ind) - Uvert270(ind(1)))*Ufac,-ram(ind)*Ffac,'b-','linewidth',2)

% Modeling
% plot(Uzp,Rz,'bo-')
plot(Uzm*Ufac,Rz*Ffac,'r-','linewidth',1,'markersize',10)

% % % xlabel('Vertical displacement of T7 (in)')
% % % ylabel('Ram load (lbf)')
xlabel('Vertical displacement of T7 (mm)')
ylabel('Ram load (kN)')

leg(1) = plot([1 1]*-1000,[1 1]*-1000,'k-','linewidth',2);
leg(2) = plot([1 1]*-1000,[1 1]*-1000,'r-','linewidth',1,'markersize',10);

legend(leg,'Test','Model, simplified prestress method','location','northwest')

% % % ylim([0 9000])
% % % xlim([0 3.5])
ylim([0 40])
xlim([0 80])


% End stiffness
k = (Rz(end) - Rz(end - 1))/(Uzp(end) - Uzp(end - 1));


end

