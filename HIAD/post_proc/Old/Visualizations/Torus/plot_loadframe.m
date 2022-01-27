function plot_loadframe( loadframe )
% plot_loadframe 
%   Plots the loadframe of the torus test-setup

% Get variables from structure
r_m = loadframe.r_m;
n = loadframe.n;
c_x = loadframe.c_x;
c_y = loadframe.c_y;
c_l = loadframe.c_l;

% Other variables
l_f = -r_m - 58; % Location of floor
h_L = 59 + 3/4; % Height of short part of load frame
h_l = 73; % Height of tall part of load frame
h_t = 1; % Height of top disk of load frame
h_m = 1; % Height of middle disk of load frame
h_b = 1; % Height of bottom disk of load frame
r_sw = 3.5/2; % Radius of the support of the load frame
r_l = 19; % Radius of the tall part of the load frame
r_L = 26; % Radius of the short part of the load frame
w_r = 17; % Inner radius of the short part of the load frame

% Used for plotting circles
theta = linspace(0,2*pi,n);

% Used for location of supports
l_s = linspace(0,2*pi,5);

% Plot tall part of load frame
[x_t,y_t,~] = cylinder(r_l,n);
x_t = x_t + c_x;
y_t = y_t + c_y;
z_t = [ones(1,n+1)*(h_l - h_t + l_f)
    ones(1,n+1)*(h_l + l_f)];
surf(x_t,y_t,z_t, 'LineStyle','none','FaceColor',c_l)
fill3(r_l*cos(theta) + c_x,r_l*sin(theta) + c_y,ones(size(theta))*(l_f + h_l),c_l,'EdgeColor','none')

% Plot short part of load frame
%   Plot cylinder with radius r_L
[x,y,~] = cylinder(r_L,n);
x = x + c_x;
y = y + c_y;
z = [ones(1,n+1)*(l_f+h_L-h_m)
    ones(1,n+1)*(h_L+l_f)];
z_b = [ones(1,n+1)*l_f
    ones(1,n+1) * l_f + h_b];
surf(x,y,z, 'LineStyle','none','FaceColor',c_l)
surf(x,y,z_b, 'LineStyle','none','FaceColor',c_l)
fill3(r_L*cos(theta),r_L*sin(theta),ones(size(theta))*(l_f + h_b),c_l, 'EdgeColor','none')

%   Plot "washers"
x_w = [w_r*cos(theta(1:end - 1))
    r_L*cos(theta(1:end - 1))
    r_L*cos(theta(2:end))
   w_r*cos(theta(2:end))];
x_w = x_w + c_x;
y_w = [w_r*sin(theta(1:end - 1))
    r_L*sin(theta(1:end - 1))
    r_L*sin(theta(2:end))
    w_r*sin(theta(2:end))];
y_w = y_w + c_y;
z_w = [z(1,:)
    z(1,:)
    z(1,:)
    z(1,:)
    z(2,:)
    z(2,:)
    z(2,:)
    z(2,:)];
fill3(x_w,y_w,z_w(1:4,1:end-2),c_l,'EdgeColor','none')
fill3(x_w,y_w,z_w(5:8,1:end-2),c_l,'EdgeColor','none')

% Supports of load frame
%   Cylinder with radius of support of load frame
[x_s,y_s,~] = cylinder(r_sw,n);
z_l = [ones(1,n+1)*(l_f + h_b)
    ones(1,n+1)*(l_f + h_l - h_t)];
z_L = [ones(1,n+1)*(l_f + h_b)
    ones(1,n+1)*(l_f + h_L - h_m)];

%   Plot supports of load frame
for i = 1:4
    x_l = x_s + (w_r - r_sw*3)*cos(l_s(i)) + c_x;
    y_l = y_s + (w_r - r_sw*3)*sin(l_s(i)) + c_y;
    x_L = x_s + (w_r + r_sw*2)*cos(l_s(i)) + c_x;
    y_L = y_s + (w_r + r_sw*2)*sin(l_s(i)) + c_y;
    
    surf(x_l,y_l,z_l,'LineStyle','none','FaceColor',c_l)
    surf(x_L,y_L,z_L,'LineStyle','none','FaceColor',c_l)
end
end

