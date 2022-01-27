function [f,k] = cord_response(k0,k1,PT,F0,eps0)
% Create a smooth strap curve for HIAD analysis
% September 29, 2016
% k0 = Tension stiffness
% k1 = Compression stiffness
% PT = Level of pretension
% F0 = Load level to begin linear tension stiffness
% eps0 = Strain level to begin linear tension stiffness

%% Start with derivative
% Stiffness as a function of strain
eps_k = [-eps0 0 eps0 2*eps0]';

% Create and edit polynomial
eps1 = (1/2*k1*eps0 + 1/2*k0*eps0 - F0)/(1/2*k1 + 1/2*k0);
eps_k(2) = eps1;
a = (k0 - k1)/(eps0 - eps1);
b = k1; %k1 - a*eps1;
coefs_k = [0 0 0 k1
	0 0 a b
    0 0 0 k0];
k = mkpp(eps_k,coefs_k);

% Force at left most point
f1 = -PT - k1*eps0;

% Integrate for force
f = fnint(k,f1);

% Find root
% % % p = f.coefs(2,:);
% % % xi = 0;
% % % F = 1;
% % % 
% % % count = 0;
% % % while abs(F) > 1e-10
% % %     F = polyval(p,xi);
% % %     Fp = polyval(polyder(p),xi);
% % %     xi = xi - F/Fp;
% % %     count = count + 1;
% % % end

% Curve shift
eps = fnzeros(f,[0 eps0]);
eps = eps(1);

f.breaks = f.breaks - eps;
k.breaks = k.breaks - eps;

end


