function [f,k] = strap_response(k0,k1,PT,F0,eps0)
% Create a smooth strap curve for HIAD analysis
% k0 = Tension stiffness
% k1 = Compression stiffness
% PT = Level of pretension
% F0 = Load level to begin linear tension stiffness
% eps0 = Strain level to begin linear tension stiffness

%% Start with derivative
% Stiffness as a function of strain
eps_k = [-eps0 0 eps0 2*eps0]';

% Create and edit polynomial
b = -(eps0*k0 - 3*F0 + 2*eps0*k1)/eps0^2;
a = (eps0*k0 - 2*F0 + eps0*k1)/eps0^3;
coefs_k = [0 0 k1
	3*a 2*b k1
    0 0 k0];
k = mkpp(eps_k,coefs_k);

% Force at left most point
f1 = -PT - k1*eps0;

% Integrate for force
f = fnint(k,f1);

% Curve shift
eps = fnzeros(f,[0 eps0]);
eps = eps(1);

f.breaks = f.breaks - eps;
k.breaks = k.breaks - eps;

end

