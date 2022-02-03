function [eps,d1i,d1j] = get_eps(eps_in,y_bar,r,phi_i,phi_j,alpha,kappa2)
%GET_F Summary of this function goes here
%   Detailed explanation goes here

% Strain in cords due to axial strain
% eps = ones(size(alpha,1),2)*eps_ax;

% Strain in cords due to curvature
% A = y intercept, m = slope of line
Ai = y_bar(1);
Aj = y_bar(2);

% Perpendicular distance from cords to NA
d1i = r*cosd(phi_i*180/pi + alpha) - Ai*ones(size(alpha));
d1j = r*cosd(phi_j*180/pi + alpha) - Aj*ones(size(alpha));

% Strain in cords
eps(:,1) = eps_in(:,1) - kappa2(1,1)*d1i;
eps(:,2) = eps_in(:,2) - kappa2(2,1)*d1j;

end

