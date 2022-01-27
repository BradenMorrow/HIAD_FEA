function [EL] = get_beam_EL(beta,p,r,EL0)
% Calculate the gross axial stiffness of an inflatable tube using netting
% theory

eps = .000001; % Arbitrary strain
F0 = p*pi*r^2*(1 - 2*cotd(beta)^2); % Initial reaction

nuLH = cotd(beta)^2;
dr = -r*nuLH*eps; % Change in tube radius
r1 = r + dr; % New tube radius

h = 2*pi*r*cotd(beta); % Initial tube height
h1 = h + h*eps; % New tube height

beta1 = atand((2*pi*r1)./h1); % New braid angle

F1 = p*pi*r1^2*(1 - 2*cotd(beta1)^2) - EL0*eps*2*pi*r; % New reaction

dTeff = -(F1 - F0); % Effective change in tensile force
EL = dTeff./(2*pi*r*eps); % Effective modulus

end

