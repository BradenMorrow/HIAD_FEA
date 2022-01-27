function [Kel,fint_i,Fint_i,ROT,el_out] = el1_nonlin(U_in,el_in,el_in0)
%EL1
%   Axial lookup, 3D beam element

% Extract variables
% Geometry
nodes = el_in.nodes_ij;
orient = el_in.orient_ij;

% Materials
mat = el_in0.mat;
L0 = sum((nodes(2,:) - nodes(1,:)).^2).^.5;

axial = el_in0.axial;
axial_k = el_in0.axial_k;

% Obtain displacements of interest
Uel = U_in.U';
Uel = Uel(:);

% Transformation matrix
T = T_beam_3d(nodes,orient);

% Local element displacements
u = T*Uel;

% Axial strain
eps = (u(7) - u(1))/L0;

% Nonlinear axial response geometry
f = ppval_fast(axial,eps); % Interpolate for force % 
EAax = ppval_fast(axial_k,eps); % Stiffness is derivative of force-stain relationship

geom = el_in0.geom;
geom(1) = EAax/mat(1); % Vary cross sectional area

% Local element stiffness matrix
k = k1(mat,geom,L0);

% Element stiffness matrix
Kel = T'*k*T;

% Element internal forces
fint_i = k*u; % Local
fint_i([1 7]) = [-f f];

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