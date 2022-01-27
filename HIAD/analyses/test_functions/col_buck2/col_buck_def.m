function Pout = col_buck_def(FEM)

f = FEM.OUT.Finc(1,:)';
u = -FEM.OUT.Uinc(end - 5,:)';

Pcrit = 1;




if size(u,1) > 20
    p1 = polyfit(u(1:20),f(1:20),1);
    p2 = polyfit(u(end - 1:end),f(end - 1:end),1);
    
    x = (p2(2) - p1(2))/(p1(1) - p2(1));
    Pout = polyval(p1,x);
    
    x1 = (0:.001:.05)';
    x2 = (-.5:.001:1)';
    y1 = polyval(p1,x1);
    y2 = polyval(p2,x2);
    
else
    x1 = 0;
    x2 = 0;
    y1 = 0;
    y2 = 0;
end




figure(4)
clf
box on
hold on
plot(u,f/Pcrit,'bo-')
plot([0 1]*1,[1 1],'k--')

plot(x1,y1,'k')
plot(x2,y2,'k')



xlabel('u_x/L')
ylabel('P/P_{crit}')

xlim([-.01 .4])
ylim([0 1.25])





end

