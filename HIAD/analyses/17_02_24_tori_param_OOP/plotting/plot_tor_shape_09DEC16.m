function plot_tor_shape_09DEC16(FEM)


%%
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
% R & Z vs. Theta
% figure(FEM.PLOT.fig + 1)
figure(1000)
% clf

% R direction displacement
subplot(2,1,1)
box on
hold on

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

% Model Z
plot(th_model,z_model0,'b-')
plot(th_model,z_model1,'g-')
title('z vs theta')
xlabel('Theta (degrees)')
ylabel('Z location (inches)')
xlim([0 360])
ylim([-6 6])

drawnow




% Load vs. displacement
% Total load versus cable end displacement response
F = FEM.OUT.fint_el(7,FEM.el_ind.ind3,:);
F = permute(F,[2,3,1]);
F = sum(F)';

Ux = FEM.OUT.Uinc((FEM.el_ind.ind3(1) - 1)*6 + 1,:)';
Uy = FEM.OUT.Uinc((FEM.el_ind.ind3(1) - 1)*6 + 2,:)';
Ucable = (Ux.^2 + Uy.^2).^.5;

ind = min([size(Ucable,1) size(F,1)]);

% Average radius
Rave = zeros(size(FEM.OUT.Uinc,2),1);
for i = 1:size(Rave)
    U2 = reorg_vec(FEM.OUT.Uinc(:,i));
    
    Rave(i) = mean(hypot(nodes(tor_ind(Ith),1) + U2(tor_ind(Ith),1),nodes(tor_ind(Ith),2) + U2(tor_ind(Ith),2)));
end



figure(FEM.PLOT.fig + 2)
clf
box on
hold on
% plot(Ucable(1:ind),F(1:ind),'bx-')
plot((Rave(1:ind) - Rave(1)),F(1:ind),'bx-')

xlabel('Change in average radius (in)')
ylabel('Total load (lbf)')

figure(FEM.PLOT.fig + 3)
clf
box on
hold on
% plot(Ucable(1:ind),F(1:ind),'bx-')
plot((Rave(1:ind) - Rave(1))*25.4,F(1:ind)*4.448222/1000,'b-')

xlabel('Change in average radius (mm)')
ylabel('Total load (kN)')


drawnow
end















