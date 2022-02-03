function [f,k] = strap_response(k0,k1,PT,eps_fac,noPT)
% Create a smooth strap curve for HIAD analysis
% March 16, 2016

%% Start with derivative
% k0 = 114000;
% k1 = 300;
% PT = 50;
eps0 = eps_fac*PT/k0; % Unload strain

% Stiffness as a function of strain
eps_k = [-2*eps0 -eps0 0 eps0]';

% For zero pretension
if noPT == 1
    eps_k = eps_k - eps_k(2);
end

% Create and edit polynomial
b = -(eps0*k0 - 3*PT + 2*eps0*k1)/eps0^2;
a = (eps0*k0 - 2*PT + eps0*k1)/eps0^3;
c = k1;
% d = -PT;
coefs_k = [0 0 k1
	3*a 2*b c
    0 0 k0];
k = mkpp(eps_k,coefs_k);

% Force at left most point
f1 = -PT - k1*eps0;

% Integrate for force
f = fnint(k,f1);

f0 = ppval(f,0);
if f0 ~= 0
    f = fnint(k,f1 - f0);
end


%% Plot
% % % figure(10)
% % % clf
% % % box on
% % % hold on
% % % fnplt(k,'b-')

% % % figure(11)
% % % % clf
% % % box on
% % % hold on
% % % fnplt(f,'r-')
% % % 
% % % 
% % % eps = linspace(0,.004,100)';
% % % force = fnval(f,eps)*4.448222/1000;
% % % 
% % % 
% % % figure(12)
% % % % clf
% % % box on
% % % hold on
% % % plot(eps*100,force,'k-')
% % % 
% % % xlabel('Strap strain (%)')
% % % ylabel('Strap force (kN)')
% % % 
% % % legend('Loop straps','location','northwest')

% % % %%
% % % syms PT a b c d k1 k0 eps0
% % % d = -PT;
% % % c = k1;
% % % x = eps0;
% % % a = (-d - c*x - b*x^2)/x^3;
% % % % b = (k0 - c - 3*a*x^2)/(2*x)
% % % 
% % % b = simplify(solve((k0 - 3*a*x^2 - c)/(2*x) - b == 0,b));
% % % a = simplify(subs(a));


end


