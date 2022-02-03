function plot_TOR(FEM)

R = FEM.OUT.Finc(1,:);
R = -R*2*(size(FEM.OUT.Finc,1)/6 - 4)*4;

U = -FEM.OUT.Uinc(1,:);

figure(10)
% clf
box on
hold on
plot(U,R,'go-')

end

