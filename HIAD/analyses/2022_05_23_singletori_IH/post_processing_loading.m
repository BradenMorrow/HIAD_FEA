function [] = post_processing_loading(FEM,FEM_Displacement,cable_post,theta,rebound,strap_post)
%% Plot cross-section Of Loading Strap
count=1;
for i=1:size(FEM.MODEL.nodes,1)
    newtheta = atan(FEM.MODEL.nodes(i,2)/FEM.MODEL.nodes(i,1));
    if round(newtheta,3) == 0;
        crossplot(count,:) = FEM.MODEL.nodes(i,:);
        count=count+1;
    end
end
crossplot(crossplot(:,1)<0,:)=[];
fig = figure('Name','Cross-Sectional Plot');
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

% % For New Model Only 
plot(crossplot(1:8:9,1),crossplot(1:8:9,3),'Color','k')
plot(crossplot(1:9:10,1),crossplot(1:9:10,3),'Color','k')
plot(crossplot(2:9:11,1),crossplot(2:9:11,3),'Color','k')
plot(crossplot(2:10:12,1),crossplot(2:10:12,3),'Color','k')
plot(crossplot(2:11:13,1),crossplot(2:11:13,3),'Color','k')
plot(crossplot(2:12:14,1),crossplot(2:12:14,3),'Color','k')
plot(crossplot(3:6:9,1),crossplot(3:6:9,3),'Color','r')
plot(crossplot(9:10,1),crossplot(9:10,3),'Color','r')
plot(crossplot(6:4:10,1),crossplot(6:4:10,3),'Color','r')
plot(crossplot(6:4:10,1),crossplot(6:4:10,3),'Color','r')
plot(crossplot(7:4:11,1),crossplot(7:4:11,3),'Color','r')
plot(crossplot(11:14,1),crossplot(11:14,3),'Color','r')
plot(crossplot(4:10:14,1),crossplot(4:10:14,3),'Color','r')
hold off
set(gca,'visible','off')
%saveas(fig,"Cross-SectionalPlot.fig")

%% Plot cross-section of Loop Strap
count=1;
for i=1:size(FEM.MODEL.nodes,1)
    newtheta = atan(FEM.MODEL.nodes(i,2)/FEM.MODEL.nodes(i,1));
    if round(newtheta,3) == 1.374
        crossplot(count,:) = FEM.MODEL.nodes(i,:);
        count=count+1;
    end
end
crossplot(crossplot(:,1)<0,:)=[];
fig = figure('Name','Cross-Sectional Plot');
hold on
axis equal
scatter(sqrt(crossplot(:,1).^2+crossplot(:,2).^2),crossplot(:,3))
circle(sqrt(crossplot(1,1).^2+crossplot(1,2).^2),crossplot(1,3),6.7)
circle(sqrt(crossplot(2,1).^2+crossplot(2,2).^2),crossplot(2,3),6.7)
plot(sqrt(crossplot(1:2,1).^2+crossplot(1:2,2).^2),crossplot(1:2,3),'Color','k')
plot(sqrt(crossplot(1:2:3,1).^2+crossplot(1:2:3,2).^2),crossplot(1:2:3,3),'Color','k')
plot(sqrt(crossplot(1:4:5,1).^2+crossplot(1:4:5,2).^2),crossplot(1:4:5,3),'Color','k')
plot(sqrt(crossplot(2:2:4,1).^2+crossplot(2:2:4,2).^2),crossplot(2:2:4,3),'Color','k')
plot(sqrt(crossplot(2:4:6,1).^2+crossplot(2:4:6,2).^2),crossplot(2:4:6,3),'Color','k')
plot(sqrt(crossplot(3:4,1).^2+crossplot(3:4,2).^2),crossplot(3:4,3),'Color','r')
plot(sqrt(crossplot(5:6,1).^2+crossplot(5:6,2).^2),crossplot(5:6,3),'Color','r')
set(gca,'visible','off')
hold off
%% post_proc initial FEM
FEM.PLOT = plot_controls;
fig = figure('Name','Initial Shape by Elements');
FEM_plot(FEM)
% saveas(fig,"InitialShapebyElements.fig")

%% post_proc after displacement analysis
if nargin > 1
FEM_Displacement.PLOT = plot_controls_deform;
fig = figure('Name','Deformed Shape by Elements');
FEM_plot(FEM_Displacement)
% saveas(fig,"DeformedShapebyElements.fig")
fig = figure('Name','Post Processed Color-Fill Displacement');
post_proc_driver2(FEM_Displacement)
set(gca,'visible','off')
T3_test_setup
% saveas(fig,"PostProcessedColor-FillDisplacement.fig")

%% Loading Cable Internal Force
for i = 1:size(FEM_Displacement.OUT.fint_el,3)
    oneCableForce(i) = sqrt((FEM_Displacement.OUT.fint_el(1,cable_post(1),i)).^2+(FEM_Displacement.OUT.fint_el(2,cable_post(1),i)).^2+(FEM_Displacement.OUT.fint_el(3,cable_post(1),i).^2)); 
end

step = [1:1:size(FEM_Displacement.OUT.fint_el,3)];
fig = figure('Name','Single Loading Cable Internal Forces');
plot(step,oneCableForce)
axis tight
title('Single Loading Cable Internal Forces')
xlabel('Iteration');
ylabel('Force (lbf)');

% saveas(fig,"SingleLoadingCableInternalForces.fig")
%% Strap Internal Force
for i = 1:size(FEM_Displacement.OUT.fint_el,3)
        oneStrapForce(i) = sqrt((FEM_Displacement.OUT.fint_el(1,strap_post(1),i)).^2+(FEM_Displacement.OUT.fint_el(2,strap_post(1),i)).^2+(FEM_Displacement.OUT.fint_el(3,strap_post(1),i).^2));
end

step = [1:1:size(FEM_Displacement.OUT.fint_el,3)];
fig = figure('Name','Single Strap Internal Forces');
plot(step,oneStrapForce)
title('Single Strap Internal Forces')
xlabel('Iteration');
ylabel('Force (lbf)');
% saveas(fig,"SingleStrapInternalForces.fig")

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

fig = figure('Name','T4 Radial Displacement');
plot(theta1, T4RadDisplacement)
axis tight
title('T4 Radial Displacement')
xlabel('Theta ($\theta$)' ,'Interpreter','latex');
ylabel('Displacement (in)');
% saveas(fig,"T4RadialDisplacement.fig")

fig = figure('Name','T4 Vertical Displacement');
plot(theta1, T4ZDisplacement)
axis tight
title('T4 Vertical Displacement')
xlabel('Theta ($\theta$)' ,'Interpreter','latex');
ylabel('Displacement (in)');
% saveas(fig,"T4VerticalDisplacement.fig")

fig = figure('Name','T5 Radial Displacement');
plot(theta1, T5RadDisplacement)
axis tight
title('T5 Radial Displacement')
xlabel('Theta ($\theta$)' ,'Interpreter','latex');
ylabel('Displacement (in)');
% saveas(fig,"T5RadialDisplacement.fig")

fig = figure('Name','T5 Vertical Displacement');
plot(theta1, T5ZDisplacement)
axis tight
title('T5 Vertical Displacement')
xlabel('Theta ($\theta$)' ,'Interpreter','latex');
ylabel('Displacement (in)');
% saveas(fig,"T5VerticalDisplacement.fig")

%% Increment Displacement of Loading Cable ends
for j = 2:size(FEM_Displacement.OUT.Uinc,2)
    cableRadDisplacment(j) = sqrt(FEM_Displacement.OUT.Uinc(rebound(1),j).^2+FEM_Displacement.OUT.Uinc(rebound(1)+1,j).^2);
end

fig = figure('Name','Single Loading Cable Displacement Increments');
plot(step,cableRadDisplacment)
axis tight
title('Single Loading Cable Displacement Increments')
xlabel('Iteration');
ylabel('Displacement (in)');
% saveas(fig,"SingleLoadingCableDisplacementIncrements.fig")

%% Quiver Plot
for i = 0:size(theta,1)-1
    T4XDisplacement(i+1) = FEM_Displacement.OUT.U(i*6+1);
    T4YDisplacement(i+1) = FEM_Displacement.OUT.U(i*6+2);
end
fig = figure('Name','T4 Radial Displacement Quiver Plot');
quiver(FEM.MODEL.nodes(1:size(theta,1),1),FEM.MODEL.nodes(1:size(theta,1),2),T4XDisplacement',T4YDisplacement',1);
% saveas(fig,"T4RadialDisplacementQuiverPlot.fig")

%% Cord force plot
% plot_cord2(FEM_Displacement,1,1000)
fig = figure('Name','T4 Cord Force v. Loading Cable End Displacement');
plot(cableRadDisplacment',FEM_Displacement.OUT.cord_f(1:size(cableRadDisplacment,2),1));
hold on
axis tight
title('T4 Cord Force v. Loading Cable End Displacement')
xlabel('Loading Cable Radial Displacement (in)');
ylabel('Cord Force (lbf)');
y= FEM_Displacement.OUT.cord_f(1:size(cableRadDisplacment,2),2);
plot(cableRadDisplacment',y);
legend('Top Cord', 'Bottom Cord',Location='best')
hold off
% saveas(fig,"T4CordForce.fig")


fig = figure('Name','T5 Cord Force v. Loading Cable End Displacement');
plot(cableRadDisplacment',FEM_Displacement.OUT.cord_f2(1:size(cableRadDisplacment,2),1));
hold on
axis tight
title('T5 Cord Force v. Loading Cable End Displacement')
xlabel('Loading Cable Radial Displacement (in)');
ylabel('Cord Force (lbf)');
plot(cableRadDisplacment',FEM_Displacement.OUT.cord_f2(1:size(cableRadDisplacment,2),2));
legend('Top Cord', 'Bottom Cord')
hold off
% saveas(fig,"T5CordForce.fig")
end
