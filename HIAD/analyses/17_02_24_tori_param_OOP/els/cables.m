function [MODEL,EL] = cables(theta,I_theta_cable,cable_pp)
% Generate properties and geometry of cable elements

%% GENERAL
% load('cable_stiff.mat')

E = 29e6;
r = 0; % .1;
A = pi*r^2;
Izz = pi/4*r^2; % w*t^3/12;
Iyy = pi/4*r^2; % w^3*t/12;
J = Izz + Iyy; % .312*w*t^3;


%% NODES
Rt = 16.85; % Radius to top pullies (in)
Rb = 24; % Radius to bottom pullies (in)
Pz = 14; % Distance between cables (in)

nodes = [Rb*cos(theta(I_theta_cable)) Rb*sin(theta(I_theta_cable)) -Pz/2*ones(size(I_theta_cable))
    Rt*cos(theta(I_theta_cable)) Rt*sin(theta(I_theta_cable)) Pz/2*ones(size(I_theta_cable))];


%% ORIENTATION
orientation = [zeros(size(nodes,1),2) 1e6*ones(size(nodes,1),1)];


%% CONNECTIVITIES
N = size(theta,1);
N0 = N + size(I_theta_cable,1)*1;
N1 = N + size(I_theta_cable,1)*2;
N2 = N + size(I_theta_cable,1)*3;
connect = [(N1 + 1:N1 + size(I_theta_cable,1))' (N + 1:N0)'
    (N2 + 1:N2 + size(I_theta_cable,1))' (N0 + 1:N1)'];
connect = [connect 4*ones(size(connect,1),1)];


%% Instantiate

%% BOUNDARIES
b = [zeros(size(nodes,1),3) ones(size(nodes,1),3)];
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
EL(size(connect,1)).el_in0.break = [];
EL(size(connect,1)).el_in0.mat = [];
EL(size(connect,1)).el_in0.geom = [];
EL = EL';

for i = 1:size(connect,1)
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    % Define element functions
    EL(i).el = 'el4'; % Linear, corotational beam

    % Special element input
    EL(i).el_in0.break = 0;
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
    
    % Axial response
    EL(i).el_in0.axial = cable_pp(i).d;
    EL(i).el_in0.axial_k = cable_pp(i).k;
end



end