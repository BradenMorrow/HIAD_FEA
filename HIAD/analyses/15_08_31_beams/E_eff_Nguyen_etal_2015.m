% Calculate effective longitudinal stiffness
% Based on Nguyen et al. 2015



p = 20; % Pressure
r0 = 6.7225; % Initial radius
EL0 = 99.7821957804708; % Shell modulus - longitudinal
EH = 830.034166620375; % Shell modulus - longitudinal
GLH0 = 6135.38900384281;
beta = 59.75; % Initial braid angle
nuLH = cotd(beta)^2; % Poisson's ratio
nuHL = 2.81709211913857;

a = EL0/(p*r0);
b = 3*nuLH;
c = -(EL0/(p*r0) + 2*p*r0/EH*(1 - nuLH*nuHL));
d = -(1 + nuLH);

L_ratio1 = roots([a b c d]);
L_ratio = L_ratio1(1);

r_ratio = sqrt(EL0/(p*r0)*L_ratio*(L_ratio^2 - 1) + 2*nuLH*L_ratio^2);

EL1 = EL0*L_ratio^3/r_ratio
GLH1 = GLH0*L_ratio*r_ratio


% % % F0 = p*pi*r0^2*(1 - 2*nuLH0); % Initial reaction
% % % 
% % % dr = -r0*nuLH0*eps0; % Change in tube radius
% % % r1 = r0 + dr;
% % % 
% % % h0 = 2*pi*r0*cotd(beta); % Change in tube height
% % % h1 = h0 + h0*eps0;
% % % 
% % % beta1 = atand((2*pi*r1)/h1); % New braid angle
% % % nuLH1 = cotd(beta1)^2; % New Poisson's ratio
% % % 
% % % F1 = p*pi*r1^2*(1 - 2*nuLH1) - EL0*eps0*2*pi*r0; % New reaction
% % % 
% % % dTeff = -(F1 - F0); % Effective change in tensile force
% % % Eeff = dTeff/(2*pi*r0*eps0) % Effective modulus
% % % % Eeff = 237.000342996301





