function [U_pt] = cable_disp_tor(ind,theta,I_theta_cable,Umag)
% Generate the initial cable displacments

theta_cable = theta(I_theta_cable);
th = linspace(0,4*pi,size(I_theta_cable,1) + 1)';
th(end) = [];

Umag_tor = Umag*[-cos(th); cos(th)];

U0_1 = zeros(ind.ind8(end),6);
U0_1(ind.ind3,1:2) = [-Umag_tor.*cos([theta_cable; theta_cable]) -Umag_tor.*sin([theta_cable; theta_cable])];
U0_2 = U0_1';

U0 = U0_2(:);

U_pt = [U0*0 U0];

end

