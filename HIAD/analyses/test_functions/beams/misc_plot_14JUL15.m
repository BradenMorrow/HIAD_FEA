function misc_plot_14JUL15(FEM,n)
%%

% n = 3;

figure(4);
clf
box on
hold on
xlabel('Displacement (in)')
ylabel('Load (lbf)')
title('2 cords up')

uy = [1e-20; -FEM.OUT.Uinc(end - n,:)'];

f = [1e-20; FEM.OUT.Finc(6 - n,:)']*2;
uy(uy == 0) = [];
f(f == 0) = [];


% plot(uy,f,'r-.','markersize',3,'linewidth',2.5)
plot(uy,f,'co-','markersize',3,'linewidth',1)
plot(-FEM.OUT.U(end - n,1)',FEM.PASS.Fint(6 - n,end)'*2,'bx-','markersize',10)

% % Out of plane displacements
% uz = [1e-20; -FEM.OUT.Uinc(end - n + 1,:)'];
% uz(uz == 0) = [];
% plot(uz,f,'r:','markersize',3,'linewidth',2)


xlim([0 6])
ylim([0 700])






% % % ind1 = 13;
% % % u = uy(ind1:end);
% % % f = f(ind1:end);
% % % plot(u,f,'rx','markersize',5,'linewidth',2)
% % % 
% % % P = polyfit(u,f,1);
% % % 
% % % x = [0.5 5.5];
% % % plot(x,polyval(P,x))
% % % 
% % % a = 1;




















