% Pre-process the radial and tangential springs
% Andy Young
% December 31, 2014
%
% Preprocess the:
%   Location of nodes
%   Element connectivities
%   Element orientations
%   Boundary conditions
%   Force vector
% 
% Expanding to include geometric imperfections.  Must still include twist
% perturbations.

%% Nodes
% L - Element length (in)
vert_strap_nodes = strap_nodes;
vert_strap_nodes(:,3) = vert_strap_nodes(:,3) - L;


%% Orientation nodes
vert_strap_orientation = zeros(size(vert_strap_nodes,1),3);


%% Connectivities
% strap_ind = J(n + 1:end);
vert_ind = (tan_strap_ind(end) + 1:tan_strap_ind(end) + size(vert_strap_nodes,1))';
vert_strap_connect = [vert_ind strap_ind];


%% Boundaries
vert_strap_fix = ones(size(vert_strap_nodes,1),6);
vert_strap_bound = vert_strap_fix';
vert_strap_bound = vert_strap_bound(:);

%% Loading
vert_strap_F1 = zeros(size(vert_strap_bound,1),1);
% vert_strap_F2 = zeros(size(vert_strap_bound,1),1);
vert_strap_F2 = zeros(size(vert_strap_bound,1),size(P_strap,3));


%% Element type
% 1 = truss
% 2 = beam (Cook et al., 3D Beam Element)
% 3 = same as 2 without shear deformation
% 4 = Corotational formulation (Crisfield)
% 5 = Corotational formulation (Crisfield) with material nonlinearity
type = 3*ones(size(vert_strap_connect,1),1);
config = 6*ones(size(vert_strap_connect,1),1);
vert_strap_connect = [vert_strap_connect type config];


%% Materials and cross section
E = 1e6;
vert_material = [ones(size(vert_strap_nodes,1),1) ones(size(vert_strap_nodes,1),1)*E ones(size(vert_strap_nodes,1),1)*.3];

A = k_ax_vert_strap/(n + nP)*L/E;
I = k_b_vert_strap/(n + nP)*L^3/(12*E);
vert_geom = [A*ones(size(vert_strap_nodes,1),1) I*ones(size(vert_strap_nodes,1),2) ones(size(vert_strap_nodes,1),1)*2 2*I*ones(size(vert_strap_nodes,1),1)];

material = zeros(N,3);
geom = zeros(N,5);

material(vert_ind,:) = vert_material;
geom(vert_ind,:) = vert_geom;

config2 = 4; 
LIN_BEAM(config2).material = material;
LIN_BEAM(config2).geom = geom;

LIN_BEAM(config2).nodes = vert_strap_nodes;
LIN_BEAM(config2).connect = vert_strap_connect;
LIN_BEAM(config2).ind = vert_ind;





