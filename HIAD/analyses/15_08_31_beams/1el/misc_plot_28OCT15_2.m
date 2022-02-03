function misc_plot_28OCT15_2(FEM,n)
%%

figure(4);
clf
box on
hold on
xlabel('Rotation (deg)')
ylabel('Moment (lbf.in)')
title('2 cords up')

uy = [1e-20; FEM.OUT.Uinc(end - n,:)'];

f = [1e-20; FEM.OUT.Finc(end - n,:)'];
uy(f == 0) = [];
f(f == 0) = [];


% plot(uy,f,'r-.','markersize',3,'linewidth',2.5)
plot(uy*180/pi,f,'co-','markersize',3,'linewidth',1)
plot(FEM.OUT.U(end - n,1)'*180/pi,FEM.PASS.Fint(end - n,end)','bx-','markersize',10)

% % Out of plane displacements
% uz = [1e-20; -FEM.OUT.Uinc(end - n + 1,:)'];
% uz(uz == 0) = [];
% plot(uz,f,'r:','markersize',3,'linewidth',2)


% xlim([0 1e-3])
% ylim([0 10000])






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




















