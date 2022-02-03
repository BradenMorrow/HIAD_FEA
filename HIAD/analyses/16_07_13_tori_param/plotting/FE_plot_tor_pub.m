function FE_plot(FEM)
%FE_PLOT
%   Plot the undeformed and deformed shape of a beam FE model

connect = FEM.MODEL.connect;
nodes = FEM.MODEL.nodes;
F = FEM.MODEL.F; % + FEM.MODEL.F_pre;
fig = FEM.PLOT.fig;
scale = FEM.PLOT.scale;
els = FEM.PLOT.els;
view_orient = FEM.PLOT.view;

% Deformations
try
    U = FEM.OUT.U;
catch
    U = F*0;
    FEM.PLOT.def = 0;
end

undef = FEM.PLOT.undef;
def = FEM.PLOT.def;
plot_force = FEM.PLOT.force;
number = FEM.PLOT.number;
triad = FEM.PLOT.triad;


% Reorganize U and F
U2 = reorg_vec(U);
F2 = reorg_vec(F);

% Undeformed
x = [nodes(connect(:,1),1) nodes(connect(:,2),1)];
y = [nodes(connect(:,1),2) nodes(connect(:,2),2)];
z = [nodes(connect(:,1),3) nodes(connect(:,2),3)];

% Deformed
x1 = [nodes(connect(:,1),1) + U2(connect(:,1),1)*scale nodes(connect(:,2),1) + U2(connect(:,2),1)*scale];
y1 = [nodes(connect(:,1),2) + U2(connect(:,1),2)*scale nodes(connect(:,2),2) + U2(connect(:,2),2)*scale];
z1 = [nodes(connect(:,1),3) + U2(connect(:,1),3)*scale nodes(connect(:,2),3) + U2(connect(:,2),3)*scale];

% Plot
figure(fig)
clf
box on
axis off
hold on
axis equal

% Plot viewing orientation
if view_orient == 1
    view(0,0)
elseif view_orient == 2
    view(2)
elseif view_orient == 3
    view(3)
end

ind = (1:size(x,1))';
for i = 1:length(els)
    if els(i) == 1
        eval(sprintf('ind%g = ind(connect(:,3) == %g);',i,i))
    else
        eval(sprintf('ind%g = [];',i))
    end
end

% Undeformed shape
% % % ind1 = [FEM.MODEL.theta_ind(26).ind; FEM.MODEL.theta_ind(27).ind];
% % % ind2 = [];
% % % ind3 = [];


if (undef)
    line(x(ind1,:)',y(ind1,:)',z(ind1,:)','color','k','linestyle','--')
    line(x(ind2,:)',y(ind2,:)',z(ind2,:)','color','k','linestyle','-','linewidth',2.5) % ,'marker','o')
    line(x(ind3,:)',y(ind3,:)',z(ind3,:)','color','b','marker','.','markersize',10,'linestyle','-')
    line(x(ind4,:)',y(ind4,:)',z(ind4,:)','color','b','linestyle','-')
end

% Deformed shape
% % % ind3 = [FEM.MODEL.theta_ind(26).ind; FEM.MODEL.theta_ind(27).ind];
% % % ind1 = [];
if (def)
    if sum(U) ~=0
        line(x1(ind1,:)',y1(ind1,:)',z1(ind1,:)','color','g','linestyle','--','marker','none')
        line(x1(ind2,:)',y1(ind2,:)',z1(ind2,:)','color','g','linestyle','--','marker','none')
        line(x1(ind3,:)',y1(ind3,:)',z1(ind3,:)','color','k','marker','o','linestyle','-','linewidth',1)
        line(x1(ind4,:)',y1(ind4,:)',z1(ind4,:)','color','k','linestyle','-','linewidth',1)
    end
end



% Plot forces
F_scale = sum(F2(:,1:6).^2,2).^.5;
F_scale(F_scale == 0) = [];
scale_F = .15*max(max(abs(nodes)))/max(F_scale);

if (plot_force)
    if norm(norm(F2(:,1:3))) ~= 0
        force = nodes + F2(:,1:3)*scale_F;
        nF = nodes(sum(F2.^2,2) ~= 0,:);
        fF = force(sum(F2.^2,2) ~= 0,:);
        
        U2_F = U2(sum(F2.^2,2) ~= 0,1:3)*scale;
        U2_F1 = [U2_F(:,1) U2_F(:,1)];
        U2_F2 = [U2_F(:,2) U2_F(:,2)];
        U2_F3 = [U2_F(:,3) U2_F(:,3)];
        plot3((U2_F1 + [nF(:,1) fF(:,1)])',(U2_F2 + [nF(:,2) fF(:,2)])',(U2_F3 + [nF(:,3) fF(:,3)])','r-','linewidth',1.5)
        plot3(U2_F(:,1) + fF(:,1),U2_F(:,2) + fF(:,2),U2_F(:,3) + fF(:,3),'r.','markersize',10)
    elseif norm(norm(F2(:,4:6))) ~= 0
        force = nodes + U2(:,1:3)*scale + normr(F2(:,4:6))*scale_F;
        nF = nodes(sum(F2.^2,2) ~= 0,:) + U2(sum(F2.^2,2)*scale ~= 0,1:3);
        fF = force(sum(F2.^2,2) ~= 0,:);
        plot3([nF(:,1) fF(:,1)]',[nF(:,2) fF(:,2)]',[nF(:,3) fF(:,3)]','r-','linewidth',1.5)
        plot3(fF(:,1),fF(:,2),fF(:,3),'c.','markersize',10)
    end
end

% Triad
if (triad)
    L = max(max(nodes))*.25;
    h1 = plot3([0,L],[0,0],[0,0],'r');
    h2 = plot3([0,0],[0,L],[0,0],'g');
    h3 = plot3([0,0],[0,0],[0,L],'b');

    text(L,0,0, '\bf X')
    text(0,L,0, '\bf Y')
    text(0,0,L, '\bf Z')

    set(h1,'Linewidth',2)
    set(h2,'Linewidth',2)
    set(h3,'Linewidth',2)
end

% Plot node numbers
if (number);
    text(x(:,1),y(:,1),z(:,1),num2str(connect(:,1)))
    text(x(:,2),y(:,2),z(:,2),num2str(connect(:,2)))
end

% xlabel('x')
% ylabel('y')
% zlabel('z')

drawnow
end

