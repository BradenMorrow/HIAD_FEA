function ax_test_plot(FEM)


u = FEM.OUT.Uinc(7,:)';
f = FEM.OUT.Finc(7,:)';



figure(2)
% clf
box on
hold on
plot(u,f,'r-')



end