function plot_M(FEM)

% M_wrink = 
rot = [0; FEM.OUT.Uinc(end,:)']*180/pi;
M = [0; FEM.OUT.Finc(end,:)'];

figure(4)
clf
box on
hold on
xlabel('\theta (degrees)')
ylabel('Moment (lbf*in)')
title('2 cords up')
xlim([0 .1])
ylim([0 7000])


plot(rot,M,'co-','markersize',3,'linewidth',1)


end

