function [theta,I_theta_cable,I_theta_support] = gen_geo(n_cable,cable0,el_int,theta_support)
% April 29, 2016
% Generate generic theta location of nodes

% Theta location of nodes
theta = linspace(cable0*pi/180,2*pi + cable0*pi/180,(n_cable*el_int) + 1)';
theta(end) = [];

theta_cable = linspace(cable0*pi/180,2*pi + cable0*pi/180,n_cable + 1)';
theta_cable(end) = [];


% Theta location of supports
theta_1 = [theta; theta_support];
[theta,~,I_theta_support] = unique(theta_1);
I_theta_support = I_theta_support(end - size(theta_support,1) + 1:end);

% Theta location of cables
theta_2 = [theta; theta_cable];
[~,~,I_theta_cable] = unique(theta_2);
I_theta_cable = I_theta_cable(end - size(theta_cable,1) + 1:end);

end

