function [F] = press_dist(load,theta,r)
% Pressure distribution on tori

% % % Must modify code in order to use a pressure distribution
% % %  other than a constant pressure load.  The function assumes a uniform
% % %  distribution of nodes.  Must modify for a configuration other than a
% % %  circular shape.


Fx = load(1); % Force per length (x direction)
Fxi = Fx*2*pi*r/size(theta,1); % Force per node (assumes uniform distribution of nodes)
Fz = load(2); % Force per length (z direction)
Fzi = Fz*2*pi*r/size(theta,1); % Force per node (assumes uniform distribution of nodes)

% Iniitialize
f = zeros(size(theta,1),6);

% Components of pressure force
f(:,1) = Fxi*cos(theta);
f(:,2) = Fxi*sin(theta);
f(:,3) = Fzi;

% Force vector for FE input
f = f';
F = f(:);
end
