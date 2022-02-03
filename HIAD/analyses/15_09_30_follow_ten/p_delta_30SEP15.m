function p_delta_30SEP15(FEM,n)
%%

figure(4);
clf
box on
hold on
xlabel('Displacement (in)')
ylabel('Load (kips)')
% title('2 cords up')

uy = [1e-20; -FEM.OUT.Uinc(end - n,:)'];
ux = [1e-20; FEM.OUT.Uinc(1,:)'];

% f = [1e-20; FEM.OUT.Finc(6 - n,:)'/100]*2;
f = [1e-20; -FEM.OUT.Finc(end - n,:)'/100]*2;
% uy(uy == 0) = [];
% f(f == 0) = [];


% plot(uy,f,'r-.','markersize',3,'linewidth',2.5)
plot(uy,f,'o-','markersize',3,'linewidth',1)
plot(ux,f,'b--','markersize',3,'linewidth',1)
% plot(-FEM.OUT.U(end - n,1)',FEM.PASS.Fint(6 - n,end)'*2/100,'bx-','markersize',10)

% % Out of plane displacements
% uz = [1e-20; -FEM.OUT.Uinc(end - n + 1,:)'];
% uz(uz == 0) = [];
% plot(uz,f,'r:','markersize',3,'linewidth',2)


xlim([0 .6])
ylim([0 210])






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




















