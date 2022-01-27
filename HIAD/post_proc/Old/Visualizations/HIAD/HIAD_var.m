function [ HIAD_vis ] = HIAD_var( HIAD_vis )
%HIAD_var Finds values needed in plot_nosecone and plot_centerbody
%   Detailed explanation goes here

% Unpack variables
t_cx = HIAD_vis.t_cx;
t_cz = HIAD_vis.t_cz;
r_c1 = HIAD_vis.r_c1;
angle = HIAD_vis.angle;
t_r = HIAD_vis.t_r;

% Find slope of line tangent to HIAD and equation of line perpendicular
s_l = tand(90 - angle);
s_p = -1/s_l;
c_p = t_cz - s_p*t_cx;

% Find where perpendicular intersects first torus
[i_x,i_z] = linecirc(s_p,c_p,t_cx,t_cz,t_r);
if i_x(1) > i_x(2);
    i_x = i_x(1);
    i_z = i_z(1);
else i_x = i_x(2);
    i_z = i_z(2);
end

% Find y-intercept of line, location of base of cylinder
c_l = i_z - s_l*i_x;
h_z = r_c1*s_l + c_l;

% More variables used in structure
HIAD_vis.s_l = s_l; % Slope of line tangent to HIAD
HIAD_vis.c_l = c_l; % Y-intercept of line tangent to HIAD
HIAD_vis.i_z = i_z; % Z-coordinate of intersection of first torus and line perpendicular to line tangent to torus
HIAD_vis.h_z = h_z; % Location of bottom of centerbody and top of nosecone
end

