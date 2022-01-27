
mi = tan(phi_i);
theta = 0:.001:2*pi;
xi = -r*2:r/2:r*2;


y_bar2 = [sum(k_cord(:,1)*r.*cosd(phi_i*180/pi + alpha))/(sum(k_cord(:,1)) + EL*2*pi*r*t)
    sum(k_cord(:,2)*r.*cosd(phi_j*180/pi + alpha))/(sum(k_cord(:,2)) + EL*2*pi*r*t)];

% Perpendicular distance from cords to line perpendicular to NA through A
d2i = r*sind(phi_i*180/pi + alpha);
d2j = r*sind(phi_j*180/pi + alpha);

% Location of centroid
Bi = sum(k_cord(:,1).*d2i)/(sum(k_cord(:,1)) + EL*2*pi*r*t);
Bj = sum(k_cord(:,2).*d2j)/(sum(k_cord(:,2)) + EL*2*pi*r*t);


figure(3)
clf
axis off
box on
hold on
plot(xi,mi*(xi + y_bar(1)*sin(phi_i)) + y_bar(1)*cos(phi_i),'k--','linewidth',2)
plot(xi,mi*(xi + y_bar2(1)*sin(phi_i)) + y_bar2(1)*cos(phi_i),'g--','linewidth',2)
plot(xi + Bi*cos(phi_i),-1/(mi + 1e-10)*xi + Bi*sin(phi_i),'r--','linewidth',2)

plot(r*sin(theta),r*cos(theta))
plot(0,0,'rx','markersize',10,'linewidth',1.5)
for j = 1:length(alpha)
    plot(r*sind(alpha(j)),r*cosd(alpha(j)),'kx','markersize',10,'linewidth',3)
end

mj = tan(phi_j);
theta = 0:.001:2*pi;
xj = -r*2:r/2:r*2;

plot(xj,mj*(xj + y_bar(2)*sin(phi_j)) + y_bar(2)*cos(phi_j),'k-')
plot(xj + Bj*cos(phi_j),-1/(mj + 1e-10)*xj + Bj*sin(phi_j),'r-')

xlim([-r*1.1 r*1.1])
ylim([-r*1.1 r*1.1])
axis equal

a = 1;