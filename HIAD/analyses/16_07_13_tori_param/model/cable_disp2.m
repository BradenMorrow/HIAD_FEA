function [U_pt] = cable_disp2(ind,theta,I_theta_cable,Umag)
% Generate the initial cable displacments

theta_cable = theta(I_theta_cable);

U0_1 = zeros(ind.ind8(end),6);
U0_1(ind.ind3,1:2) = Umag*[cos(theta_cable) sin(theta_cable)
    -cos(theta_cable) -sin(theta_cable)];
U0_2 = U0_1';

U0 = U0_2(:);

U_pt = [U0*0 U0];

end

