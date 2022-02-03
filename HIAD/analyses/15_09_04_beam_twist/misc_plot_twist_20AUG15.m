function misc_plot_twist_20AUG15(FEM,n)
%%

figure(4);
clf
box on
hold on
xlabel('Displacement (in)')
ylabel('Load (lbf)')
title('2 cords up')

ind = ceil(size(FEM.MODEL.nodes,1)/2);
% ceil(size(FEM.OUT.Uinc,1)/6/2);

uy = [1e-20; -FEM.OUT.Uinc(ind*6 - n,:)'];

f = [1e-20; FEM.OUT.Finc(end - n,:)']*2;
uy(uy == 0) = [];
f(f == 0) = [];


% plot(uy,f,'r-.','markersize',3,'linewidth',2.5)
plot(uy,f,'co-','markersize',3,'linewidth',1)
plot(-FEM.OUT.U(ind*6 - n,1)',FEM.PASS.Fint(end - n,end)'*2,'bx-','markersize',10)

% % Out of plane displacements
% uz = [1e-20; -FEM.OUT.Uinc(end - n + 1,:)'];
% uz(uz == 0) = [];
% plot(uz,f,'r:','markersize',3,'linewidth',2)


xlim([0 7])
ylim([0 810])



a = 1;
