function [FEM, fix] = torus_inp_calc_K_shear(n, I, A, inflation_P, load_width, r)

% Pre-process the torus object
%
% Preprocess the:
%   Location of nodes
%   Element connectivities
%   Element orientations
%   Boundary conditions
%   Force vector

%% Nodes
% Nodal location, (nodes to obtain required number of elements and nodes
% for loading)
theta = linspace(0,pi,n)'; % Nodes distributed over a quarter circumference

x = r*cos(theta); % Nodal x location
y = r*sin(theta); % Nodal y location
z = 0*x; % Nodal z location
nodes = [x y z];

%% Orientation nodes
orientation = nodes;
orientation(:,3) = nodes(:,3) + 1;


%% Connectivities
connect = [(1:size(x,1) - 1)' (2:size(x,1))'];


%% Boundaries
% 1 = fixed
% 0 = free
m_node = floor(n/2)+rem(n,2);
fix = zeros(size(nodes,1),6);

% For quarter symmetry
fix(1,[1 2 3]) = 1;
fix(end,[1 2 3]) = 1;
fix(:,[3 4 5]) = 1;
fix(m_node, 6) = 0;

bound = fix';
bound = bound(:);

%% Inflation pressure
P_vec = [cos(theta) sin(theta) zeros(n,4)]; % Unit inflation pressure vector
arc_length = pi*r/(n - 1); % Calculate arc length between elements
P_mag = inflation_P*arc_length; % Magnitude of force on one point
P_vec  = P_vec*P_mag; % Scale directional P_vec by magnitude of pressure at a point
P_vec(1,:) = P_vec(1,:)/2; % Quarter symetry so divide by 2
P_vec(end,:) = P_vec(end,:)/2; 

inflation_F = P_vec';
inflation_F = inflation_F(:);

%% For Loading
n_loaded = floor((load_width/2)/arc_length); % Number of nodes loaded
n_loaded_num = (n-n_loaded):n; % Location of loaded nodes

%% ELEMENTS
type = 4*ones(size(connect,1),1);
connect = [connect type];

% Materials
E = 1e6;

% Preallocate element structure
EL(n - 1).el = [];
EL(n - 1).el_in.nodes_ij = [];
EL(n - 1).el_in.orient_ij = [];
EL(n - 1).el_in0.mat = [];
EL(n - 1).el_in0.geom = [];
EL = EL';

for i = 1:n - 1
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el2'; % Linear, corotational beam
    
    % Special element input
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A I I 0 0]; % [A Izz Iyy ky J]
end


% Compile element types
FEM.MODEL.n_loaded = n_loaded_num;
FEM.EL = EL;
FEM.MODEL.nodes = nodes;
FEM.MODEL.connect = connect;
FEM.MODEL.orientation = orientation;
FEM.MODEL.B = bound;
FEM.MODEL.F = inflation_F;
FEM.MODEL.F_pt = [inflation_F*0 inflation_F];

FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.Dinc = 0;
FEM.MODEL.D = -1;
FEM.MODEL.Di = 1;





