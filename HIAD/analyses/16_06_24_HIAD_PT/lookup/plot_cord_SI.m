% cd ..
d = load('zylon_axial_table');


figure(10)
clf
box on
hold on
plot(d(:,2)*100,d(:,1)*4.448222/1000,'b-')

xlim([0 .06]*100)
ylim([-2 35])

xlabel('Cord strain (%)')
ylabel('Cord force (kN)')
% title('Strap force-strain relationship')


F01 = 20*pi*15.919^2*(1 - 2*cotd(71)^2)/2*4.448222/1000
F02 = 20*pi*6.3675^2*(1 - 2*cotd(71)^2)/2*4.448222/1000

% d = load('loop_straps');
% plot(d(:,2),d(:,1),'g-')
% 
% legend('Chevron straps','Loop and radial straps','location','northwest')






