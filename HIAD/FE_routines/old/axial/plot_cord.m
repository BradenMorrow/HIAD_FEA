% cd ..
d = load('d_unload.txt');


num = 491;
figure(10)
% clf
box on
hold on
plot(d(:,2),d(:,1),'r-')

xlim([-.005 .06])
% ylim([-100 5000])

xlabel('Strain')
ylabel('Load (lbf)')
title('Strap force-strain relationship')







