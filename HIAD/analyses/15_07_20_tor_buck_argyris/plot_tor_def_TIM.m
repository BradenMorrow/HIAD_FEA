function plot_tor_def_TIM(FEM)

% Current step
% % % U = FEM.OUT.U;
% % % U2 = zeros(length(U)/6,6);
% % % for i = 1:6
% % %     U2(:,i) = U(i:6:length(U));
% % % end

% ind = FEM.SPRING(1).ind;

% % % ui = mean(sum(U2(:,1:3).^2,2).^.5); % Torus displacement
% % % fi = sum(sum(FEM.OUT.fint_el(7:9,ind,end).^2).^.5);% Internal strap forces

R = 100;
EI = 2.1e7*1.666667;

% Loading history
Uinc2 = [zeros(size(FEM.OUT.U,1),1) FEM.OUT.Uinc];
Finc2 = [zeros(size(FEM.OUT.U,1),1) FEM.OUT.Fext_inc];

u_inc_1 = zeros(size(Uinc2,2),1);
u_inc_2 = zeros(size(Uinc2,2),1);
f_inc = zeros(size(Finc2,2),1);
for j = 1:size(Uinc2,2)
    Uinc = Uinc2(:,j);
    Finc = Finc2(:,j);
    U2 = zeros(length(Uinc)/6,6);
    F2 = zeros(length(Finc)/6,6);
    for k = 1:6
        U2(:,k) = Uinc(k:6:length(Uinc));
        F2(:,k) = Finc(k:6:length(Finc));
    end

%     u2 = sum(U2(tor_ind,1:3).^2,2).^.5; % Average displacement vector magnitude
    u2_1 = sum(U2(1,1:3).^2,2).^.5; % Node 1 dispacement
    u2_19 = sum(U2(end,1:3).^2,2).^.5; % Node 19 dispacement
    u_inc_1(j) = mean(u2_1);
    u_inc_2(j) = mean(u2_19);
    
%     f2 = sum(F2(19,1:3).^2,2).^.5; % Node 1 force
    f2 = sum(F2(:,1:3).^2,2).^.5; % Nodal forces
    f_inc(j) = sum(f2)/(2*pi*R/4);
end






% Plotting
figure(4)
clf
box on
hold on
xlim([0 .8])
ylim([0 4])

plot(u_inc_1/R,f_inc*R^3/EI,'bo-','markersize',2) % Vector displacement and internal force;
plot([0 1],[3 3],'k--')

% Format plot
xlabel('Displacement (in)')
ylabel('q_{crit}')


figure(5)
clf
box on
hold on
xlim([0 .4])
ylim([0 4])

plot(u_inc_2/R,f_inc*R^3/EI,'bo-','markersize',2) % Vector displacement and internal force;
plot([0 1],[3 3],'k--')

% Format plot
xlabel('Displacement (in)')
ylabel('Total Cable Load (lbf)')

end

