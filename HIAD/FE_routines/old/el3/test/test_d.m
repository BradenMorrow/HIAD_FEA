

theta_i = 10; % deg
theta_i = theta_i*pi/180; % rad
Ai = -1;
Bi = 0;
r = 5;
alpha = [60 180 300]';

plot_NA

d1 = get_d(r,Ai,theta_i,alpha);
d2 = r*cos(theta_i + alpha*pi/180) - Ai*ones(size(alpha));

[d1 d2]