function [th,r,z,F] = plot_tor_shape_sm_disp(FEM)


%%
% % % % Test output
% % % load('test_out') % Load test variables
% % % th_test = test_shape(:,2,2); % Reorganize
% % % r_test0 = test_shape(:,1,2);
% % % z_test0 = test_shape(:,3,2);
% % % r_test1 = test_shape(:,1,3);
% % % z_test1 = test_shape(:,3,3);

% From test data
th_test = linspace(0,360,25)';
r_test0 = interp1(FEM.PLOT.tor_cyl(:,2,1),FEM.PLOT.tor_cyl(:,1,1),th_test*pi/180,'linear','extrap');
z_test0 = interp1(FEM.PLOT.tor_cyl(:,2,1),FEM.PLOT.tor_cyl(:,3,1),th_test*pi/180,'linear','extrap');
r_test1 = interp1(FEM.PLOT.tor_cyl(:,2,end),FEM.PLOT.tor_cyl(:,1,end),th_test*pi/180,'linear','extrap');
z_test1 = interp1(FEM.PLOT.tor_cyl(:,2,end),FEM.PLOT.tor_cyl(:,3,end),th_test*pi/180,'linear','extrap');



Rave = FEM.PLOT.Rave;
Rave(end) = [];
P = sum(FEM.PLOT.P,2);
P(end) = [];

% Model output
% Reorganize U
U = FEM.OUT.U;
ind = 1:6:size(U,1);
ind = [ind ind + 1 ind + 2 ind + 3 ind + 4 ind + 5]';
U2 = zeros(length(U)/6,6);
U2(:) = U(ind);

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
Ftest = P(end);
F = sum(FEM.OUT.fint_el(7,FEM.el_ind.ind3,end));

%% Plotting
figure(FEM.PLOT.fig + 1)
clf

% R direction displacement
subplot(2,1,1)
box on
hold on
% Test R
plot(th_test,r_test0,'bx','markersize',8,'linewidth',2)
plot(th_test,r_test1,'go','markersize',5,'linewidth',2)

% Model R
plot(th_model,r_model0,'b-')
plot(th_model,r_model1,'g-')
xlabel('Theta (degrees)')
ylabel('Radius (inches)')
xlim([0 360])

text(10,(max(r_test1) - mean(r_test1))*.6 + mean(r_test1),sprintf('F_{test} = %1.0f lbf\nF_{model} = %1.0f lbf',Ftest,F))

% Z direction displacement
subplot(2,1,2)
box on
hold on

% Test Z
plot(th_test,z_test0,'bx','markersize',8,'linewidth',2)
plot(th_test,z_test1,'go','markersize',5,'linewidth',2)

% Model Z
plot(th_model,z_model0,'b-')
plot(th_model,z_model1,'g-')
xlabel('Theta (degrees)')
ylabel('Z location (inches)')
xlim([0 360])

legend('Test, initial', ...
    'Test, final', ...
    'Model, initial', ...
    'Model, final', ...
    'location','south', ...
    'orientation','horizontal')

drawnow



figure(FEM.PLOT.fig + 2)
% clf
box on
hold on
plot(Rave,P,'r-')
plot(mean(r_model1),F,'bx')

xlabel('Average torus radius (in)')
ylabel('Total cable load (lbf)')

% xlim([69.75 69.95])
% ylim([0 5000])
r_ave = mean(r_model1);


drawnow


F = sum(FEM.OUT.fint_el(7,FEM.el_ind.ind3,:));
F = permute(F,[3 1 2]);


r = zeros(size(r_model0,1),size(FEM.OUT.Uinc,2));
z = zeros(size(r_model0,1),size(FEM.OUT.Uinc,2));
for i = 1:size(FEM.OUT.Uinc,2)
    % Model output
    % Reorganize U
    U2 = reorg_vec(FEM.OUT.Uinc(:,i));

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
    
    r(:,i) = r_model1;
    z(:,i) = z_model1;
end
th = th_model;

end















