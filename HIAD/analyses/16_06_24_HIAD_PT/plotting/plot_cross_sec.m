function plot_cross_sec(r,alpha)
% Plot the cross section of an inflatable member
% February 09, 2016

theta = linspace(0,2*pi,100)';
x = r*cos(theta);
y = r*sin(theta);


figure(10)
clf
box on
hold on
axis off
axis equal
plot(x,y,'b-') % Cross section
plot([-r r]*2,[0 0],'r-') % Cross hairs
plot([0 0],[-r r]*2,'r-')

plot(r*sind(alpha),r*cosd(alpha),'ko','markersize',8,'linewidth',2) % Cords
% annotation('textarrow',[.51 cosd(45)],[.51 sind(45)],'String','y = x ')
% annotation('text',[.51 cosd(45)],[.51 sind(45)],'String','y = x ')

xlim([-r r]*1.2)
ylim([-r r]*1.2)






