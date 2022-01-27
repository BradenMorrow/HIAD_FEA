function [qi] = get_quat_R(R)
%GET_QUAT_R
%   Get unit quaternions from a rotation matrix

[m,i] = max([trace(R) R(1,1) R(2,2) R(3,3)]);

if m == trace(R)
    q0 = 1/2*sqrt(m + 1);
    q1 = 1/(4*q0)*(R(3,2) - R(2,3));
    q2 = 1/(4*q0)*(R(1,3) - R(3,1));
    q3 = 1/(4*q0)*(R(2,1) - R(1,2));
    
elseif i - 1 == 1
    q1 = sqrt(m/2 + (1 - trace(R))/4);
    q0 = (R(3,2) - R(2,3))/(4*q1);
    q2 = (R(2,1) + R(1,2))/(4*q1);
    q3 = (R(3,1) + R(1,3))/(4*q1);
    
elseif i - 1 == 2
    q2 = sqrt(m/2 + (1 - trace(R))/4);
    q0 = (R(1,3) - R(3,1))/(4*q2);
    q1 = (R(1,2) + R(2,1))/(4*q2);
    q3 = (R(3,2) + R(2,3))/(4*q2);
    
else
    q3 = sqrt(m/2 + (1 - trace(R))/4);
    q0 = (R(1,3) - R(3,1))/(4*q3);
    q1 = (R(1,3) + R(3,1))/(4*q3);
    q2 = (R(2,3) + R(3,2))/(4*q3);
end

qi = [q0 q1 q2 q3]';

end

