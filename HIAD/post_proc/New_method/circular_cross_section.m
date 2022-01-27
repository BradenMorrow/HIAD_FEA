function [x_plot,y_plot,z_plot,xyz] = circular_cross_section(cent1,cent2,orientation,r,n)
% circular_cross_section
% Gets plotting matrices for slats between two cross sectional areas and 
% get the location of those cross sectional areas

% Determining v for circle3d
v = cent2 - cent1;
    
% Run circle3d
xyz = circle3d(r,cent1,v,orientation, n);
xyz2 = circle3d(r,cent2,v,orientation, n);

% Initialize matrices
x_plot = zeros(2,n);
y_plot = zeros(2,n);
z_plot = zeros(2,n);

% Populating the plotting arrays
for j = 1:n;
    if j == n;
        x_plot(1:2,j) = [xyz(j,1); xyz2(j,1)];
        y_plot(1:2,j) = [xyz(j,2); xyz2(j,2)];
        z_plot(1:2,j) = [xyz(j,3); xyz2(j,3)];
           
    else
        x_plot(1:2,j) = [xyz(j,1); xyz2(j,1)];
        y_plot(1:2,j) = [xyz(j,2); xyz2(j,2)];
        z_plot(1:2,j) = [xyz(j,3); xyz2(j,3)];
    end
end
end