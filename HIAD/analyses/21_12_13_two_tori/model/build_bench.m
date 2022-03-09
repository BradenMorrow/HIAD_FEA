function [FEM] = build_bench(FEM,tor,tori_theta,theta1,K_shear)

% Combine theta locations
theta1(theta1 >= 2*pi) = theta1(theta1 >= 2*pi) - 2*pi;
theta1(theta1 < 0) = theta1(theta1 < 0) + 2*pi;

% Sort theta vector
theta = unique(theta1);

for i = 1:size(theta)
    for j = 1:size(tori_theta)
        if round(theta(i),3) == round(tori_theta(j),3)
            tori_nodes(i) = j;
        end
    end
end
tori_nodes = tori_nodes';

%% Preallocate and declare variables
EL(size(theta,1)).el = [];
EL(size(theta,1)).el_in = [];
EL(size(theta,1)).el_in0.mat = [];
EL(size(theta,1)).el_in0.geom = [];
EL = EL';


%% Create Bench Elements
r1 = tor(1).r;

K_ax = 1; % Distribute to each node (assumes uniform nodal distribution) lbf/strain

% Determine geometric properties
E = 100; % Arbitralily fixed
A = K_ax/E;
Izz = K_shear*r1^3/(3*E);
Iyy = pi/4*2^4;
J = 1;
[axial,axial_k] = strap_response(100,5.6941e+06,0,0.0001,0.0001);


%% NODES
for i = 1:size(tori_nodes)
    x1 = FEM.MODEL.nodes((length(tori_theta)+tori_nodes(i)),1);
    y1 = FEM.MODEL.nodes((length(tori_theta)+tori_nodes(i)),2);
    z1 = FEM.MODEL.nodes((length(tori_theta)+tori_nodes(i)),3)-tor(1).r;
    nodes1(i,:) = [x1 y1 z1];
    
    x2 = FEM.MODEL.nodes((length(tori_theta)+tori_nodes(i)),1)+tor(1).r*cos(theta(i));
    y2 = FEM.MODEL.nodes((length(tori_theta)+tori_nodes(i)),2)+tor(1).r*sin(theta(i));
    z2 = FEM.MODEL.nodes((length(tori_theta)+tori_nodes(i)),3);
    nodes2(i,:) = [x2 y2 z2];
    
    x3 = FEM.MODEL.nodes((length(tori_theta)+tori_nodes(i)),1)+tor(1).r*cos(theta(i)+(pi/2));
    y3 = FEM.MODEL.nodes((length(tori_theta)+tori_nodes(i)),2)+tor(1).r*sin(theta(i)+(pi/2));
    z3 = FEM.MODEL.nodes((length(tori_theta)+tori_nodes(i)),3);
    nodes3(i,:) = [x3 y3 z3];
end

nodes = [nodes1; nodes2; nodes3];

%% ORIENTATION
orientation = zeros(size(nodes,1),3);
orientation(:,3) = 1e6;


%% CONNECTIVITIES
connect_i = [size(tori_theta,1) + tori_nodes(1:size(theta,1)) size(FEM.MODEL.nodes,1) + (1:(size(theta,1)))'];
connect_j = [size(tori_theta,1) +  tori_nodes(1:size(theta,1)) size(FEM.MODEL.nodes,1) + size(theta,1) + (1:(size(theta,1)))'];
connect_g =[size(tori_theta,1) + tori_nodes(1:size(theta,1))  size(FEM.MODEL.nodes,1) + size(theta,1)*2 + (1:(size(theta,1)))'];
connect_all = [connect_i; connect_j; connect_g];
connect = [connect_all 4*ones(size(connect_all,1),1)];


%% BOUNDARIES
b = ones(size(theta,1)*3,6);
b = b';
bound = b(:);


%% Loading
F = zeros(size(bound));


%% U vector
u = zeros(size(nodes,1),6);
u = u';
U = u(:);
FEM.MODEL.U_pt = [FEM.MODEL.U_pt; U];


%% ELEMENTS
for j = 1:size(connect_i,1)
    EL(j).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(j).el = 'el4'; % Linear, corotational beam
    
    % Special element input
    EL(j).el_in0.break = 0;
    EL(j).el_in0.mat = [E .3]; % [E nu]
    EL(j).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
    EL(j).el_in0.axial = axial;
    EL(j).el_in0.axial_k = axial_k;
    % Element prestrain
    EL(j).el_in0.eps0 = 0;
end

for j = size(connect_i,1)+1:size(connect_all,1)
    EL(j).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(j).el = 'el2'; % Linear, corotational beam
    
    % Special element input
    EL(j).el_in0.break = 0;
    EL(j).el_in0.mat = [E .3]; % [E nu]
    EL(j).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
    
    % Element prestrain
    EL(j).el_in0.eps0 = 0;
end


%% MODEL
FEM.EL = [FEM.EL; EL];
FEM.MODEL.nodes = [FEM.MODEL.nodes; nodes];
FEM.MODEL.orientation = [FEM.MODEL.orientation; orientation];
FEM.MODEL.connect = [FEM.MODEL.connect; connect];
FEM.MODEL.B = [FEM.MODEL.B; bound];


%% Set forces
FEM.MODEL.F = [FEM.MODEL.F; F];


end
