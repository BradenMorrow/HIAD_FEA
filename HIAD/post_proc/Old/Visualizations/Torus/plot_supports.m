function plot_supports( supports )
% plot_supports 
%   Plots the supports of torus test setup

% Get variables from structure
r_t = supports.r_t;
r_m = supports.r_m;
n = supports.n;
c_x = supports.c_x;
c_y = supports.c_y;
c_s = supports.c_s;

% Other variables
h_s = 58; % Height of supports
h_p = 1; % Height of top part of support
r_s = 23/2; % Radius of the top of a support
r_sl = 1; % Radius of the leg of a support
l_f = -r_m - h_s; % Location of floor

% Used for supports
l_s = linspace(0,2*pi,5);
r_t = r_t + r_m;

% Used for plotting circles
theta = linspace(0,2*pi,n);

% Cylinder with radius of top of support
[x,y,~] = cylinder(r_s,n);
Z = [ones(1,n+1)*(h_s + l_f - h_p)
    ones(1,n+1)*(h_s + l_f)];

% Cylinder with radius of leg of support
[a,b,~] = cylinder(r_sl,n);
C = [ones(1,n+1)*l_f
    ones(1,n+1)*(h_s + l_f - h_p)];

% Plot supports
for i = 1:4
    xloc = r_t*cos(l_s(i)) + c_x;
    yloc = r_t*sin(l_s(i)) + c_y;
    X = x + xloc;
    Y = y + yloc;
    surf(X,Y,Z,'LineStyle','none','FaceColor',c_s)
    fill3(r_s*cos(theta) + xloc,r_s*sin(theta)+...
        yloc,ones(size(theta))*(h_s + l_f),c_s,'EdgeColor','none')
    % Plot legs of supports
    for j = 1:4
       aloc = (r_s-r_sl)*cos(l_s(j)) + xloc; 
       bloc = (r_s-r_sl)*sin(l_s(j)) + yloc; 
       A = a + aloc;
       B = b + bloc;
       surf(A,B,C,'LineStyle','none','FaceColor',c_s)
    end
end
end

