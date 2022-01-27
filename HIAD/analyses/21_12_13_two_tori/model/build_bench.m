function [FEM] = build_bench(FEM,C,tor,tori_theta,theta1,K_shear)

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


%% Create interaction elements
r1 = tor(1).r;

K_ax = 1; % Distribute to each node (assumes uniform nodal distribution) lbf/strain

% Determine geometric properties
E = 10e6; % Arbitralily fixed
A = K_ax/E;
Izz = K_shear*r1^3/(3*E);
Iyy = pi/4*2^4;
J = 1;


%% NODES
% % % Must modify code for configuration other than a perfect
% % %  circle
x1 = C(2,1)*cos(theta);
y1 = C(2,1)*sin(theta);
z1 = C(2,2)*ones(size(theta))+tor(1).r;
nodes1 = [x1 y1 z1];

x2 = C(2,1)*cos(theta)+tor(1).r*cos(theta-(pi/4));
y2 = C(2,1)*sin(theta)+tor(1).r*sin(theta-(pi/4));
z2 = C(2,2)*ones(size(theta));
nodes2 = [x2 y2 z2];

x3 = C(2,1)*cos(theta)+tor(1).r*cos(theta+(pi/4));
y3 = C(2,1)*sin(theta)+tor(1).r*sin(theta+(pi/4));
z3 = C(2,2)*ones(size(theta));
nodes3 = [x3 y3 z3];

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
for j = 1:size(connect,1)
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
