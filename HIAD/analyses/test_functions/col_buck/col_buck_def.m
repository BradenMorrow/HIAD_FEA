function col_buck_def(FEM)

f = FEM.OUT.Finc(1,:);
u = -FEM.OUT.Uinc(end - 5,:);

Pcrit = pi^2*2.1e11*1.666667e-8/4/1^2;


figure(4)
clf
box on
hold on
plot(u,f/Pcrit,'bo-')
plot([-1 1],[1 1],'k--')

xlabel('u_x/L')
ylabel('P/P_{crit}')

xlim([-.01 .4])
ylim([0 1.25])

end

