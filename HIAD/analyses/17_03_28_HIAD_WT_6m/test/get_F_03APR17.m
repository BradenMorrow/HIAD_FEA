function [F] = get_F_03APR17(theta,file_ID)

% Load data
dF = csvread(file_ID,1,0);

% HIAD configuration
[C,r] = WT_config;

% Reorganize data
F0 = dF(:,5);
X = dF(:,2);
Y = dF(:,4);
Z = dF(:,3);
ux = dF(:,6);
uy = dF(:,8);
uz = dF(:,7);
R = hypot(X,Y);
TH = atan2(Y,X);
TH(TH < 0) = TH(TH < 0) + 2*pi;

% Find indices for each tori
I1 = R < C(2,1) + r(1)*cosd(30) & R > C(2,1) - r(1)*cosd(30);
I2 = R < C(3,1) + r(2)*cosd(30) & R > C(3,1) - r(2)*cosd(30);
I3 = R < C(4,1) + r(3)*cosd(30) & R > C(4,1) - r(3)*cosd(30);
I4 = R < C(5,1) + r(4)*cosd(30) & R > C(5,1) - r(4)*cosd(30);
I5 = R < C(6,1) + r(5)*cosd(30) & R > C(6,1) - r(5)*cosd(30);
I6 = R < C(7,1) + r(6)*cosd(30) & R > C(7,1) - r(6)*cosd(30);
I7 = R < C(8,1) + r(7)*cosd(30) & R > C(8,1) - r(7)*cosd(30);
I8 = R > C(9,1) - r(8)*cosd(30);

% Sort forces
[f1] = F_sort(I1,TH,F0,R,X,Y,Z,ux,uy,uz,theta);
[f2] = F_sort(I2,TH,F0,R,X,Y,Z,ux,uy,uz,theta);
[f3] = F_sort(I3,TH,F0,R,X,Y,Z,ux,uy,uz,theta);
[f4] = F_sort(I4,TH,F0,R,X,Y,Z,ux,uy,uz,theta);
[f5] = F_sort(I5,TH,F0,R,X,Y,Z,ux,uy,uz,theta);
[f6] = F_sort(I6,TH,F0,R,X,Y,Z,ux,uy,uz,theta);
[f7] = F_sort(I7,TH,F0,R,X,Y,Z,ux,uy,uz,theta);
[f8] = F_sort(I8,TH,F0,R,X,Y,Z,ux,uy,uz,theta);

F = [f1
    f2
    f3
    f4
    f5
    f6
    f7
    f8];



scale = 1;
figure(1)
clf
box on
hold on
axis equal
axis off
quiver3(C(2,1)*cos(theta),C(2,1)*sin(theta),C(2,2)*ones(size(theta)),f1(:,1),f1(:,2),f1(:,3),scale)
quiver3(C(3,1)*cos(theta),C(3,1)*sin(theta),C(3,2)*ones(size(theta)),f2(:,1),f2(:,2),f2(:,3),scale)
quiver3(C(4,1)*cos(theta),C(4,1)*sin(theta),C(4,2)*ones(size(theta)),f3(:,1),f3(:,2),f3(:,3),scale)
quiver3(C(5,1)*cos(theta),C(5,1)*sin(theta),C(5,2)*ones(size(theta)),f4(:,1),f4(:,2),f4(:,3),scale)
quiver3(C(6,1)*cos(theta),C(6,1)*sin(theta),C(6,2)*ones(size(theta)),f5(:,1),f5(:,2),f5(:,3),scale)
quiver3(C(7,1)*cos(theta),C(7,1)*sin(theta),C(7,2)*ones(size(theta)),f6(:,1),f6(:,2),f6(:,3),scale)
quiver3(C(8,1)*cos(theta),C(8,1)*sin(theta),C(8,2)*ones(size(theta)),f7(:,1),f7(:,2),f7(:,3),scale)
quiver3(C(9,1)*cos(theta),C(9,1)*sin(theta),C(9,2)*ones(size(theta)),f8(:,1),f8(:,2),f8(:,3),scale)

dZ = 0;
plot3([0 15],[0 0],[0 0] + dZ,'r-','linewidth',4)
plot3([0 0],[0 15],[0 0] + dZ,'g-','linewidth',4)
plot3([0 0],[0 0],[0 15] + dZ,'b-','linewidth',4)
text(17,0,dZ,'X')
text(0,17,dZ,'Y')
text(0,0,17 + dZ,'Z')

ax = gca;               % get the current axis
ax.Clipping = 'off';    % turn clipping off

end

