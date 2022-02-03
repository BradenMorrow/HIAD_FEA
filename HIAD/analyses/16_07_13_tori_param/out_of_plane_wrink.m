% Estimate out of plane wrinkling load
% October 4, 2016

p = 15; % Inflation pressure (psi)
r = 6.7; % Minor radius (in)
beta = 69; % Braid angle (deg)
EI = 8.0437e6; % Stiffness of cross section (lb*in^2)
EAc = 1.1861e5; % Stiffness of cord (lb/strain)
R = 60; % Major radius of torus (in)
L = 2*R*sind(45); % Span between supports (in)
alpha = 60; % Angle between horizontal and cord (deg)

% Wrinkling load
P = p*pi*r^2*(1 - 2*cotd(beta)^2)*2*EI/(EAc*L*r*sind(alpha));
