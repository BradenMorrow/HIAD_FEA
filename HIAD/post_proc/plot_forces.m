function plot_forces(F2,U2,nodes,scale)
% plot_forces
% Determines and plots the forces on a HIAD or torus

F_scale = sum(F2(:,1:3).^2,2).^.5;
F_scale(F_scale == 0) = [];
scale_F = .15*max(max(abs(nodes)))/max(F_scale);

if norm(norm(F2(:,1:3))) ~= 0

    force = nodes + F2(:,1:3)*scale_F;
    nF = nodes(sum(F2.^2,2) ~= 0,:);
    fF = force(sum(F2.^2,2) ~= 0,:);

    U2_F = U2(sum(F2.^2,2) ~= 0,1:3)*scale;
    U2_F1 = [U2_F(:,1) U2_F(:,1)];
    U2_F2 = [U2_F(:,2) U2_F(:,2)];
    U2_F3 = [U2_F(:,3) U2_F(:,3)];
    plot3((U2_F1 + [nF(:,1) fF(:,1)])',(U2_F2 + [nF(:,2) fF(:,2)])',(U2_F3 + [nF(:,3) fF(:,3)])','r-','linewidth',1.5)
    plot3(U2_F(:,1) + fF(:,1),U2_F(:,2) + fF(:,2),U2_F(:,3) + fF(:,3),'r.','markersize',15)

elseif norm(norm(F2(:,4:6))) ~= 0
    force = nodes + U2(:,1:3)*scale + normr(F2(:,4:6))*scale_F;
    nF = nodes(sum(F2.^2,2) ~= 0,:) + U2(sum(F2.^2,2)*scale ~= 0,1:3);
    fF = force(sum(F2.^2,2) ~= 0,:);
    plot3([nF(:,1) fF(:,1)]',[nF(:,2) fF(:,2)]',[nF(:,3) fF(:,3)]','r-','linewidth',1.5)
    plot3(fF(:,1),fF(:,2),fF(:,3),'c.','markersize',15)
end