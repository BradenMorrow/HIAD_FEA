function [T] = T_beam_3d(nodes,orient)
%T_BEAM_3D
%   Generate the transformation matrix for a 3D beam element;

% Length of element
L_x = nodes(2,1) - nodes(1,1);
L_y = nodes(2,2) - nodes(1,2);
L_z = nodes(2,3) - nodes(1,3);

% Vector to orientation node
L_xo = orient(1,1) - nodes(1,1);
L_yo = orient(1,2) - nodes(1,2);
L_zo = orient(1,3) - nodes(1,3);

% Unit vectors
% Global
x = [1 0 0]';
y = [0 1 0]';
z = [0 0 1]';

% Local
xp = [L_x L_y L_z]';
xp = xp/norm(xp);

zp = cross(xp,[L_xo L_yo L_zo]');
zp = zp/norm(zp);

yp = cross(zp,xp);
yp = yp/norm(yp);

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

