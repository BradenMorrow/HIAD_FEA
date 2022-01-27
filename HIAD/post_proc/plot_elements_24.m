function plot_elements_24(plot_tor,Connect, x,y,z)
% plot_elements_24
% Plots elements other than 3

elements = plot_tor.el_type;
for j = 1:numel(elements)
    color = 'k-';
    for i = 1:size(x,1)
       if Connect(i,3) == elements(j)
            plot3(x(i,:),y(i,:),z(i,:),color,'linewidth',1.5)
       end
    end
end
end
      


