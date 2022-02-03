function [F] = get_F(theta,file_ID)

% Load data
dF = csvread(file_ID,1,0);

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


% % % [TH2,I22] = sort(TH(I2));
% % % F2 = F(I22);
% % % R2 = R(I22);
% % % ux2 = ux(I22);
% % % uy2 = uy(I22);
% % % uz2 = uz(I22);
[TH1,F1,R1,X1,Y1,Z1,ux1,uy1,uz1] = F_sort(I1,TH,F,R,X,Y,Z,ux,uy,uz);

% % % [TH3,I33] = sort(TH(I3));
% % % F3 = F(I33);
% % % R3 = R(I33);
% % % ux3 = ux(I33);
% % % uy3 = uy(I33);
% % % uz3 = uz(I33);
[TH1,F1,R1,X1,Y1,Z1,ux1,uy1,uz1] = F_sort(I1,TH,F,R,X,Y,Z,ux,uy,uz);

% % % [TH4,I44] = sort(TH(I4));
% % % F4 = F(I44);
% % % R4 = R(I44);
% % % ux4 = ux(I44);
% % % uy4 = uy(I44);
% % % uz4 = uz(I44);
[TH1,F1,R1,X1,Y1,Z1,ux1,uy1,uz1] = F_sort(I1,TH,F,R,X,Y,Z,ux,uy,uz);

% % % [TH5,I55] = sort(TH(I5));
% % % F5 = F(I55);
% % % R5 = R(I55);
% % % ux5 = ux(I55);
% % % uy5 = uy(I55);
% % % uz5 = uz(I55);
[TH1,F1,R1,X1,Y1,Z1,ux1,uy1,uz1] = F_sort(I1,TH,F,R,X,Y,Z,ux,uy,uz);

% % % [TH6,I66] = sort(TH(I6));
% % % F6 = F(I66);
% % % R6 = R(I66);
% % % ux6 = ux(I66);
% % % uy6 = uy(I66);
% % % uz6 = uz(I66);
[TH1,F1,R1,X1,Y1,Z1,ux1,uy1,uz1] = F_sort(I1,TH,F,R,X,Y,Z,ux,uy,uz);

% % % [TH7,I77] = sort(TH(I7));
% % % F7 = F(I77);
% % % R7 = R(I77);
% % % ux7 = ux(I77);
% % % uy7 = uy(I77);
% % % uz7 = uz(I77);
[TH1,F1,R1,X1,Y1,Z1,ux1,uy1,uz1] = F_sort(I1,TH,F,R,X,Y,Z,ux,uy,uz);

% % % [TH8,I88] = sort(TH(I8));
% % % F8 = F(I88);
% % % R8 = R(I88);
% % % ux8 = ux(I88);
% % % uy8 = uy(I88);
% % % uz8 = uz(I88);
[TH1,F1,R1,X1,Y1,Z1,ux1,uy1,uz1] = F_sort(I1,TH,F,R,X,Y,Z,ux,uy,uz);

% Theta tributary width
th1 = [theta(end) - 2*pi; theta];
th2 = [theta; theta(1) + 2*pi];
trib_theta = (th1 + th2)/2;
% trib_theta(1) = trib_theta(1) + 2*pi;


% % % figure(1)
% % % clf
% % % box on
% % % hold on
% % % plot(theta,theta*0,'bx')
% % % plot(trib_theta,trib_theta*0,'ro')
% % % plot(TH1,ones(size(TH1))*.001,'gs')
% % % 
% % % ylim([-1 1]*.1)

% Collect loads
f1 = zeros(size(theta,1),3);
for i = 1:size(theta,1)
    I_temp = (TH1 >= trib_theta(i) | TH1 < trib_theta(i + 1) - 2*pi) & (TH1 < trib_theta(i + 1) | TH1 >= trib_theta(i) + 2*pi);
    ux_temp = ux1(I_temp);
    uy_temp = uy1(I_temp);
    uz_temp = uz1(I_temp);
    F_temp = F1(I_temp);
    
    f1(i,:) = sum([F_temp.*ux_temp F_temp.*uy_temp F_temp.*uz_temp]);
end


figure(1)
clf
box on
hold on
quiver3(C(2,1)*cos(theta),C(2,1)*sin(theta),C(2,2)*ones(size(theta)),f1(:,1),f1(:,2),f1(:,3))

dZ = 30;
plot3([0 10],[0 0],[0 0] + dZ,'r-','linewidth',4)
plot3([0 0],[0 10],[0 0] + dZ,'g-','linewidth',4)
plot3([0 0],[0 0],[0 10] + dZ,'b-','linewidth',4)
text(12,0,dZ,'X')
text(0,12,dZ,'Y')
text(0,0,12 + dZ,'Z')

end

