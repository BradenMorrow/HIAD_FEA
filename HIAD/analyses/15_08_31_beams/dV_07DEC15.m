% Calculate dV due to Poisson's effect
% December 07, 2015

% Define symbolic variables
syms nuLH eps_a kappa r0 theta dx L

y = r0*sin(theta); % Y distance from center to differential circumference
eps_l = eps_a - kappa*y; % Longitudinal strain
eps_h = -nuLH*eps_l; % Hoop strain

dc = r0; % r0*d_theta, differential circumference
d_delta_c = eps_h*dc; % Change in differential circumference

delta_c = int(d_delta_c,theta,0,2*pi); % Integrate for change in circumference

c = 2*pi*r0; % Initial circumference
r1 = (c + delta_c)/(2*pi); % New radius
V1 = pi*r1^2*dx; % New differential volume
V0 = pi*r0^2*dx; % Initial differential volume

d_delta_V = simple(V1 - V0); % Differential change in volume, integrate for change in volume

disp('d_delta_V = ')
disp(d_delta_V)

