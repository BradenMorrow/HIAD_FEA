function plot_el3( v,f,xyz,plot_tor,color_plot )
%plot_el3
%   Uses patch and surf to plot tori/HIADs

% Fill
if plot_tor.plot_type == 2 || plot_tor.plot_type == 3
    patch('faces',f,'vertices',v,'facecolor',plot_tor.color,'edgecolor','none','facelighting','gouraud');
    material shiny
    
% Color plot
elseif plot_tor.plot_type == 1
    patch('faces',f,'vertices',v,'facevertexcdata',color_plot,'facecolor','interp','facelighting','gouraud');
    
    % Set color bar and scale
    colorbar
    if plot_tor.auto_scale == 0
        caxis(plot_tor.caxis)
    end
    
    colormap jet
    material shiny
    
% Wireframe
else patch('faces',f,'vertices',v, 'facecolor','none','edgecolor',plot_tor.color)
    plot3(xyz(1),xyz(2),xyz(3),plot_tor.color)
end
end
