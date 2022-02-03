function [k] = plot_out(FEM)
% HIAD analysis plotting function

% Z direction reaction
RZ_ind = (3:6:size(FEM.OUT.Fext_inc,1))';
Rz = sum(FEM.OUT.Fext_inc(RZ_ind,:))';

% +Y and -Y vertical displacement of T5
theta = FEM.MODEL.theta;
ind0 = round(interp1(theta,(1:size(theta,1))',[pi/2 3*pi/2]'));
ind = size(theta,1)*6*4 + (ind0 - 1)*6 + 3;
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
plot(Uvert0(ind) - Uvert0(ind(1)),-ram(ind),'g-','linewidth',2)
plot(Uvert90(ind) - Uvert90(ind(1)),-ram(ind),'m-','linewidth',2)
plot(Uvert270(ind) - Uvert270(ind(1)),-ram(ind),'c-','linewidth',2)

% Modeling
% plot(Uzp,Rz,'bo-')
plot(Uzm,Rz,'ro-','linewidth',2,'markersize',4)

xlabel('Vertical displacement of T7 (in)')
ylabel('Ram load (lbf)')
legend('Test, 0^o','Test, 90^o','Test, 270^o','Model','location','northwest')

ylim([0 8500])
xlim([0 3.5])


% End stiffness
k = (Rz(end) - Rz(end - 1))/(Uzp(end) - Uzp(end - 1));


end

