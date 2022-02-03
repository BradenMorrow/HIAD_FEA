function plot_RZ_02MAR17(FEM,fig,I0,L,Ufac)
% Plot torus analysis output
%
% FEM - FEM outp
% fig - figure number
% I0 - step to compare



%%
% Model output
% Reorganize U
U0 = reorg_vec(FEM.OUT.Uinc(:,I0));

% Initial location of nodes
nodes = FEM.MODEL.nodes;
tor_ind = FEM.el_ind.ind1; % Indices of torus elements

% Model theta
th_model = atan2(nodes(tor_ind,2),nodes(tor_ind,1))*180/pi;
th_model(th_model < 0) = th_model(th_model < 0) + 360;
[th_model,Ith] = sort(th_model);

% r_model0 = hypot(nodes(tor_ind(Ith),1),nodes(tor_ind(Ith),2)); % Initial R location
r_model = hypot(nodes(tor_ind(Ith),1) + U0(tor_ind(Ith),1),nodes(tor_ind(Ith),2) + U0(tor_ind(Ith),2)); % Initial R location
z_model = nodes(tor_ind(Ith),3) + U0(tor_ind(Ith),3); % Initial Z location




%% Plotting R & Z vs. Theta
figure(fig)

% R direction displacement
subplot(2,1,1)
box on
hold on

% Model R
plot(th_model,r_model*Ufac,L,'linewidth',1.5)

xlim([0 360])



% Z direction displacement
subplot(2,1,2)
box on
hold on

% Model Z
plot(th_model,z_model*Ufac,L,'linewidth',1.5)
xlim([0 360])


drawnow





end















