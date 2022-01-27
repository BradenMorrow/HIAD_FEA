function axes_triad_cyl(x_origin,y_origin,z_origin,length,thickness)
% axes_triad
% Plots triad with properties specified by user in the driver script of
% post_proc

theta = linspace(0,pi/4,20)';
x = length*3/4*cos(theta) + x_origin;
y = length*3/4*sin(theta) + y_origin;
z = zeros(size(x));

% Plot lines of triad
plot3([x_origin,x_origin + length],[y_origin,y_origin],[z_origin,z_origin],'r','LineWidth',thickness);
plot3(x,y,z,'g','LineWidth',thickness);
plot3([x_origin,x_origin],[y_origin,y_origin],[z_origin,z_origin + length],'b','LineWidth',thickness);

% Text of triad
text((x_origin + length), y_origin, z_origin, '\bf X')
text(x(end) + length*.2,y(end) + length*.2,z(end), '\bf \theta')
text(x_origin, y_origin, (z_origin + length), '\bf Z')

end