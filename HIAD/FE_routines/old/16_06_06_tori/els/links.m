function [MODEL,EL] = links(theta,I_theta_cable,tor)
% Generate properties and geometry of link elements

%% GENERAL
% Properties
E = 10e6;
R = 2;
A = pi*R^2;
Izz = pi*R^4/4;
Iyy = pi*R^4/4;
J = pi*R^4/2;

tor_nodes = tor.nodes; % Torus nodal locations
r = tor.r; % Minor radius (in)


%% NODES
nodes = [tor_nodes(I_theta_cable,1:2) -r*ones(size(I_theta_cable))
    tor_nodes(I_theta_cable,1:2) r*ones(size(I_theta_cable))];


%% ORIENTATION
orientation = zeros(size(nodes));


%% CONNECTIVITIES
N = size(theta,1);
connect = [(N + 1:N + size(I_theta_cable))' I_theta_cable
    (N + 1:N + size(I_theta_cable))' + size(I_theta_cable,1) I_theta_cable];
connect = [connect 2*ones(size(connect,1),1)];


%% BOUNDARIES
b = zeros(size(nodes,1),6);
b = b';
bound = b(:);


%% LOADING
f = zeros(size(nodes,1),6);
f = f';
F = f(:);


%% MODEL
MODEL.nodes = nodes;
MODEL.orientation = orientation;
MODEL.connect = connect;
MODEL.bound = bound;
MODEL.F = F;


%% ELEMENTS
% Preallocate element structure
EL(size(connect,1)).el = [];
EL(size(connect,1)).el_in.nodes_ij = [];
EL(size(connect,1)).el_in.orient_ij = [];
EL(size(connect,1)).el_in.connect_ij = [];
EL(size(connect,1)).el_in0.mat = [];
EL(size(connect,1)).el_in0.geom = [];
EL = EL';

for i = 1:size(connect,1)
    % Define element functions
    EL(i).el = @el2; % Linear, corotational beam

    % Element geometry
    EL(i).el_in.connect_ij = connect(i,1:2);

    % Special element input
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
end



end