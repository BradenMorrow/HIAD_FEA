
mi = tan(phi_i);
theta = 0:.001:2*pi;
xi = -r*2:r/2:r*2;


figure(3)
clf
axis off
box on
hold on
plot(xi,mi*(xi + y_bar2(1)*sin(phi_i)) + y_bar2(1)*cos(phi_i),'k--','linewidth',2)
plot(xi + Bi*cos(phi_i),-1/(mi + 1e-10)*xi + Bi*sin(phi_i),'r--','linewidth',2)

plot(r*sin(theta),r*cos(theta))
plot(0,0,'rx','markersize',10,'linewidth',1.5)
for j = 1:length(alpha)
    plot(r*sind(alpha(j)),r*cosd(alpha(j)),'kx','markersize',10,'linewidth',3)
end

mj = tan(phi_j);
theta = 0:.001:2*pi;
xj = -r*2:r/2:r*2;

plot(xj,mj*(xj + y_bar2(2)*sin(phi_j)) + y_bar2(2)*cos(phi_j),'k-')
plot(xj + Bj*cos(phi_j),-1/(mj + 1e-10)*xj + Bj*sin(phi_j),'r-')

xlim([-r*1.1 r*1.1])
ylim([-r*1.1 r*1.1])
axis equal

