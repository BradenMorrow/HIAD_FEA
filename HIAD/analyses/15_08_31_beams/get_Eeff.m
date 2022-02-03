function [Eeff] = get_Eeff(p,beta0,EL,r0)
% Calculate effective longitudinal stiffness and look at scaling
% January 16 2016

% % % p = 20; % Pressure
% % % beta0 = 59.75; % Initial braid angle
% % % EL = 99.7821957804708; % Shell modulus

nuLH0 = cotd(beta0)^2; % Initial Poisson's ratio
eps0 = .000001; % Arbitrary strain

% % % r0 = 6.7225; % Initial radius
F0 = p*pi*r0.^2*(1 - 2*nuLH0); % Initial reaction

dr = -r0*nuLH0*eps0; % Change in tube radius
r1 = r0 + dr;

h0 = 2*pi*r0*cotd(beta0); % Change in tube height
h1 = h0 + h0*eps0;

beta1 = atand((2*pi*r1)./h1); % New braid angle
nuLH1 = cotd(beta1).^2; % New Poisson's ratio

F1 = p*pi*r1.^2.*(1 - 2*nuLH1) - EL*eps0*2*pi*r0; % New reaction

dTeff = -(F1 - F0); % Effective change in tensile force
Eeff = dTeff./(2*pi*r0*eps0); % Effective modulus


end


