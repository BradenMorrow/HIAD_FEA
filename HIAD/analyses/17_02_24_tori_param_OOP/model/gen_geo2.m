function [theta,I_theta_cable,I_theta_support,I_theta_load] = gen_geo2(n_cable,cable0,el_int,theta_support,theta_load,theta0)
% April 29, 2016
% Generate generic theta location of nodes

tol = 10^12;

% Theta location of nodes
theta = linspace(cable0*pi/180,2*pi + cable0*pi/180,(n_cable*el_int) + 1)';
theta(end) = [];
theta = unique(round(theta*tol)/tol);

theta_cable = linspace(cable0*pi/180,2*pi + cable0*pi/180,n_cable + 1)';
theta_cable(end) = [];

theta = unique([theta
    round(theta0*tol)/tol
    round(theta_support*tol)/tol
    round(theta_load*tol)/tol
    round(theta_cable*tol)/tol]);



% Theta location of supports
theta_1 = [theta; round(theta_support*tol)/tol];
[~,~,I_theta_support] = unique(theta_1);
I_theta_support = I_theta_support(end - size(theta_support,1) + 1:end);

% Theta location of oop loading
theta_2 = [theta; round(theta_load*tol)/tol];
[~,~,I_theta_load] = unique(theta_2);
I_theta_load = I_theta_load(end - size(theta_load,1) + 1:end);

% Theta location of cables
% theta_cable(3) = theta_cable(3) + 10*pi/180;

theta_3 = [theta; round(theta_cable*tol)/tol];
[~,~,I_theta_cable] = unique(theta_3);
I_theta_cable = I_theta_cable(end - size(theta_cable,1) + 1:end);

% theta = unique(round(theta*10^13)/10^13);



% theta2 = theta*180/pi;
end

