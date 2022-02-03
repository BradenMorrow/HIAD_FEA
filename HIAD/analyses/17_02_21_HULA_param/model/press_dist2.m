function [F] = press_dist2(load,theta,R)
% Pressure distribution on tori

% % % Must modify code in order to use a pressure distribution
% % %  other than a constant pressure load.  The function assumes a uniform
% % %  distribution of nodes.  Must modify for a configuration other than a
% % %  circular shape.


Fx = load(1); % Force per length (x direction)
Fxi = Fx*2*pi*R/size(theta,1); % Force per node (assumes uniform distribution of nodes)
Fz = load(2); % Force per length (z direction)
Fzi = Fz*2*pi*R/size(theta,1); % Force per node (assumes uniform distribution of nodes)

% Iniitialize
f = zeros(size(theta,1),6);


%%
% Components of pressure force
f(:,1) = -(Fxi*cos(2*theta) - Fxi).*cos(theta);
f(:,2) = -(Fxi*cos(2*theta) - Fxi).*sin(theta);
f(:,3) = Fzi*-cos(2*theta) + Fzi;


% % % figure(2)
% % % clf
% % % box on
% % % hold on
% % % % plot(theta*180/pi,f(:,1))
% % % 
% % % Fr = hypot(f(:,1),f(:,2));
% % % plot(theta*180/pi,Fxi*cos(2*theta) - Fxi)
% % % plot(theta*180/pi,Fr,'r--')


%%


% Force vector for FE input
f = f';
F = f(:);
end
