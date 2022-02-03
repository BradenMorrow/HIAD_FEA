function [Crot] = rot_HIAD(theta,C)
% Rotate the initial location of the HIAD

Crot = zeros(size(C));
Crot(1,:) = C(1,:);


for i = 2:size(C,1)
    alpha0 = atan2((C(i,2) - C(1,2)),(C(i,1) - C(1,1)))*180/pi;
    alpha1 = alpha0 - theta;
    
    L = ((C(i,2) - C(1,2))^2 + (C(i,1) - C(1,1))^2)^.5;
    x1 = C(1,1) + L*cosd(alpha1);
    y1 = C(1,2) + L*sind(alpha1);
    Crot(i,:) = [x1 y1];
end




end

