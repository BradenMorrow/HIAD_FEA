% Working with pressure distribution
% March 01, 2016

% Load input
d = load('p_unscaled_01MAR16');
X = d(:,2);
Y = d(:,3);
Z = d(:,1);
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

z = C(:,2) - r*cosd(20);

theta = linspace(0,2*pi,297)';
theta(end) = [];

p_tor = zeros(size(theta,1),6);

% for i = 1:6
%     p_tor(:,i) = interp3(R,THETA,Z,P,ones(size(theta))*r(i),theta,ones(size(theta))*C(i,2));
% end
% 
% F = scatteredInterpolant([R THETA Z],P)


%%
figure(10)
clf
box off
% axis off
axis equal
hold on
plot3(X(Z > 60),Y(Z > 60),Z(Z > 60),'b.')
% % plot3(X(X > 0),Y(X > 0),Z(X > 0),'r.')
% plot3(X(X > -10 & X < 10),Y(X > -10 & X < 10),Z(X > -10 & X < 10),'r.')
% scatter3(X,Y,Z)


xlabel('X')
ylabel('Y')
zlabel('Z')












