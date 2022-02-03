% Process forces and moments from CFD analyses
% March 29, 2017

% Load force data
dF = csvread('Nodal_Forces.csv',1,0);
dM = csvread('Nodal_Moments.csv',1,0);

% HIAD configuration
[C,r] = WT_config;

% Reorganize data
F = dF(:,5);
X = dF(:,2);
Y = dF(:,4);
Z = dF(:,3);
ux = dF(:,6);
uy = dF(:,8);
uz = dF(:,7);
R = hypot(X,Y);
TH = atan2(Y,X);
TH(TH < 0) = TH(TH < 0) + 2*pi;

% Eliminate points not on tori
Rmin = 32;
X(R < Rmin) = [];
Y(R < Rmin) = [];
Z(R < Rmin) = [];
F(R < Rmin) = [];
TH(R < Rmin) = [];
ux(R < Rmin) = [];
uy(R < Rmin) = [];
uz(R < Rmin) = [];
R(R < Rmin) = [];

% Find indices for each tori
I1 = R < C(2,1) + r(1)*cosd(30) & R > C(2,1) - r(1)*cosd(30);
I2 = R < C(3,1) + r(2)*cosd(30) & R > C(3,1) - r(2)*cosd(30);
I3 = R < C(4,1) + r(3)*cosd(30) & R > C(4,1) - r(3)*cosd(30);
I4 = R < C(5,1) + r(4)*cosd(30) & R > C(5,1) - r(4)*cosd(30);
I5 = R < C(6,1) + r(5)*cosd(30) & R > C(6,1) - r(5)*cosd(30);
I6 = R < C(7,1) + r(6)*cosd(30) & R > C(7,1) - r(6)*cosd(30);
I7 = R < C(8,1) + r(7)*cosd(30) & R > C(8,1) - r(7)*cosd(30);
I8 = R > C(9,1) - r(8)*cosd(30);

% % % % Sort forces
% % % [TH1,I11] = sort(TH(I1));
% % % F1 = F(I1);
% % % F1 = F1(I11);
% % % R1 = R(I1);
% % % R1 = R1(I11);
% % % X1 = X(I1);
% % % X1 = X1(I11);
% % % Y1 = Y(I1);
% % % Y1 = Y1(I11);
% % % Z1 = Z(I1);
% % % Z1 = Z1(I11);
% % % ux1 = ux(I1);
% % % ux1 = ux1(I11);
% % % uy1 = uy(I1);
% % % uy1 = uy1(I11);
% % % uz1 = uz(I1);
% % % uz1 = uz1(I11);
[TH1,F1,R1,X1,Y1,Z1,ux1,uy1,uz1] = F_sort(I1,TH,F,R,X,Y,Z,ux,uy,uz);

[TH2,I22] = sort(TH(I2));
F2 = F(I22);
R2 = R(I22);
X2 = X(I22);
Y2 = Y(I22);
Z2 = Z(I22);
ux2 = ux(I22);
uy2 = uy(I22);
uz2 = uz(I22);

[TH3,I33] = sort(TH(I3));
F3 = F(I33);
R3 = R(I33);
X3 = X(I33);
Y3 = Y(I33);
Z3 = Z(I33);
ux3 = ux(I33);
uy3 = uy(I33);
uz3 = uz(I33);

[TH4,I44] = sort(TH(I4));
F4 = F(I44);
R4 = R(I44);
X4 = X(I44);
Y4 = Y(I44);
Z4 = Z(I44);
ux4 = ux(I44);
uy4 = uy(I44);
uz4 = uz(I44);

[TH5,I55] = sort(TH(I5));
F5 = F(I55);
R5 = R(I55);
X4 = X(I44);
Y4 = Y(I44);
Z4 = Z(I44);
ux5 = ux(I55);
uy5 = uy(I55);
uz5 = uz(I55);

[TH6,I66] = sort(TH(I6));
F6 = F(I66);
R6 = R(I66);
X5 = X(I55);
Y5 = Y(I55);
Z5 = Z(I55);
ux6 = ux(I66);
uy6 = uy(I66);
uz6 = uz(I66);




%%
WT_config;

figure(100)
% clf
axis equal
box on
hold on
% view(3)

plot3(X1,Z1,Y1,'r.')
% plot3(X,Z,Y,'r.')
% plot(Y(X > 0 & X < 1),Z(X > 0 & X < 1),'r.','markersize',15)

% I = logical(I1 + I2 + I3 + I4 + I5 + I6 + I7 + I8);


% plot(Y(I),Z(I),'b.','markersize',15)
% plot3(X(~I),Y(~I),Z(~I),'r.','markersize',15)
dZ = 30;
plot3([0 10],[0 0],[0 0] + dZ,'r-','linewidth',4)
plot3([0 0],[0 10],[0 0] + dZ,'g-','linewidth',4)
plot3([0 0],[0 0],[0 10] + dZ,'b-','linewidth',4)
text(12,0,dZ,'X')
text(0,12,dZ,'Y')
text(0,0,12 + dZ,'Z')




% F = 1;
figure(101)
clf
box on
axis equal
hold on
% quiver3(X,Y,Z,F.*ux,F.*uy,F.*uz,5)

I = Z > 0; % Y > 0 & Y < 1;
quiver3(X(I),Y(I),Z(I),ux(I),uy(I),uz(I),1)
xlabel('X')
ylabel('Y')
zlabel('Z')

dZ = 30;
plot3([0 10],[0 0],[0 0] + dZ,'r-','linewidth',4)
plot3([0 0],[0 10],[0 0] + dZ,'g-','linewidth',4)
plot3([0 0],[0 0],[0 10] + dZ,'b-','linewidth',4)
text(12,0,dZ,'X')
text(0,12,dZ,'Y')
text(0,0,12 + dZ,'Z')




figure(200)
clf
box on
hold on

subplot(6,1,1)
plot(TH1*180/pi,F1)
xlim([0 360])
ylim([0 6])
xlabel('Theta (deg)')
ylabel(sprintf('Force\nmagnitude\n(lbf)'))

subplot(6,1,2)
plot(TH2*180/pi,F2)
xlim([0 360])
ylim([0 6])
xlabel('Theta (deg)')
ylabel(sprintf('Force\nmagnitude\n(lbf)'))

subplot(6,1,3)
plot(TH3*180/pi,F3)
xlim([0 360])
ylim([0 6])
xlabel('Theta (deg)')
ylabel(sprintf('Force\nmagnitude\n(lbf)'))

subplot(6,1,4)
plot(TH4*180/pi,F4)
xlim([0 360])
ylim([0 6])
xlabel('Theta (deg)')
ylabel(sprintf('Force\nmagnitude\n(lbf)'))

subplot(6,1,5)
plot(TH5*180/pi,F5)
xlim([0 360])
ylim([0 6])
xlabel('Theta (deg)')
ylabel(sprintf('Force\nmagnitude\n(lbf)'))

subplot(6,1,6)
plot(TH6*180/pi,F6)
xlim([0 360])
ylim([0 6])
xlabel('Theta (deg)')
ylabel(sprintf('Force\nmagnitude\n(lbf)'))

% xlabel('X')
% ylabel('Y')
% zlabel('Z')





