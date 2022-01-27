function axes_triad(x_origin,y_origin,z_origin,length,thickness)
% axes_triad
% Plots triad with properties specified by user in the driver script of
% post_proc

% Plot lines of triad
plot3([x_origin,x_origin + length],[y_origin,y_origin],[z_origin,z_origin],'r','LineWidth',thickness);
plot3([x_origin,x_origin],[y_origin,y_origin + length],[z_origin,z_origin],'g','LineWidth',thickness);
plot3([x_origin,x_origin],[y_origin,y_origin],[z_origin,z_origin + length],'b','LineWidth',thickness);

% Text of triad
text((x_origin + length), y_origin, z_origin, '\bf X')
text(x_origin, (y_origin + length), z_origin, '\bf Y')
text(x_origin, y_origin, (z_origin + length), '\bf Z')
