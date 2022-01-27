function ax_test_plot(FEM)

try
    u = FEM.OUT.Uinc(7,:)';
    f = FEM.OUT.Finc(7,:)';



    figure(2)
    clf
    box on
    hold on
    plot([0 u]',[0 f]','rx-')
    
    a = 1;
    
catch
end


end