% cd ..
d = load('zylon_axial_table');


num = 491;
figure(10)
clf
box on
hold on
plot(d(:,2),d(:,1),'b-')

xlim([-.005 .06])
ylim([-500 7000])

xlabel('Strain')
ylabel('Load (lbf)')
title('Strap force-strain relationship')


% d = load('loop_straps');
% plot(d(:,2),d(:,1),'g-')
% 
% legend('Chevron straps','Loop and radial straps','location','northwest')






