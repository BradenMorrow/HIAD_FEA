function [MODEL,EL] = int4(theta,C)
% Generate properties and geometry for interaction element set 1

%% GENERAL
% Properties
k_ax = 34.7; % lbf/in/in
K_ax = k_ax*2*pi*C(1)/size(theta,1); % lbf/in

% EIzz = 4000*(2*15.919)^3/3;
k = 4.6024;
EIzz = (2*15.919)^3/3*k;

tw = 2*pi*C(1)/size(theta,1);
EIzzi = EIzz*tw;

E = 10e6;
A = K_ax/E;
Izz = EIzzi/E; % pi/4*.5^4;
Iyy = pi/4*2^4;
J = 1;


%% NODES
nodes = [];


%% ORIENTATION
orientation = zeros(size(theta,1),3);
orientation(:,3) = 200;


%% CONNECTIVITIES
N = size(theta,1)*2;
connect = [(1:size(theta,1))' (1:size(theta,1))' + size(theta,1)];
connect = connect + N;
connect = [connect 2*ones(size(connect,1),1)];


%% BOUNDARIES
b = zeros(size(nodes,1),6);
b = b';
bound = b(:);


%% LOADING
f = zeros(size(nodes,1),6);
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

