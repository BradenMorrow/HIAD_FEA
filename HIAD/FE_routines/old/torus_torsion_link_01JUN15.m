% Pre-process the rigid links connecting upper and lower loading straps
% Andy Young
% June 01, 2015
%
% Preprocess the:
%   Location of nodes
%   Element connectivities
%   Element orientations
%   Boundary conditions
%   Force vector

%% Nodes
L_link = r; % Element length (in)

theta_link = theta(J(n + 1:n + nP));
tor_link_ind = J(n + 1:n + nP); % Indices of loaded torus nodes
tor_link_nodes = tor_nodes(tor_link_ind,:); % Nodes on torus
tor_link_ind2 = [tor_link_ind'; tor_link_ind'];

tor_orig = normr(-tor_link_nodes); % Vector from loading node to origin
tor_local = normr(tor_nodes(tor_connect(tor_link_ind,2),:) - tor_nodes(tor_link_ind,:)); % Vector from loading node along torus

% % % % Rotate links
% % % tor_link = r*normr(cross(tor_local,tor_orig,2)); % Vectors from torus to end of link
% % % tor_link_down = tor_link_nodes - tor_link;
% % % tor_link_up = tor_link_nodes + tor_link;
% % % 
% % % link_x = [tor_link_down(:,1)'; tor_link_up(:,1)']; % Link nodes
% % % link_y = [tor_link_down(:,2)'; tor_link_up(:,2)'];
% % % link_z = [tor_link_down(:,3)'; tor_link_up(:,3)'];

% Vertical links
link_x = x(tor_link_ind2);
link_y = y(tor_link_ind2);
link_z = z(tor_link_ind2);
link_z = link_z + [-L_link*ones(1,size(link_z,2)); L_link*ones(1,size(link_z,2))];

link_nodes = [link_x(:) link_y(:) link_z(:)];


%% Orientation nodes
link_orientation = zeros(size(link_nodes));


%% Connectivities
tor_link_ind2 = tor_link_ind2(:);
link_ind = (tor_ind(end) + 1:tor_ind(end) + size(link_nodes,1))';
link_connect = [link_ind tor_link_ind2];


%% Boundaries
link_fix = zeros(size(link_nodes,1),6);
link_bound = link_fix';
link_bound = link_bound(:);


%% Loading
% First step
link_F1 = zeros(size(link_bound));

% Second step - linear
link_F2 = [link_F1 link_F1];


%% Element type
% 1 = truss
% 2 = beam (Cook et al., 3D Beam Element)
% 3 = same as 2 without shear deformation
% 4 = Corotational formulation (Crisfield)
% 5 = Corotational formulation (Crisfield) with material nonlinearity
type = 4*ones(size(link_connect,1),1);
config = 1*ones(size(link_connect,1),1);
link_connect = [link_connect type config];


% Materials and cross section
E = 1e6;
link_material = [ones(size(link_nodes,1),1) ones(size(link_nodes,1),1)*E ones(size(link_nodes,1),1)*.3];

A = k_ax_link*L_link/E;
I = k_b_link*L_link^3/(12*E);
link_geom = [A*ones(size(link_nodes,1),1) I*ones(size(link_nodes,1),2) ones(size(link_nodes,1),1)*2 2*I*ones(size(link_nodes,1),1)];

material = zeros(N,3);
geom = zeros(N,5);

material(link_ind,:) = link_material;
geom(link_ind,:) = link_geom;

config2 = 1;
SPRING(config2).material = material;
SPRING(config2).geom = geom;

SPRING(config2).nodes = link_nodes;
SPRING(config2).connect = link_connect;
SPRING(config2).ind = link_ind;



