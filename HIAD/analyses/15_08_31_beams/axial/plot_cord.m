% cd ..
d = load('axial_table_12');


num = 491;
figure(10)
clf
box on
hold on
plot(d(:,2)*100,d(:,1),'b-')
plot(interp1(d(:,1),d(:,2)*100,717),717,'go')

xlim([-.0005 .015]*100)
ylim([-100 2500])

xlabel('Strain (%)')
ylabel('Load (lbf)')
title('Strap force-strain relationship')


% d = load('loop_straps');
% plot(d(:,2),d(:,1),'g-')
% 
% legend('Chevron straps','Loop straps','location','northwest')

<<<<<<< HEAD:analyses/15_08_31_beams/axial/plot_cord.m



=======
>>>>>>> torus_an_merge_13JUN16:HIAD_FE/analyses/15_08_31_beams/axial/plot_cord.m


