function [eps] = get_eps(eps_in,r,phi_i,phi_j,alpha,kappa2)
% Strain in cords due to curvature

% Perpendicular distance from cords to NA
d1i = r*cosd(phi_i*180/pi + alpha);
d1j = r*cosd(phi_j*180/pi + alpha);

% Strain in cords
eps(:,1) = eps_in(:,1) - kappa2(1,1)*d1i;
eps(:,2) = eps_in(:,2) - kappa2(2,1)*d1j;

end

