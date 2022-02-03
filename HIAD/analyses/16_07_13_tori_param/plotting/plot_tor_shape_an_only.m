function plot_tor_shape_an_only(FEM)


%%
% % % % From test data
% % % th_test = linspace(0,360,25)';
% % % r_test0 = interp1(FEM.PLOT.tor_cyl(:,2,1),FEM.PLOT.tor_cyl(:,1,1),th_test*pi/180,'linear','extrap');
% % % z_test0 = interp1(FEM.PLOT.tor_cyl(:,2,1),FEM.PLOT.tor_cyl(:,3,1),th_test*pi/180,'linear','extrap');
% % % r_test1 = interp1(FEM.PLOT.tor_cyl(:,2,end),FEM.PLOT.tor_cyl(:,1,end),th_test*pi/180,'linear','extrap');
% % % z_test1 = interp1(FEM.PLOT.tor_cyl(:,2,end),FEM.PLOT.tor_cyl(:,3,end),th_test*pi/180,'linear','extrap');



% % % Rave = FEM.PLOT.Rave;
% % % Rave(end) = [];
% % % P = sum(FEM.PLOT.P,2);
% % % P(end) = [];

% Model output
% Reorganize U
U = FEM.OUT.U;
U2 = reorg_vec(U);

% Initial location of nodes
nodes = FEM.MODEL.nodes;
tor_ind = FEM.el_ind.ind1; % Indices of torus elements

% Model theta
th_model = atan2(nodes(tor_ind,2),nodes(tor_ind,1))*180/pi;
th_model(th_model < 0) = th_model(th_model < 0) + 360;
[th_model,Ith] = sort(th_model);

r_model0 = hypot(nodes(tor_ind(Ith),1),nodes(tor_ind(Ith),2)); % Initial R location
z_model0 = nodes(tor_ind(Ith),3); % Initial Z location
r_model1 = hypot(nodes(tor_ind(Ith),1) + U2(tor_ind(Ith),1),nodes(tor_ind(Ith),2) + U2(tor_ind(Ith),2)); % Current R location
z_model1 = nodes(tor_ind(Ith),3) + U2(tor_ind(Ith),3); % Current Z location

% Total cable forces
% % % Ftest = P(end);
Fmod = sum(FEM.OUT.fint_el(7,FEM.el_ind.ind3,end));

%% Plotting
% figure(FEM.PLOT.fig + 1)
figure(1000)
% clf

% R direction displacement
subplot(2,1,1)
box on
hold on
% Test R
% % % plot(th_test,r_test0,'bx','markersize',8,'linewidth',2)
% % % plot(th_test,r_test1,'go','markersize',5,'linewidth',2)

% Model R
plot(th_model,r_model0,'b-')
plot(th_model,r_model1,'g-')
title('r vs theta')
xlabel('Theta (degrees)')
ylabel('Radius (inches)')
xlim([0 360])

text(10,(max(r_model1) - mean(r_model1))*1.2 + mean(r_model1),sprintf('F_{model} = %1.0f lbf',Fmod))

% Z direction displacement
subplot(2,1,2)
box on
hold on

% % % % Test Z
% % % plot(th_test,z_test0,'bx','markersize',8,'linewidth',2)
% % % plot(th_test,z_test1,'go','markersize',5,'linewidth',2)

% Model Z
plot(th_model,z_model0,'b-')
plot(th_model,z_model1,'g-')
title('z vs theta')
xlabel('Theta (degrees)')
ylabel('Z location (inches)')
xlim([0 360])

% % % legend('Model, initial', ...
% % %     'Model, final', ...
% % %     'location','south', ...
% % %     'orientation','horizontal')

drawnow





% Total load versus cable end displacement response
F = FEM.OUT.fint_el(7,FEM.el_ind.ind3,:);
F = permute(F,[2,3,1]);
F = sum(F)';

Ux = FEM.OUT.Uinc((FEM.el_ind.ind3(1) - 1)*6 + 1,:)';
% Ux = Ux - max(Ux);
Uy = FEM.OUT.Uinc((FEM.el_ind.ind3(1) - 1)*6 + 2,:)';
% Uy = Uy - max(Uy);
Ucable = (Ux.^2 + Uy.^2).^.5;

ind = min([size(Ucable,1) size(F,1)]);
% % % F(FEM.PASS.iter_info(:,3) < 2) = [];
% % % Ucable(FEM.PASS.iter_info(:,3) < 2) = [];
% % % 
% % % Ucable = Ucable - Ucable(1);


figure(FEM.PLOT.fig + 2)
clf
box on
hold on
plot(Ucable(1:ind),F(1:ind),'bx-')

xlabel('Displacement (in)')
ylabel('Total load (lbf)')






% % % % clf
% % % box on
% % % hold on
% % % % % % plot(Rave,P,'r-')
% % % plot(mean(r_model1),Fmod,'bx')
% % % 
% % % xlabel('Average torus radius (in)')
% % % ylabel('Total cable load (lbf)')
% % % 
% % % % xlim([69.75 69.95])
% % % % ylim([0 5000])

drawnow
end