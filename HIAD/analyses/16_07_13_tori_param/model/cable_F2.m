function [F_pt] = cable_F2(ind,theta,I_theta_cable,F)
% Generate the force vector

theta_cable = [-cos(theta(I_theta_cable)) -sin(theta(I_theta_cable)) zeros(size(I_theta_cable,1),4)
    -cos(theta(I_theta_cable)) -sin(theta(I_theta_cable)) zeros(size(I_theta_cable,1),4)]';
theta_cable = theta_cable(:);

F0 = zeros(size(F,1)*6,size(F,2));
F0(1:6:end,:) = F(1:end,:);
F0(2:6:end,:) = F(1:end,:);

for j = 1:size(F0,2)
    F0(:,j) = F0(:,j).*theta_cable;
end


F_pt = zeros(ind.ind8(end)*6,size(F0,2));
F_pt((ind.ind3(1) - 1)*6 + 1:ind.ind3(end)*6,:) = F0;

end

