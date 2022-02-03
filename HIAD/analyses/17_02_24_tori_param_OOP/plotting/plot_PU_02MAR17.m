function plot_PU_02MAR17(FEM,fig,Ufac,Pfac,L,n)



%% Plotting Load vs. displacement
% Model
% Total load
F = FEM.OUT.fint_el(7,FEM.el_ind.ind3,:);
F = permute(F,[2,3,1]);
F = sum(F)';

% Cable end displacement
Ux = FEM.OUT.Uinc((FEM.el_ind.ind3(n) - 1)*6 + 1,:)';
Uy = FEM.OUT.Uinc((FEM.el_ind.ind3(n) - 1)*6 + 2,:)';
Ucable = (Ux.^2 + Uy.^2).^.5;

% Total load versus cable end displacement
figure(fig)
F1 = F;
Ucable1 = Ucable;
if max(F) > 160
    Ucable1(F < 160) = [];
    F1(F1 < 160) = [];
end


box on
hold on
plot(-(Ucable1 - Ucable1(1))*Ufac,F1*Pfac,L)

drawnow



end















