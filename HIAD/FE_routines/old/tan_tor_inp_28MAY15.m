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
% n_norm - node normal;
L = 10; % Element length (in)

support_nodes = tor_nodes(abs(tor_nodes(:,1)) < 1e-10 | abs(tor_nodes(:,2)) < 1e-10,:);
n_norm = normr(support_nodes);
tan_tor_nodes = support_nodes + L*[-n_norm(:,2) n_norm(:,1) zeros(size(support_nodes,1),1)];


%% Orientation nodes
tan_tor_orientation = [zeros(size(tan_tor_nodes,1),2) 1e6*ones(size(tan_tor_nodes,1),1)];


%% Connectivities
% strap_ind = J(n + 1:end);
tan_tor_ind = (tor_ind(end) + 1:tor_ind(end) + size(tan_tor_nodes,1))';
support_ind = tor_ind(abs(tor_nodes(:,1)) < 1e-10 | abs(tor_nodes(:,2)) < 1e-10,:);
tan_tor_connect = [tan_tor_ind support_ind];


%% Boundaries
tan_tor_fix = ones(size(tan_tor_nodes,1),6);
tan_tor_bound = tan_tor_fix';
tan_tor_bound = tan_tor_bound(:);

%% Loading
tan_tor_F1 = zeros(size(tan_tor_bound,1),1);
% tan_tor_F2 = zeros(size(tan_tor_bound,1),1);
tan_tor_F2 = zeros(size(tan_tor_bound,1),2);


%% Element type
% 1 = truss
% 2 = beam (Cook et al., 3D Beam Element)
% 3 = same as 2 without shear deformation
% 4 = Corotational formulation (Crisfield)
% 5 = Corotational formulation (Crisfield) with material nonlinearity
type = 3*ones(size(tan_tor_connect,1),1);
config = 2*ones(size(tan_tor_connect,1),1);
tan_tor_connect = [tan_tor_connect type config];


%% Materials and cross section
E = 1e6;
tan_tor_material = [ones(size(tan_tor_nodes,1),1) ones(size(tan_tor_nodes,1),1)*E ones(size(tan_tor_nodes,1),1)*.3];

A = k_ax_tan_tor*L/E;
I = k_b_tan_tor*L^3/(12*E);
tan_tor_geom = [A*ones(size(tan_tor_nodes,1),1) I*ones(size(tan_tor_nodes,1),2) ones(size(tan_tor_nodes,1),1)*2 2*I*ones(size(tan_tor_nodes,1),1)];

material = zeros(N,3);
geom = zeros(N,5);

material(tan_tor_ind,:) = tan_tor_material;
geom(tan_tor_ind,:) = tan_tor_geom;

config2 = 1;
LIN_BEAM(config2).material = material;
LIN_BEAM(config2).geom = geom;

LIN_BEAM(config2).nodes = tan_tor_nodes;
LIN_BEAM(config2).connect = tan_tor_connect;
LIN_BEAM(config2).ind = tan_tor_ind;





