function [R] = get_Ry(theta)

R = zeros(3,3,size(theta,1));
R(1,1,:) = cos(theta);
R(1,3,:) = sin(theta);
R(2,2,:) = 1;
R(3,1,:) = -sin(theta);
R(3,3,:) = cos(theta);

end

