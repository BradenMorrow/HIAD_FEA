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







% % % Uinc = [zeros(size(FEM.OUT.U)) FEM.OUT.Uinc];
% % % 
% % % u1 = -Uinc(end - 5,:)';
% % % u2 = -Uinc(end - 4,:)';
% % % phi3 = -Uinc(end,:)';
% % % phi3(phi3 < 0) = pi + (pi + phi3(phi3 < 0));
% % % 
% % % p = zeros(size(FEM.OUT.fint_el,3),3);
% % % p0 = FEM.OUT.fint_el(1:3,1,:);
% % % 
% % % for i = 1:size(p0,3)
% % %     p(i,:) = p0(:,1,i)';
% % % end
% % % P = sum(p.^2,2).^.5;
% % % 
% % % a = size(P,1);
% % % b = size(u1,1);
% % % while a > b
% % %     P(end) = [];
% % %     a = size(P,1);
% % % end
% % % 
% % % while b > a
% % %     u1(end) = [];
% % %     u2(end) = [];
% % %     phi3(end) = [];
% % %     b = size(u1,1);
% % % end
% % % 
% % % 
% % % 
% % % 
% % % L = FEM.GEOM.nodes(end,1);
% % % 
% % % figure(4)
% % % clf
% % % box on
% % % hold on
% % % plot(u1/L,P/1000,'b-')
% % % plot(u2/L,P/1000,'g-.')
% % % plot(phi3/pi,P/1000,'r--')
% % % legend('u_z','u_x','\theta_y','location','northwest')
% % % 
% % % xlabel('-u/L, \theta/\pi')
% % % ylabel('P (kN)')
% % % 
% % % xlim([-.5 1.6])
% % % ylim([0 140])
% % % 
% % % % phi3(end)/pi
% % % % format_plot('cant',[8 4])
end

