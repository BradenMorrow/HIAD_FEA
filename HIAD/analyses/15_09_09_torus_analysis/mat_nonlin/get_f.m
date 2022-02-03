function [f] = get_f(y_bar,eps,eps0,r,phi_i,phi_j,alpha,kappa2,axial,axial1,interp_meth,lookup,f_cord0,eps_cord0)

% ----------
% Strain in cords, inflation, axial and bending
[eps_cord,d1i,d1j] = get_eps(eps + eps0,y_bar,r,phi_i,phi_j,alpha,kappa2);

% Interposlate for force in cords
if lookup == 1
    f_cord = ppval(axial_0,eps_cord);
    k_cord = ppval(axial_1,eps_cord);
elseif lookup == 2
    f_cord = interp1(axial(:,2),axial(:,1),eps_cord,interp_meth);
    k_cord = interp1(axial1(:,2),axial1(:,1),eps_cord,interp_meth);
end

%     f = sum(f_cord)' - f0 + 2*pi*r*t*EL*(eps*[1 1]' - y_bar.*kappa2); %; %3*Fc; % 
%     f = sum(f_cord)' - f0 + sum(k_cord.*(eps_cord - eps_cord0))' + 2*pi*r*t*EL*(eps*[1 1]' - y_bar.*kappa2); %; %3*Fc; % 
f = sum(f_cord - f_cord0)' + sum(k_cord.*(eps_cord - eps_cord0))'; % + 2*pi*r*t*EL*(eps*[1 1]' - y_bar.*kappa2);


f = norm(f);
end

