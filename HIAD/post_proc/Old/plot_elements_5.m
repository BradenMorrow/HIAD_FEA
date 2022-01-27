function plot_elements_3( x_plot, y_plot, z_plot, xyz,color_plot,plot_tor)
% plot_elements_3
% plots deformed and undeformed tori 

% Plot color map
if plot_tor.plot_type == 1
    h = fill3(x_plot,y_plot,z_plot,color_plot);
    set(h,'edgecolor','none')

    % Set colorbar
    colorbar
    if plot_tor.auto_scale == 0
        caxis(plot_tor.caxis)
    end

    colormap jet
    
% Plot fill
elseif (plot_tor.plot_type == 2) || (plot_tor.plot_type == 3)
    h = fill3(x_plot,y_plot,z_plot,plot_tor.color);
    set(h,'edgecolor','none');  
    
% Plot wire frame
else
    plot3(x_plot, y_plot, z_plot, plot_tor.color)
    plot3(xyz(:,1),xyz(:,2),xyz(:,3), plot_tor.color)
end

    