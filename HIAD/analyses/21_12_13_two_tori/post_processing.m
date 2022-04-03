function [] = post_processing(FEM,FEM_Force,FEM_Displacement,cable_post,theta,rebound)
%% Plot cross-section
count=1;
for i=1:size(FEM.MODEL.nodes,1)
    newtheta = atan(FEM.MODEL.nodes(i,2)/FEM.MODEL.nodes(i,1));
    if round(newtheta,3) == 0;
        crossplot(count,:) = FEM.MODEL.nodes(i,:);
        count=count+1;
    end
end
crossplot(crossplot(:,1)<0,:)=[];
figure('Name','Cross-Sectional Plot')
hold on
axis equal
scatter(crossplot(:,1),crossplot(:,3))
circle(crossplot(1,1),crossplot(1,3),6.7)
circle(crossplot(2,1),crossplot(2,3),6.7)
plot(crossplot(1:2,1),crossplot(1:2,3),'Color','k')
plot(crossplot(1:2:3,1),crossplot(1:2:3,3),'Color','k')
plot(crossplot(2:2:4,1),crossplot(2:2:4,3),'Color','k')
plot(crossplot(1:5:6,1),crossplot(1:5:6,3),'Color','k')
plot(crossplot(2:5:7,1),crossplot(2:5:7,3),'Color','k')
plot(crossplot(3:2:5,1),crossplot(3:2:5,3),'Color','r')
plot(crossplot(4:5,1),crossplot(4:5,3),'Color','r')
plot(crossplot(6:7,1),crossplot(6:7,3),'Color','r')
plot(crossplot(5:3:8,1),crossplot(5:3:8,3),'Color','g')
hold off

%% post_proc initial FEM
FEM.PLOT = plot_controls;
FEM_plot(FEM)

%% post_proc after displacement analysis
FEM_Displacement.PLOT = plot_controls_deform;
FEM_plot(FEM_Displacement)
post_proc_driver2(FEM_Displacement)
T3_test_setup

%% Loading Cable Force
for i = 1:size(FEM_Displacement.OUT.fint_el,3)
    oneCableForce(i) = sqrt((FEM_Displacement.OUT.fint_el(1,cable_post(1),i)).^2+(FEM_Displacement.OUT.fint_el(2,cable_post(1),i)).^2+(FEM_Displacement.OUT.fint_el(3,cable_post(1),i).^2)); 
end

step = [1:1:size(FEM_Displacement.OUT.fint_el,3)];
figure('Name','Single Loading Cable Internal Forces');
plot(step,oneCableForce)
title('Single Loading Cable Internal Forces')
xlabel('Iteration');
ylabel('Force (lbf)');

%% Average displacement vs. theta
for i = 0:size(theta,1)-1
    T4RadDisplacement(i+1) = sqrt(FEM_Displacement.OUT.U(i*6+1).^2+FEM_Displacement.OUT.U(i*6+2).^2);
    T4ZDisplacement(i+1) = FEM_Displacement.OUT.U(i*6+3);
end
T4RadDisplacement(end) = [];
T4ZDisplacement(end) = [];

for i = 0:size(theta,1)-1
    T5RadDisplacement(i+1) = sqrt(FEM_Displacement.OUT.U(size(theta,1)*6+i*6+1).^2+FEM_Displacement.OUT.U(size(theta,1)*6+i*6+2).^2);
    T5ZDisplacement(i+1) = FEM_Displacement.OUT.U(size(theta,1)*6+i*6+3);
end
T5RadDisplacement(end) = [];
T5ZDisplacement(end) = [];
theta1 = theta;
theta1(end) = [];
theta1 = theta1';

figure('Name','T4 Radial Displacement');
plot(theta1, T4RadDisplacement)
title('T4 Radial Displacement')
xlabel('Theta ($\theta$)' ,'Interpreter','latex');
ylabel('Displacement (in)');
figure('Name','T4 Vertical Displacement');
plot(theta1, T4ZDisplacement)
title('T4 Vertical Displacement')
xlabel('Theta ($\theta$)' ,'Interpreter','latex');
ylabel('Displacement (in)');

figure('Name','T5 Radial Displacement');
plot(theta1, T5RadDisplacement)
title('T5 Radial Displacement')
xlabel('Theta ($\theta$)' ,'Interpreter','latex');
ylabel('Displacement (in)');
figure('Name','T5 Vertical Displacement');
plot(theta1, T5ZDisplacement)
title('T5 Vertical Displacement')
xlabel('Theta ($\theta$)' ,'Interpreter','latex');
ylabel('Displacement (in)');

%% Increment Displacement of Loading Cable ends
for j = 2:size(FEM_Displacement.OUT.Uinc,2)
    cableRadDisplacment(j) = sqrt(FEM_Displacement.OUT.Uinc(rebound(1),j).^2+FEM_Displacement.OUT.Uinc(rebound(1)+1,j).^2);
end

figure('Name','Single Loading Cable Displacement Increments');
plot(step,cableRadDisplacment)
title('Single Loading Cable Displacement Increments')
xlabel('Iteration');
ylabel('Displacement (in)');
%% Quiver Plot
for i = 0:size(theta,1)-1
    T4XDisplacement(i+1) = FEM_Displacement.OUT.U(i*6+1);
    T4YDisplacement(i+1) = FEM_Displacement.OUT.U(i*6+2);
end
figure('Name','T4 Radial Displacement Quiver Plot');
quiver(FEM.MODEL.nodes(1:size(theta,1),1),FEM.MODEL.nodes(1:size(theta,1),2),T4XDisplacement',T4YDisplacement',1);

%% Cord force plot
    plot_cord2(FEM_Displacement,1,1000)