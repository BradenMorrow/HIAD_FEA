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
r_strap = 24;
L_strap = mean(R) - r_strap; % Element length (in)

theta_strap = theta(J(n + 1:n + nP));
strap_x = r_strap*cos(theta_strap);
strap_x = [strap_x'; strap_x'];
strap_y = r_strap*sin(theta_strap);
strap_y = [strap_y'; strap_y'];
strap_z = r*ones(size(theta_link));
strap_z = [-strap_z'; strap_z'];

strap_nodes = [strap_x(:) strap_y(:) strap_z(:)];


%% Orientation nodes
strap_orientation = [zeros(size(strap_nodes,1),2) 1e6*ones(size(strap_nodes,1),1)];


%% Connectivities
strap_ind = (link_ind(end) + 1:link_ind(end) + size(strap_nodes,1))';
strap_connect = [strap_ind link_ind];


%% Boundaries
strap_fix = [zeros(size(strap_nodes,1),2) ones(size(strap_nodes,1),4)]; % Fix rotations at free end % zeros(size(strap_nodes,1),6); % 
strap_bound = strap_fix';
strap_bound = strap_bound(:);


%% Loading
% First step
strap_F1 = zeros(size(strap_bound));


% Second step - linear
P_pert = (P + P*0*cos(theta_strap*1)); % Perturb strap loads
% P_pert = (P + P*.00001*cos(theta_strap*2)); % Perturb strap loads
P_pert = [P_pert'; P_pert'];
P_pert = P_pert(:);

P_pert2 = [P_pert P_pert P_pert P_pert P_pert P_pert]';
% Pvec = P_pert2.*normr([(strap_nodes - link_nodes) zeros(size(strap_nodes))])'; % x, y, z components
Pvec = P_pert2.*normr([(strap_nodes(:,1:2) - link_nodes(:,1:2)) zeros(size(strap_nodes,1),4)])'; % x, y, components



strap_F2_linear = Pvec(:);


% Second step - linearize test
strap_F2 = zeros(size(P_strap,1)*6*2,2);
strap_F2(:,2) = strap_F2_linear;

% for  i = 1:size(strap_F2_linear,1)
%     strap_F2(i,:) = linspace(0,strap_F2_linear(i),size(strap_F2,2));
% end

% From test data
% strap_F2(:,2) = proc_tor_load_test_T5C1_23JUN15*react;



% For displacement control
% strap_F2 = zeros(size(strap_bound,1),2);
% strap_F2(7:end,:) = zeros(size(strap_F2(7:end,:)));

U0_strap1 = normc(Pvec)*D_disp;
U0_strap = U0_strap1(:);






%% Element type
% 1 = truss
% 2 = beam (Cook et al., 3D Beam Element)
% 3 = same as 2 without shear deformation
% 4 = Corotational formulation (Crisfield)
% 5 = Corotational formulation (Crisfield) with material nonlinearity
type = 4*ones(size(strap_connect,1),1);
config = 2*ones(size(strap_connect,1),1);
strap_connect = [strap_connect type config];


%% Materials and cross section
E = 1e6;
strap_material = [ones(size(strap_nodes,1),1) ones(size(strap_nodes,1),1)*E ones(size(strap_nodes,1),1)*.3];

A = k_ax_strap*L_strap/E;
I = k_b_strap*L_strap.^3/(12*E);
strap_geom = [A.*ones(size(strap_nodes,1),1) I.*ones(size(strap_nodes,1),2) ones(size(strap_nodes,1),1)*2 2*I.*ones(size(strap_nodes,1),1)];

% strap_ind = (tor_ind(end) + 1:tor_ind(end) + size(strap_nodes,1))';

material = zeros(N,3);
geom = zeros(N,5);

material(strap_ind,:) = strap_material;
geom(strap_ind,:) = strap_geom;

config2 = 2;
SPRING(config2).material = material;
SPRING(config2).geom = geom;

SPRING(config2).nodes = strap_nodes;
SPRING(config2).connect = strap_connect;
SPRING(config2).ind = strap_ind;




