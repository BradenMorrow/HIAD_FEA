function [MODEL,EL] = bound_rad(theta,I_theta_cable,I_theta_support,tor)
% Generate properties and geometry of radial boundary elements

%% GENERAL
L = 10; % Length of element (in)

% Properties
k = 1; % Stiffness (lb/in) % 1e10; % 
r = 1;

A = pi*r^2;
Izz = 0;
Iyy = 0;
J = 0;
E = k*L/A;

tor_nodes = tor.nodes(I_theta_support,:);


%% NODES
nodes = tor_nodes + [L.*cos(theta(I_theta_support)) L.*sin(theta(I_theta_support)) tor_nodes(:,3)*0];


%% ORIENTATION
orientation = ones(size(nodes))*1e6;


%% CONNECTIVITIES
N = size(theta,1) + size(I_theta_cable,1)*4 + size(I_theta_support,1)*2;
connect = [(N + 1:N + size(I_theta_support,1))' I_theta_support];
connect = [connect 1*ones(size(connect,1),1)];


%% BOUNDARIES
b = ones(size(nodes,1),6);
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
EL(size(connect,1)).el_in0.mat = [];
EL(size(connect,1)).el_in0.geom = [];
EL = EL';

for i = 1:size(connect,1)
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
%     EL(i).el = @el1; % Linear, corotational beam
    EL(i).el = 'el1'; % Linear, corotational beam


    % Special element input
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
end



end