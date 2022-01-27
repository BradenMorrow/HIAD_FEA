function [q12] = quat_prod(q2,q1)
%QUAT_PROD
% Quaternion product, q12 = q2*q1 (column vectors)
% de Souza 2000, equation 3.54

q10 = q1(1);
q20 = q2(1);

q1 = q1(2:4);
q2 = q2(2:4);

% Take the cross product of q1 and q2
c = [q1(2).*q2(3) - q1(3).*q2(2);  
    q1(3).*q2(1) - q1(1).*q2(3);  
    q1(1).*q2(2) - q1(2).*q2(1)]; 

q12 = [q10*q20 - q1'*q2
    q10*q2 + q20*q1 - c];

end

