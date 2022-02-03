% Working with pressure distribution
% March 01, 2016

% Load input
% d = load('p_unscaled_01MAR16');
X = d(:,2);
Y = d(:,3);
Z = d(:,1) + 10 - min(d(:,1));
P = d(:,4);

% Transform to cylindrical coordinates;
R = (X.^2 + Y.^2).^.5;
THETA = atan2(X,Y) + pi;

% [THETA,I] = sort(THETA0);
% R = R(I);
% Z = Z(I);

% HIAD geometry
C = [185.185453 84.342298
	213.724769 94.729760
	242.558759 105.224474
	271.650278 115.812921
	300.963157 126.481936
	322.382105 124.113612];
r = [31.837/2 % Minor radii of tori
    31.837/2
    31.837/2
    31.837/2
    31.837/2
    12.735/2];

x = C(:,1) + r*sind(20);
z = C(:,2) - r*cosd(20);

theta = linspace(0,2*pi,297)';
theta(end) = [];

p_tor = zeros(size(theta,1),6);

% for i = 1:6
%     p_tor(:,i) = interp3(R,THETA,Z,P,ones(size(theta))*r(i),theta,ones(size(theta))*C(i,2));
% end

%%
% F = scatteredInterpolant([R THETA Z],P,'nearest');
p_i = F(x(1)*cos(theta(1)),x(1)*sin(theta(1)),z(1))

%%
% ind = true(size(X));
ind = Z > 60 & Z < 80 & Y > -10 & Y < 10 & X > 180 & X < 200;
% ind = Y > -5 & Y < 5 & X > 0;

figure(10)
clf
box off
axis off
axis equal
hold on
% grid on

% plot3(X(ind),Y(ind),Z(ind),'b.')
% plot3(x(1)*cos(theta),x(1)*sin(theta),z(1)*ones(size(theta)),'ko-')
plot3(x(1)*cos(theta(1)),x(1)*sin(theta(1)),z(1)*ones(size(theta(1))),'ko-')
% plot3(0,0,0,'kx')

% plot3([0 400*cosd(20)],[0 0],[0 400*sind(20)],'k-','linewidth',2)

scatter3(X(ind),Y(ind),Z(ind),[],P(ind),'filled')
colorbar
colormap('jet')

view(3)

xlabel('X')
ylabel('Y')
zlabel('Z')

p = get_p([X Y Z P],[x(1)*cos(theta(1)) x(1)*sin(theta(1)) z(1)*ones(size(theta(1)))],5)

%%
% TRI = delaunay(X,Y,Z);
% figure(11)
% clf
% box on
% hold on
% axis equal
% trisurf(TRI,X,Y,Z)


ind1 = Z < 115;
X1 = X(ind1);
Y1 = Y(ind1);
Z1 = Z(ind1);
P1 = P(ind1);


