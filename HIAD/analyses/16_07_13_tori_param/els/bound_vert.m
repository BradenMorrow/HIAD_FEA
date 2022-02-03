function [MODEL,EL] = bound_vert(theta,I_theta_cable,I_theta_support,tor)
% Generate properties and geometry of vertical boundary elements

%% GENERAL
k0 = 1; % Tension stiffness (lb/in) % 1e10; % 
k1 = 6000; % Compression stiffness (lb/in) % 1e10; % 
L = 10; % Length of element

% Response
r = 2;
[cable_f,cable_k] = lin_strap_response(k0,k1,.0001);

A = pi*r^2;
Izz = 0;
Iyy = 0;
J = 0;
E = k0*L/A;

tor_nodes = tor.nodes;


%% NODES
nodes = [tor_nodes(I_theta_support,1:2) -L*ones(size(I_theta_support))];


%% ORIENTATION
orientation = zeros(size(nodes));


%% CONNECTIVITIES
N = size(theta,1) + size(I_theta_cable,1)*4;
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
%     EL(i).el = @el1_nonlin; % Linear, corotational beam
    EL(i).el = 'el1_nonlin'; % Linear, corotational beam


    % Special element input
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
    
    % Axial response
    EL(i).el_in0.axial = cable_f;
    EL(i).el_in0.axial_k = cable_k;
end



end