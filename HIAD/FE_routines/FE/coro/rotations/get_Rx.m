function [R] = get_Rx(theta)

R = zeros(3,3,size(theta,1));
R(1,1,:) = 1;
R(2,2,:) = cos(theta);
R(2,3,:) = -sin(theta);
R(3,2,:) = sin(theta);
R(3,3,:) = cos(theta);

end

