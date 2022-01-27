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
% % % vert_tor_nodes = tor_nodes;
% % % vert_tor_nodes(:,3) = vert_tor_nodes(:,3) - L;
% % % 
vert_tor_nodes = tor_nodes(abs(tor_nodes(:,1)) < 1e-10 | abs(tor_nodes(:,2)) < 1e-10,:);
vert_tor_nodes(:,3) = vert_tor_nodes(:,3) - L;
vert_ind = tor_ind(abs(tor_nodes(:,1)) < 1e-10 | abs(tor_nodes(:,2)) < 1e-10,:);




%% Orientation nodes
vert_tor_orientation = zeros(size(vert_tor_nodes,1),3);


%% Connectivities
% strap_ind = J(n + 1:end);
vert_tor_ind = (tan_tor_ind(end) + 1:tan_tor_ind(end) + size(vert_tor_nodes,1))';
vert_tor_connect = [vert_tor_ind vert_ind];


%% Boundaries
vert_tor_fix = ones(size(vert_tor_nodes,1),6);
vert_tor_bound = vert_tor_fix';
vert_tor_bound = vert_tor_bound(:);

%% Loading
vert_tor_F1 = zeros(size(vert_tor_bound,1),1);
% vert_tor_F2 = zeros(size(vert_tor_bound,1),1);
vert_tor_F2 = zeros(size(vert_tor_bound,1),2);


%% Element type
% 1 = truss
% 2 = beam (Cook et al., 3D Beam Element)
% 3 = same as 2 without shear deformation
% 4 = Corotational formulation (Crisfield)
% 5 = Corotational formulation (Crisfield) with material nonlinearity
type = 3*ones(size(vert_tor_connect,1),1);
config = 3*ones(size(vert_tor_connect,1),1);
vert_tor_connect = [vert_tor_connect type config];


%% Materials and cross section
E = 1e6;
vert_material = [ones(size(vert_tor_nodes,1),1) ones(size(vert_tor_nodes,1),1)*E ones(size(vert_tor_nodes,1),1)*.3];

% Compression properties
A1 = k_ax_vert_tor_comp*L/E;
I1 = k_b_vert_tor_comp*L^3/(12*E);
vert_geom1 = [A1*ones(size(vert_tor_nodes,1),1) I1*ones(size(vert_tor_nodes,1),2) ones(size(vert_tor_nodes,1),1)*2 2*I1*ones(size(vert_tor_nodes,1),1)];

% Tension properties
A2 = k_ax_vert_tor_ten*L/E;
I2 = k_b_vert_tor_ten*L^3/(12*E);
vert_geom2 = [A2*ones(size(vert_tor_nodes,1),1) I2*ones(size(vert_tor_nodes,1),2) ones(size(vert_tor_nodes,1),1)*2 2*I2*ones(size(vert_tor_nodes,1),1)];

eps0 = 0; % Location of change in stiffness

%%%
material = zeros(N,3);
geom1 = zeros(N,5);
geom2 = zeros(N,5);

material(vert_tor_ind,:) = vert_material;
geom1(vert_tor_ind,:) = vert_geom1;
geom2(vert_tor_ind,:) = vert_geom2;

config2 = 2;
LIN_BEAM(config2).material = material;
LIN_BEAM(config2).geom.geom1 = geom1;
LIN_BEAM(config2).geom.geom2 = geom2;
LIN_BEAM(config2).geom.eps0 = eps0;
LIN_BEAM(config2).geom.bilinear_flag = 1;


LIN_BEAM(config2).nodes = vert_tor_nodes;
LIN_BEAM(config2).connect = vert_tor_connect;
LIN_BEAM(config2).ind = vert_tor_ind;





