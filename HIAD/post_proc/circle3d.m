function [xyz] = circle3d(r,cent,v_norm,orient, n)
% circle3d
% Finds array of location of nodal circular cross sectional area

theta = linspace(0,2*pi,n)'; % Rotation angle (rad)
xyz0 = [zeros(n,1) r*cos(theta) r*sin(theta)]'; % Initial coordinates (yz plane)
xyz1 = zeros(size(xyz0)); % Initialize

v1 = [1 0 0]'; % Initial vectors
v2 = [0 1 0]';
v3 = [0 0 1]';

v_orient = orient - cent; % Orientation vector
v_orient = v_orient/norm(v_orient); 
v1p = v_norm/norm(v_norm); % Normal vector
v3p = cross(v_norm,v_orient); % New z vector
v3p = v3p/norm(v3p);
v2p = cross(v3p,v1p); % New y vector
v2p = v2p/norm(v2p);

A = [v1p'*v1 v1p'*v2 v1p'*v3 % Direction cosines matrix
    v2p'*v1 v2p'*v2 v2p'*v3
    v3p'*v1 v3p'*v2 v3p'*v3];

% Transform each point
for i = 1:n
    xyz1(:,i) = A'*xyz0(:,i);
end

% Translate to center of circle
xyz = xyz1' + [cent(1)*ones(n,1) cent(2)*ones(n,1) cent(3)*ones(n,1)];
end