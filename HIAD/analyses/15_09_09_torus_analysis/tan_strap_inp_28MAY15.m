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
n_norm_strap = normr(strap_nodes);
tan_strap_nodes = strap_nodes + [-n_norm_strap(:,2) n_norm_strap(:,1) zeros(size(strap_nodes,1),1)]*L;


%% Orientation nodes
tan_strap_orientation = [zeros(size(tan_strap_nodes,1),2) 1e6*ones(size(tan_strap_nodes,1),1)];


%% Connectivities
% strap_ind = J(n + 1:end);
tan_strap_ind = (vert_tor_ind(end) + 1:vert_tor_ind(end) + size(tan_strap_nodes,1))';
tan_strap_connect = [tan_strap_ind strap_ind];


%% Boundaries
tan_strap_fix = ones(size(tan_strap_nodes,1),6);
tan_strap_bound = tan_strap_fix';
tan_strap_bound = tan_strap_bound(:);

%% Loading
tan_strap_F1 = zeros(size(tan_strap_bound,1),1);
% tan_strap_F2 = zeros(size(tan_strap_bound,1),1);
tan_strap_F2 = zeros(size(tan_strap_bound,1),size(P_strap,3));


%% Element type
% 1 = truss
% 2 = beam (Cook et al., 3D Beam Element)
% 3 = same as 2 without shear deformation
% 4 = Corotational formulation (Crisfield)
% 5 = Corotational formulation (Crisfield) with material nonlinearity
type = 3*ones(size(tan_strap_connect,1),1);
config = 5*ones(size(tan_strap_connect,1),1);
tan_strap_connect = [tan_strap_connect type config];


%% Materials and cross section
E = 1e6;
tan_strap_material = [ones(size(tan_strap_nodes,1),1) ones(size(tan_strap_nodes,1),1)*E ones(size(tan_strap_nodes,1),1)*.3];

A = k_ax_tan_strap*L/E;
I = k_b_tan_strap*L^3/(12*E);
tan_strap_geom = [A*ones(size(tan_strap_nodes,1),1) I*ones(size(tan_strap_nodes,1),2) ones(size(tan_strap_nodes,1),1)*2 2*I*ones(size(tan_strap_nodes,1),1)];

material = zeros(N,3);
geom = zeros(N,5);

material(tan_strap_ind,:) = tan_strap_material;
geom(tan_strap_ind,:) = tan_strap_geom;

config2 = 3;
LIN_BEAM(config2).material = material;
LIN_BEAM(config2).geom = geom;

LIN_BEAM(config2).nodes = tan_strap_nodes;
LIN_BEAM(config2).connect = tan_strap_connect;
LIN_BEAM(config2).ind = tan_strap_ind;




