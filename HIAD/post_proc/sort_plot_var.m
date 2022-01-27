function [ Ind ] = sort_plot_var( xyz )
%sort_plot_var
%   
x_plot1 = xyz(:,1);
x_c = (max(x_plot1) + min(x_plot1))/2;
x_plot1 = x_plot1 - x_c;
z_plot1 = xyz(:,3);
z_c = (max(z_plot1) + min(z_plot1))/2;
z_plot1 = z_plot1 - z_c;
[theta,~] = cart2pol(x_plot1,z_plot1);
theta(theta < 0) = theta(theta < 0) + 2*pi;
[~,Ind] = sort(theta);


