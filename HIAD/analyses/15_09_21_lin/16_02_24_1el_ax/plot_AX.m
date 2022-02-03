function plot_AX(FEM)

try
    R = FEM.OUT.Finc(1,:);
    U = -FEM.OUT.Uinc(end - 5,:);

    figure(10)
    clf
    box on
    hold on
    plot(U,R,'bx-')

    drawnow
catch
end
end

