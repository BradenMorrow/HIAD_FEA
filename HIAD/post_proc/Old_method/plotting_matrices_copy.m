function [ x_plot,y_plot,z_plot,xyz,x2,y2,z2 ] = plotting_matrices_copy( Connect,U2,nodes,orientation,EL,scale,def,n )
% plotting_matrices 
%   Gets plotting matrices for torus or HIAD

% Inputs


% Undeformed
x = [nodes(Connect(:,1),1) nodes(Connect(:,2),1)];
y = [nodes(Connect(:,1),2) nodes(Connect(:,2),2)];
z = [nodes(Connect(:,1),3) nodes(Connect(:,2),3)];

% Deformed
x1 = [nodes(Connect(:,1),1) + U2(Connect(:,1),1)*scale...
    nodes(Connect(:,2),1) + U2(Connect(:,2),1)*scale];
y1 = [nodes(Connect(:,1),2) + U2(Connect(:,1),2)*scale...
    nodes(Connect(:,2),2) + U2(Connect(:,2),2)*scale];
z1 = [nodes(Connect(:,1),3) + U2(Connect(:,1),3)*scale...
    nodes(Connect(:,2),3) + U2(Connect(:,2),3)*scale];

% Define correct x, y, z inputs
if def == 1
    x2 = x1;
    y2 = y1;
    z2 = z1;
else
    x2 = x;
    y2 = y;
    z2 = z;
end

% Get CSA outputs
for j = 1:size(x2,1)
    orientation1 = orientation(Connect(j,1),:)';

    if Connect(j,3) == 3 
        cent1 = [x2(j,1),y2(j,1),z2(j,1)]';
        cent2 = [x2(j,2),y2(j,2),z2(j,2)]';

        % Run function
        [x_plot(:,n*j - (n - 1):n*j),y_plot(:,n*j - (n - 1):n*j),z_plot(:,n*j - (n - 1):n*j),xyz(n*j - (n - 1):n*j,:)] = ...
            circular_cross_section_copy(cent1,cent2,orientation1,EL(j).el_in0.r,n);
    end
end

% Resize plotting matrices
x_plot = x_plot(:,1:size(Connect(Connect(:,3) == 3),1)*n);
y_plot = y_plot(:,1:size(Connect(Connect(:,3) == 3),1)*n);
z_plot = z_plot(:,1:size(Connect(Connect(:,3) == 3),1)*n);
xyz = xyz(1:size(Connect(Connect(:,3) == 3),1)*n,:);
end

