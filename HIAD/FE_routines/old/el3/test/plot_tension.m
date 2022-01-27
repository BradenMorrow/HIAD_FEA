function plot_tension(axial,eps)
% Plot the force in the cords

figure(11)
% clf
box on
hold on
plot(axial(:,2),axial(:,1),'b-')

xlim([0 .03])
ylim([0 3500])
xlabel('Strain (%)')
ylabel('Load (lbf)')

% eps_ave = mean(eps,2);
% f_ave = ppval(axial,eps_ave);

% plot(0.8926,1090.8,'rx','markersize',10)
% plot(eps_ave(1)*100,f_ave(1),'ro','markersize',10)
% plot(eps_ave(2)*100,f_ave(2),'go','markersize',10)
% plot(eps_ave(3)*100,f_ave(3),'cv','markersize',10)


f = interp1(axial(:,2),axial(:,1),eps);
plot(eps(1,1),f(1,1),'ro','markersize',10)


% % % plot(eps(1,1),f(1,1),'ro','markersize',10)
% % % plot(eps(2,1),f(2,1),'bo','markersize',10)
% % % % plot(eps(3,1)*100,f(3,1),'ro','markersize',10)
% % % plot(eps(1,2),f(1,2),'rx','markersize',10)
% % % plot(eps(2,2),f(2,2),'bx','markersize',10)
% % % % plot(eps(3,2)*100,f(3,2),'rx','markersize',10)

% xlim([0 .1])
% ylim([-20 60])
end

