function [F_pt] = cable_F(ind,theta,I_theta_cable,Fmag)
% Generate the force vector

theta_cable = theta(I_theta_cable);

F0_1 = zeros(ind.ind8(end),6);
F0_1(ind.ind3,1:2) = Fmag*[-cos([theta_cable; theta_cable]) -sin([theta_cable; theta_cable])];
F0_2 = F0_1';

F0 = F0_2(:);

F_pt = [F0*0 F0];

end

