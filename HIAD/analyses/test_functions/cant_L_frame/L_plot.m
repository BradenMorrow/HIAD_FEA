function L_plot(FEM)

try
    figure(2)
    clf
    box on
    plot([0; FEM.OUT.Uinc(end - 3,:)'],[0; FEM.OUT.Finc(end - 5,:)'],'rx-','markersize',10)
    xlabel('z disp')
    ylabel('x force')
catch
end