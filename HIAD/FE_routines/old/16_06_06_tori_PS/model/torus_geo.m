function [tor_nodes,R,Utor0] = torus_geo(theta)
% April 29, 2016
% Generate torus specific geometry

% Torus major radius
R = 100;

% Location of nodes (initially perfect torus)
tor_nodes = [R*cos(theta) R*sin(theta) theta*0];

% Displacement to location of torus from perfect geometry
Utor0 = zeros(size(theta,1),6);
Utor0 = Utor0(:);

end