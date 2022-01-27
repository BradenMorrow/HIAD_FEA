function [Kel,fint_i,Fint_i,ROT,el_out] = el1(U_in,el_in,el_in0)
%EL1
%   Linear elastic, 3D beam element

% Extract variables
% Geometry
nodes = el_in.nodes_ij;
orient = el_in.orient_ij;

% Materials
mat = el_in0.mat;
geom = el_in0.geom;
L0 = sum((nodes(2,:) - nodes(1,:)).^2).^.5;

% Obtain displacements of interest
Uel = U_in.U';
Uel = Uel(:);

% Transformation matrix
T = T_beam_3d(nodes,orient);

% Local element displacements
u = T*Uel;

% Local element stiffness matrix
k = k1(mat,geom,L0);

% Element stiffness matrix
Kel = T'*k*T;

% Element internal forces
fint_i = k*u; % Local
Fint_i = T'*fint_i; % Global

% Extract rotations
drot = U_in.delta_U(:,4:6);
roti = U_in.U(:,4:6);
ROT.rot = roti + drot; % Total rotation
ROT.DELTA_rot = zeros(size(roti)); % Initialize ROT.DELTA_rot

rot0 = U_in.U0(:,4:6);
ROT.DELTA_rot = ROT.rot - rot0; % Increment change in rotation

% Do not need to save any variables for future iterations
el_out = el_in0;

el_out.break = 0;

end