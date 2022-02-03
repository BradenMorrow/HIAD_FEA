% Pre-process the torus object
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
% Nodal location, (nodes to obtain required number of elements and nodes
% for loading)
theta1 = linspace(0,pi/2,n)';

% strap0 = pi/2 - 5.63*pi/180; % Location of first strap
strap0 = 0;

% theta_strap = strap0 - linspace(0,2*pi - 2*pi/nP,nP)';
theta_strap = linspace(0,pi/2,nP)';
% theta_strap(theta_strap < 0) = theta_strap(theta_strap < 0) + 2*pi;

% theta_support = [pi/2 pi 3*pi/2]';
ind = [theta1; theta_strap]; % [torus straps supports]
[theta,~,J] = unique(ind);

% Perfect geometry
theta_ip = nip*theta; % linspace(0,nip*2*pi,length(theta))';
theta_op = nop*theta; % linspace(0,nop*2*pi,length(theta))';

a = R + delta_a; % x radius
b = R + delta_b; % y radius

% Major diameter, (incorporate geometric imperfections)
x = a*cos(theta) + Aip*cos(theta_ip);
y = b*sin(theta) + Aip*sin(theta_ip);
z = Aop*sin(theta_op);

tor_nodes = [x y z];


% Total number of nodes
N = size(tor_nodes,1);

%% Orientation nodes
tor_orientation = tor_nodes;
tor_orientation(:,3) = tor_nodes(:,3) + 1;


%% Connectivities
tor_connect = [(1:size(x,1) - 1)' (2:size(x,1))'];


%% Boundaries
% 1 = fixed
% 0 = free
fix = zeros(size(tor_nodes,1),6);

% For initial displacement analysis
% % % str_ind = J(size(theta1,1) + 1:size(theta1,1) + 1 + size(theta_strap,1));
fix(1,[2 3 4 5 6]) = 1;
fix(end,[1 3 4 5 6]) = 1;
fix(:,[3 4 5]) = 1;

tor_bound = fix';
tor_bound = tor_bound(:);



%% Loading
% % % tor_F1 = 0*tor_bound;
P_vec = -[cos(theta) sin(theta) zeros(size(sin(theta),1),4)];
P_mag = P*(1 + e*cos(2*theta));

P_vec(:,1) = P_vec(:,1).*P_mag;
P_vec(:,2) = P_vec(:,2).*P_mag;

P_vec(1,:) = P_vec(1,:)/2;
P_vec(end,:) = P_vec(end,:)/2;

tor_F2 = P_vec';
tor_F2 = tor_F2(:);
tor_F2 = [zeros(size(tor_F2)) tor_F2];


%% ELEMENTS
type = 4*ones(size(tor_connect,1),1);
tor_connect = [tor_connect type];

% Materials
E = 2.1e7;
A = 20;
I = 1.666667;

% Preallocate element structure
EL(n - 1).el = [];
EL(n - 1).el_in.nodes_ij = [];
EL(n - 1).el_in.orient_ij = [];
EL(n - 1).el_in.connect_ij = [];
EL(n - 1).el_in0.mat = [];
EL(n - 1).el_in0.geom = [];
EL = EL';

for i = 1:n - 1
    % Define element functions
    EL(i).el = @el2; % Linear, corotational beam
    
    % Element geometry
    EL(i).el_in.nodes_ij = [tor_nodes(tor_connect(i,1),:)
        tor_nodes(tor_connect(i,2),:)];
    EL(i).el_in.orient_ij = [tor_orientation(tor_connect(i,1),:)
        tor_orientation(tor_connect(i,2),:)];
    EL(i).el_in.connect_ij = tor_connect(i,1:2);
    
    % Special element input
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A I I 0 2*I]; % [A Izz Iyy ky J]
    EL(i).el_in0.L0 = sqrt((EL(i).el_in.nodes_ij(2,1) - EL(i).el_in.nodes_ij(1,1))^2 + ...
            (EL(i).el_in.nodes_ij(2,2) - EL(i).el_in.nodes_ij(1,2))^2 + ...
            (EL(i).el_in.nodes_ij(2,3) - EL(i).el_in.nodes_ij(1,3))^2);
end






