function [R,R1,R2] = get_R_quat(qi)
%GET_R_QUAT
%   Get rotation matrix from a unit quaternions

% qi = get_quat_PHI(PHI);


% de Souza (2000), equation 3.50
q0 = qi(1);
q1 = qi(2);
q2 = qi(3);
q3 = qi(4);
q = qi(2:4);

R = 2*[(q0^2 + q1^2 - .5) (q1*q2 - q0*q3) (q1*q3 + q0*q2)
    (q2*q1 + q0*q3) (q0^2 + q2^2 - .5) (q2*q3 - q1*q0)
    (q3*q1 - q0*q2) (q3*q2 + q0*q1) (q0^2 + q3^2 - .5)];

% R = 2*[(q0^2 + q1^2 - q2^2 - q3^2) (q1*q2 + q0*q3) (q1*q3 - q0*q2)
%     (q2*q1 - q0*q3) (q0^2 - q1^2 + q2^2 - q3^2) (q2*q3 + q1*q0)
%     (q3*q1 + q0*q2) (q3*q2 - q0*q1) (q0^2 - q1^2 - q2^2 + q3^2)];

% R = 2*[(-q0^2 - q1^2 + .5) (q1*q2 + q0*q3) (q1*q3 - q0*q2)
%     (q2*q1 - q0*q3) (-q0^2 - q2^2 + .5) (q2*q3 + q1*q0)
%     (q3*q1 + q0*q2) (q3*q2 - q0*q1) (-q0^2 - q3^2 + .5)];

R1 = (2*q0^2 - 1)*eye(3) + 2*q0*get_S(q) + 2*(q*q');
R2 = (q0^2 - q'*q)*eye(3) + 2*q0*get_S(q) + 2*(q*q');

R = normc(R);
R1 = normc(R1);
R2 = normc(R2);

if isnan(norm(qi))
    R = eye(3);
    R1 = eye(3);
    R2 = eye(3);
end

end

