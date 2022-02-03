function plot_RZ_06FEB17(FEM,fig,y_limit,cgall_I,I,csv_in,ind,I0,I_theta_cable,th_track)
% Plot torus analysis output
%
% FEM - FEM outp
% fig - figure number
% y_limit - ylimit on z-theta plot
% cgall_I - cgall test data
% I - step to compare
% csv_in - test data
% ind - range of test data of interest
% I0 - first step to compare

%% Test
ind1 = ind'; % (1:500)'; % 599)'; % 
load(cgall_I)
d1 = csvread(csv_in,0,1);

[U1,P1,R1,theta1,z1,cg_cyl,cg1,gamma1] = proc_torus(d1,cgall,ind1);

%%
U2 = U1(30:end,:);
U2_1 = U2(1,:);
for i = 1:size(U2,1)
    U2(i,:) = U2(i,:) - U2_1;
end

% % % figure(6)
% % % clf
% % % box on
% % % hold on
% % % plot(U2)
% % % 
% % % figure(7)
% % % clf
% % % box on
% % % hold on
% % % % plot(U2(:,1),sum(P1(30:end,:),2))
% % % plot(sum(P1,2))



%%
% Model output
% Reorganize U
U = FEM.OUT.U;
U2 = reorg_vec(U);
U0 = reorg_vec(FEM.OUT.Uinc(:,I0));

% Initial location of nodes
nodes = FEM.MODEL.nodes;
tor_ind = FEM.el_ind.ind1; % Indices of torus elements

% Model theta
th_model = atan2(nodes(tor_ind,2),nodes(tor_ind,1))*180/pi;
th_model(th_model < 0) = th_model(th_model < 0) + 360;
[th_model,Ith] = sort(th_model);

% r_model0 = hypot(nodes(tor_ind(Ith),1),nodes(tor_ind(Ith),2)); % Initial R location
r_model0 = hypot(nodes(tor_ind(Ith),1) + U0(tor_ind(Ith),1),nodes(tor_ind(Ith),2) + U0(tor_ind(Ith),2)); % Initial R location
z_model0 = nodes(tor_ind(Ith),3) + U0(tor_ind(Ith),3); % Initial Z location
r_model1 = hypot(nodes(tor_ind(Ith),1) + U2(tor_ind(Ith),1),nodes(tor_ind(Ith),2) + U2(tor_ind(Ith),2)); % Current R location
z_model1 = nodes(tor_ind(Ith),3) + U2(tor_ind(Ith),3); % Current Z location

% Total cable forces
% % % Ftest = P(end);
% % % Fmod = sum(FEM.OUT.fint_el(7,FEM.el_ind.ind3,end));




%% Plotting R & Z vs. Theta
figure(fig)
clf

% R direction displacement
subplot(2,1,1)
box on
hold on

% Model R
plot(cg_cyl(:,2,1)*180/pi,cg_cyl(:,1,1),'k-')
plot(th_model,r_model0,'b-')
plot(cg_cyl(:,2,I)*180/pi,cg_cyl(:,1,I),'k--')
plot(th_model,r_model1,'g-')

title('r vs theta')
xlabel('Theta (degrees)')
ylabel('Radius (inches)')
xlim([0 360])

% text(10,(max(r_model1) - mean(r_model1))*1.2 + mean(r_model1),sprintf('F_{model} = %1.0f lbf',Fmod))


% Z direction displacement
subplot(2,1,2)
box on
hold on

% Model Z
plot(cg_cyl(:,2,1)*180/pi,cg_cyl(:,3,1),'k-')
plot(th_model,z_model0,'b-')
plot(cg_cyl(:,2,I)*180/pi,cg_cyl(:,3,I),'k--')
plot(th_model,z_model1,'g-')

title('z vs theta')
xlabel('Theta (degrees)')
ylabel('Z location (inches)')
xlim([0 360])
ylim(y_limit)


legend('Test initial','Model initial','Test final','Model final','location','north','orientation','horizontal')
drawnow






%% Plotting Load vs. displacement
% Model
% Total load
F = FEM.OUT.fint_el(7,FEM.el_ind.ind3,:);
F = permute(F,[2,3,1]);
F = sum(F)';

% Cable end displacement
Ux = FEM.OUT.Uinc((FEM.el_ind.ind3(1) - 1)*6 + 1,:)';
Uy = FEM.OUT.Uinc((FEM.el_ind.ind3(1) - 1)*6 + 2,:)';
Ucable = (Ux.^2 + Uy.^2).^.5;
ind = min([size(Ucable,1) size(F,1)]);

% Average radius and average radius at load points
Rave = zeros(size(FEM.OUT.Uinc,2),1);
Rave_cable = zeros(size(FEM.OUT.Uinc,2),1);

for i = 1:size(Rave)
    U2 = reorg_vec(FEM.OUT.Uinc(:,i));
    
    Rave(i) = mean(hypot(nodes(tor_ind(Ith),1) + U2(tor_ind(Ith),1),nodes(tor_ind(Ith),2) + U2(tor_ind(Ith),2)));
    Rave_cable(i) = mean(hypot(nodes(tor_ind(I_theta_cable),1) + U2(tor_ind(I_theta_cable),1),nodes(tor_ind(I_theta_cable),2) + U2(tor_ind(I_theta_cable),2)));
end

R_delta = Rave(1:ind) - Rave(1);
R_delta_cable = Rave_cable(1:ind) - Rave_cable(1);



% Test
P = sum(P1,2);
P2 = P;
P2(1:30) = [];

% Cable end displacement
Uend = -(mean(U1,2) - mean(U1(30,:)));
Uend1 = Uend;
Uend1(1:30) = [];

% Cange in average radius
th = atan2(nodes(tor_ind(I_theta_cable),2),nodes(tor_ind(I_theta_cable),1));
th(th < 0) = th(th < 0) + 2*pi;

Rave_test = zeros(size(cg_cyl,3),1);
Rave_test_cable = zeros(size(cg_cyl,3),1);
for i = 1:size(cg_cyl,3)
    Rave_test(i) = mean(cg_cyl(:,1,i));
    Rave_test_cable(i) = mean(interp1(cg_cyl(:,2,i),cg_cyl(:,1,i),th));
end

% Rave_test(1:30) = [];
Rtest_delta = Rave_test - Rave_test(1);
Rtest_delta_cable = Rave_test_cable - Rave_test_cable(1);


% Total load versus change in average radius
figure(fig + 1)
clf
subplot(3,1,1)
box on
hold on
plot(Rtest_delta,P,'r-')
plot(R_delta,F(1:ind),'b-')

xlabel('Change in average radius (in)')
ylabel('Total load (lbf)')


% Total load versus change in average radius at load points
% figure(fig + 2)
subplot(3,1,2)
box on
hold on
plot(Rtest_delta_cable,P,'r-')
plot(R_delta_cable,F(1:ind),'b-')

xlabel('Change in average radius at load points (in)')
ylabel('Total load (lbf)')


% Total load versus cable end displacement
% figure(fig + 3)
F1 = F;
Ucable1 = Ucable;
if max(F) > 160
    Ucable1(F < 160) = [];
    F1(F1 < 160) = [];
end


subplot(3,1,3)
box on
hold on
plot(Uend1,P2,'r-')
plot(Ucable1 - Ucable1(1),F1,'b-')

xlabel('Cable end radial displacement (in)')
ylabel('Total load (lbf)')


legend('Test','Model','location','southeast')


drawnow



%% Plotting DOF track
% Test dof
Rdof_test = zeros(size(cg_cyl,3),1);
Zdof_test = zeros(size(cg_cyl,3),1);
for i = 1:size(cg_cyl,3)
    Rdof_test(i) = interp1(cg_cyl(:,2,i),cg_cyl(:,1,i),th_track);
    Zdof_test(i) = interp1(cg_cyl(:,2,i),cg_cyl(:,3,i),th_track);
end

Rdof_delta_test = Rdof_test - Rdof_test(1);
Zdof_delta_test = Zdof_test - Zdof_test(1);

% Model dof
% Change in radius and z at point of interest
Rdof = zeros(size(FEM.OUT.Uinc,2),1);
Zdof = zeros(size(FEM.OUT.Uinc,2),1);


U2 = reorg_vec(FEM.OUT.Uinc(:,I0));
R = hypot(nodes(tor_ind(Ith),1) + U2(tor_ind(Ith),1),nodes(tor_ind(Ith),2) + U2(tor_ind(Ith),2));
th = atan2(nodes(tor_ind(Ith),2),nodes(tor_ind(Ith),1));
Rdof0 = interp1(th,R,th_track);

Zdof0 = interp1(th,nodes(tor_ind(Ith),3) + U2(tor_ind(Ith),3),th_track);

for i = 1:size(Rave)
    U2 = reorg_vec(FEM.OUT.Uinc(:,i));
    
    R = hypot(nodes(tor_ind(Ith),1) + U2(tor_ind(Ith),1),nodes(tor_ind(Ith),2) + U2(tor_ind(Ith),2));
    th = atan2(nodes(tor_ind(Ith),2),nodes(tor_ind(Ith),1));
    
    Rdof(i) = interp1(th,R,th_track);
    
    Zdof(i) = interp1(th,nodes(tor_ind(Ith),3) + U2(tor_ind(Ith),3),th_track);
end

Rdof_delta = Rdof(1:ind) - Rdof0; % - Rdof(1)
Zdof_delta = Zdof(1:ind) - Zdof0; % - Rdof(1)


% Load versus dof of interest
figure(fig + 2)
clf

subplot(2,1,1)
box on
hold on
plot(Rdof_delta_test,P,'r-')
plot(Rdof_delta(I0:end),F(I0:end),'b-')

xlabel('Change in R displacement @ \theta = 80^o (in)')
ylabel('Total load (lbf)')


subplot(2,1,2)
box on
hold on
plot(Zdof_delta_test,P,'r-')
plot(Zdof_delta(I0:end),F(I0:end),'b-')

xlabel('Change in Z displacement @ \theta = 80^o (in)')
ylabel('Total load (lbf)')

legend('Test','Model','location','southwest')



P_delta = (F1(end) - P2(end))/P2(end)*100

% p_delta = [Rave(1:ind) - Rave(1) F(1:ind)];
% save('model1','th_model','z_model0','z_model1','r_model0','r_model1','Fmod','p_delta')

end















