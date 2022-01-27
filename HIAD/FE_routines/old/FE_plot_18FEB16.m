function FE_plot(FEM)
%FE_PLOT
%   Plot the undeformed and deformed shape of a beam FE model

connect = FEM.MODEL.connect;
nodes = FEM.MODEL.nodes;
F = FEM.MODEL.F;
fig = FEM.PLOT.fig;
scale = FEM.PLOT.scale;
DOF = FEM.ANALYSIS.DOF;

% Deformations
try
    U = FEM.OUT.U;
catch
    U = F*0;
end

undef = FEM.PLOT.undef;
def = FEM.PLOT.def;
plot_force = FEM.PLOT.force;
number = FEM.PLOT.number;
triad = FEM.PLOT.triad;


U2 = zeros(length(U)/DOF,DOF);
F2 = zeros(length(F)/DOF,DOF);
for j = 1:DOF
    U2(:,j) = U(j:DOF:length(U));
    F2(:,j) = F(j:DOF:length(F));
end

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

% Undeformed shape
if undef == 1
    for i = 1:size(x,1)
        if connect(i,3) == 3
            plot3(x(i,:),y(i,:),z(i,:),'b-')
        elseif connect(i,3) == 2
            plot3(x(i,:),y(i,:),z(i,:),'g-')
        elseif connect(i,3) == 1
            plot3(x(i,:),y(i,:),z(i,:),'k--','linewidth',1.5)
        end
    end
end


% Deformed shape
if def == 1
    for i = 1:size(x,1)
        if connect(i,3) == 3
            plot3(x1(i,:),y1(i,:),z1(i,:),'ko--','markersize',2)
        elseif connect(i,3) == 2
            plot3(x1(i,:),y1(i,:),z1(i,:),'go--','markersize',2)
        elseif connect(i,3) == 1
            plot3(x1(i,:),y1(i,:),z1(i,:),'g-.','linewidth',1)
        end
    end
end
xlabel('x')
ylabel('y')
zlabel('z')


% Plot forces
F_scale = sum(F2(:,1:6).^2,2).^.5;
F_scale(F_scale == 0) = [];
scale_F = .15*max(max(abs(nodes)))/max(F_scale);

if plot_force == 1
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
end

% Plot viewing orientation
% view(60,30)
% view(0,0)
% view(0,90)
% view(2)
view(3)

% Triad
if triad == 1
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
if number == 1;
    for i = 1:size(x,1)
        if connect(i,3) == 3
            text(x(i,1),y(i,1),z(i,1),num2str(connect(i,1)))
            text(x(i,2),y(i,2),z(i,2),num2str(connect(i,2)))
        elseif connect(i,3) == 2
            text(x(i,1),y(i,1),z(i,1),num2str(connect(i,1)))
            text(x(i,2),y(i,2),z(i,2),num2str(connect(i,2)))
        elseif connect(i,3) == 1
            text(x(i,1),y(i,1),z(i,1),num2str(connect(i,1)))
            text(x(i,2),y(i,2),z(i,2),num2str(connect(i,2)))
        end
    end
end

end

