% Process deflected HIAD shape
% April 4, 2017
%%
% post_proc_driver2(FEM_out)

%%

d = dlmread('point_cloud.csv');
d = d/25.4;

ind1 = (1:1:size(d,1))';

X = -d(ind1,2);
Y = d(ind1,1);
Z = -d(ind1,3);

d = [X Y Z];

A = d(Y  > -1 & Y < 1 & X > 103 & X < 107,:);
B = d(X  > -1 & X < 1 & Y > 103 & Y < 107,:);
C = d(Y  > -1 & Y < 1 & X < -103 & X > -107,:);
D = d(X  > -1 & X < 1 & Y < -103 & Y > -107,:);

AA = [mean(A(:,1)),mean(A(:,2)),mean(A(:,3))];
BB = [mean(B(:,1)),mean(B(:,2)),mean(B(:,3))];
CC = [mean(C(:,1)),mean(C(:,2)),mean(C(:,3))];
DD = [mean(D(:,1)),mean(D(:,2)),mean(D(:,3))];

LX = [0 150*cosd(30)]';
LY = [0 0]';
LZ = [0 150*sind(30)]' - 10;


x0 = AA(1);
y0 = AA(3);
x1 = LX(1);
y1 = LZ(1);
x2 = LX(2);
y2 = LZ(2);
distA = abs((y2 - y1)*x0 - (x2 - x1)*y0 + x2*y1 - y2*x1)/sqrt((y2 - y1)^2 + (x2 - x1)^2);
distA = distA*cosd(30);

x0 = BB(2);
y0 = BB(3);
x1 = LX(1);
y1 = LZ(1);
x2 = LX(2);
y2 = LZ(2);
distB = abs((y2 - y1)*x0 - (x2 - x1)*y0 + x2*y1 - y2*x1)/sqrt((y2 - y1)^2 + (x2 - x1)^2);
distB = distB*cosd(30);

x0 = -CC(1);
y0 = CC(3);
x1 = LX(1);
y1 = LZ(1);
x2 = LX(2);
y2 = LZ(2);
distC = abs((y2 - y1)*x0 - (x2 - x1)*y0 + x2*y1 - y2*x1)/sqrt((y2 - y1)^2 + (x2 - x1)^2);
distC = distC*cosd(30);

x0 = -DD(2);
y0 = DD(3);
x1 = LX(1);
y1 = LZ(1);
x2 = LX(2);
y2 = LZ(2);
distD = abs((y2 - y1)*x0 - (x2 - x1)*y0 + x2*y1 - y2*x1)/sqrt((y2 - y1)^2 + (x2 - x1)^2);
distD = distD*cosd(30);

dist = [distA distB distC distD];

ind1 = Y > 0 & Y < 1; %  & X > 0; % Z > 0; % 
ind2 = X > 0 & X < 1; %
figure(5)
clf
box on
hold on
axis equal
axis off
plot3(X(ind1),Y(ind1),Z(ind1),'b.')
plot3(X(ind2),Y(ind2),Z(ind2),'b.')
plot3(A(:,1),A(:,2),A(:,3),'g.')
plot3(B(:,1),B(:,2),B(:,3),'g.')
plot3(C(:,1),C(:,2),C(:,3),'g.')
plot3(D(:,1),D(:,2),D(:,3),'g.')
plot3(mean(A(:,1)),mean(A(:,2)),mean(A(:,3)),'ro')
plot3(mean(B(:,1)),mean(B(:,2)),mean(B(:,3)),'ro')
plot3(mean(C(:,1)),mean(C(:,2)),mean(C(:,3)),'ro')
plot3(mean(D(:,1)),mean(D(:,2)),mean(D(:,3)),'ro')
plot3(LX,LY,LZ,'k-','linewidth',3)
plot3(LY,LX,LZ,'k-','linewidth',3)
plot3(-LX,LY,LZ,'k-','linewidth',3)
plot3(LY,-LX,LZ,'k-','linewidth',3)

xlabel('x')
ylabel('y')
zlabel('z')

view(0,-1)
% view(90,-1)
ax = gca;               % get the current axis
ax.Clipping = 'off';    % turn clipping off
