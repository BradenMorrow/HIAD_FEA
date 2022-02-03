function [T] = T_section(e)
%   Rotate the beam section from the NA to the local coordinate system

% Unit vectors
% Global
x = [1 0 0]';
y = [0 1 0]';
z = [0 0 1]';

% Local
xp = [1 0 0]';
yp = [0 e(1,1) e(2,1)]';
zp = [0 e(1,2) e(2,2)]';

% Direction cosines matrix
lambda = [x'*xp y'*xp z'*xp
    x'*yp y'*yp z'*yp
    x'*zp y'*zp z'*zp];

% Assemble transformation matrix
T_zero = zeros(3);
T = [lambda T_zero T_zero T_zero
    T_zero lambda T_zero T_zero
    T_zero T_zero lambda T_zero
    T_zero T_zero T_zero lambda];

end

