function [R] = get_Rz(theta)

R = zeros(3,3,size(theta,1));
R(1,1,:) = cos(theta);
R(1,2,:) = -sin(theta);
R(2,1,:) = sin(theta);
R(2,2,:) = cos(theta);
R(3,3,:) = 1;

end

