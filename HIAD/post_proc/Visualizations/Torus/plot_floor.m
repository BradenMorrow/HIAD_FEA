function plot_floor( floor )
% plot_floor Plots floor of torus test setup
%   Plots a rectangle with location, dimensions and color specified in Test_setup

% Get variables
c_f = floor.c_f;
c_x = floor.c_x;
c_y = floor.c_y;
f_x = floor.f_x;
f_y = floor.f_y;
r_m = floor.r_m;
l_f = -58 - r_m;

% Plot floor
x_f = [c_x - f_x/2,c_x + f_x/2,c_x + f_x/2,c_x - f_x/2];
y_f = [c_y + f_y/2,c_y + f_y/2,c_y - f_y/2,c_y - f_y/2];
z_f = [l_f,l_f,l_f,l_f];
fill3(x_f,y_f,z_f,c_f,'EdgeColor','none')
end

