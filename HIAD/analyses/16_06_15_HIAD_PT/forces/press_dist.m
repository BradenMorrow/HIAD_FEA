function [F] = press_dist(P,cone_ang,trib,theta,R)

w = P*trib; % Force per length
wn = w*2*pi*R/size(theta,1); % Force per node

% Iniitialize
f = zeros(size(theta,1),6);

% Components of pressure force
f(:,1) = -wn*cosd(cone_ang)*cos(theta);
f(:,2) = -wn*cosd(cone_ang)*sin(theta);
f(:,3) = wn*sind(cone_ang);

% Force vector for FE input
f = f';
F = f(:);


r1 = 657.5/2; % Outside radius (in)
r0 = 340/2; % Centerbody radius (in)

Atot = pi*r1^2; % Total area
Acb = pi*r0^2; % Centerbody area
Ainf = Atot - Acb; % Inflatable area
Finf = Ainf/Atot*.8*350000; % Vertical force on inflatable

p_v = Finf/Ainf; % Vertical component of pressure
p = p_v/cosd(20); % Pressure force on inflatable
% Output, p = 0.87759 psi
end
