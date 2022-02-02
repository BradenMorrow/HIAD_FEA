function [FEM,rebound,theta] = build_testing_links_straps(FEM,C,tor,straps,load,tori_theta,theta1,test_rad,test_z)
%% GENERAL
% Theta tolerance
tol = 1e-12;

% Properties for link elements
E = 10e6;
R = 1;
A = pi*R^2;
Izz = pi*R^4/4;
Iyy = pi*R^4/4;
J = pi*R^4/2;

% Instantiate
r = [tor.r]'; % Radius of tori

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


%% NODES
% % % Must modify code for configuration other than a perfect
% % %  circle
% Link Element Node Locations
x1 = C(1,1)*cos(theta);
y1 = C(1,1)*sin(theta);
z1 = C(1,2)*ones(size(theta))-tor(1).r;
nodes1 = [x1 y1 z1];
x2 = C(2,1)*cos(theta);
y2 = C(2,1)*sin(theta);
z2 = C(2,2)*ones(size(theta))+tor(1).r;
% Strap Element Node Locations
nodes2 = [x2 y2 z2];
x3 = test_rad*cos(theta);
y3 = test_rad*sin(theta);
z3 = test_z*ones(size(theta));
nodes3 = [x3 y3 z3];
tangent  = circle_tan([C(1,:) C(2,:)], [r(1) r(2)], 0); % Find tangent line beetween tori
x4 = tangent(1,1)*cos(theta);
y4 = tangent(1,1)*sin(theta);
z4 = tangent(1,2)*ones(size(theta));
nodes4 = [x4, y4, z4];
x5 = tangent(2,1)*cos(theta);
y5 = tangent(2,1)*sin(theta);
z5 = tangent(2,2)*ones(size(theta));
nodes5 = [x5, y5, z5];
x6 = test_rad*cos(theta)+4*cos(theta+(pi/2));
y6 = test_rad*sin(theta)+4*sin(theta+(pi/2));
z6 = test_z*ones(size(theta));
nodes6 = [x6 y6 z6];
x7 = test_rad*cos(theta)+4*cos(theta+((3*pi)/2));
y7 = test_rad*sin(theta)+4*sin(theta+((3*pi)/2));
z7 = test_z*ones(size(theta));
nodes7 = [x7 y7 z7];

nodes = [nodes1; nodes2; nodes3; nodes4; nodes5; nodes6; nodes7];

%% ORIENTATION
orientation = zeros(size(nodes,1),3);
orientation(:,3) = 1e6;

%% CONNECTIVITIES
% Links
connect_l1 = [tori_nodes(1:size(theta,1)) size(FEM.MODEL.nodes,1) + (1:(size(theta,1)))'];
connect_l2 = [size(tori_theta,1) + tori_nodes(1:size(theta,1)) size(FEM.MODEL.nodes,1) + size(theta,1) + (1:(size(theta,1)))'];
connect_l3 = [tori_nodes(1:size(theta,1)) size(FEM.MODEL.nodes,1) + size(theta,1)*3 + (1:(size(theta,1)))'];
connect_l4 = [size(tori_theta,1) + tori_nodes(1:size(theta,1)) size(FEM.MODEL.nodes,1) + size(theta,1)*4 + (1:(size(theta,1)))'];
connect_l = [connect_l1; connect_l2; connect_l3; connect_l4];
con_link = [connect_l 2*ones(size(connect_l,1),1)];
% Straps
connect_s1 = [size(FEM.MODEL.nodes,1) + (1:(size(theta,1)))' size(FEM.MODEL.nodes,1) + size(theta,1)*2 + (1:(size(theta,1)))'];
connect_s2 = [size(FEM.MODEL.nodes,1) + size(theta,1) + (1:(size(theta,1)))' size(FEM.MODEL.nodes,1) + size(theta,1)*2 + (1:(size(theta,1)))'];
connect_s3 = [size(FEM.MODEL.nodes,1) + size(theta,1)*3 + (1:(size(theta,1)))' size(FEM.MODEL.nodes,1) + size(theta,1)*4 + (1:(size(theta,1)))'];
connect_s = [connect_s1; connect_s2; connect_s3];
strap_link = [connect_s 3*ones(size(connect_s,1),1)];
% bench
connect_b1 = [size(FEM.MODEL.nodes,1) + size(theta,1)*2 + (1:(size(theta,1)))' size(FEM.MODEL.nodes,1) + size(theta,1)*5 + (1:(size(theta,1)))'];
connect_b2 = [size(FEM.MODEL.nodes,1) + size(theta,1)*2 + (1:(size(theta,1)))' size(FEM.MODEL.nodes,1) + size(theta,1)*6 + (1:(size(theta,1)))'];
connect_b = [connect_b1; connect_b2];
bound_link = [connect_b 4*ones(size(connect_b,1),1)];


%% ELEMENTS
% Preallocate element structure
EL = [];
EL(size(con_link,1)+size(strap_link,1)).el = [];
EL(size(con_link,1)+size(strap_link,1)).el_in = [];
EL(size(con_link,1)+size(strap_link,1)).el_in0.break = [];
EL(size(con_link,1)+size(strap_link,1)).el_in0.mat = [];
EL(size(con_link,1)+size(strap_link,1)).el_in0.geom = [];
EL = EL';

% Links
for i = 1:size(con_link,1)
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el2'; % Linear, corotational beam

    % Special element input
    EL(i).el_in0.break = 0;
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
end

% Straps
strap_type = 2;
for i = size(con_link,1):size(con_link,1)+size(strap_link,1)
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el4'; 
    
    % Corotational beam with axial lookup table
    EL(i).el_in0.break = 0;
    EL(i).el_in0.mat = straps(strap_type).mat; % [E nu]
    EL(i).el_in0.geom = straps(strap_type).geom; % [A Izz Iyy ky J]
    EL(i).el_in0.axial = straps(strap_type).axial;
    EL(i).el_in0.axial_k = straps(strap_type).axial_k;
    EL(i).el_in0.eps0 = straps(strap_type).eps0;
end

% Bench
for j = size(con_link,1)+size(strap_link,1):size(con_link,1)+size(strap_link,1)+size(bound_link,1)
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
FEM.MODEL.nodes = [FEM.MODEL.nodes; nodes(:,1:3)];
FEM.MODEL.connect = [FEM.MODEL.connect; [con_link;strap_link;bound_link]];
FEM.MODEL.orientation = zeros(size(FEM.MODEL.connect,1),3);
FEM.MODEL.orientation(:,3) = 1e6;

%% Boundary 
b1 = zeros(size(theta,1)*5,6);
b2 = ones(size(theta,1)*2,6);
b = [b1; b2;];
b = b';
bound = b(:);
rebound(1,:) = [(size(FEM.MODEL.B,1)/6 + size(theta,1)*4) (size(FEM.MODEL.B,1)/6 + size(theta,1)*6)];
FEM.MODEL.B = [FEM.MODEL.B; bound];

%% Loading
f1 = zeros(size(theta,1)*2,6);
f2 = (-load)*[cos(theta) sin(theta)];
f5 = zeros(size(theta,1),4);
f6 = [f2 f5];
f7 = zeros(size(theta,1)*4,6);
f = [f1;f6;f7];
f = f';
F = f(:);

FEM.MODEL.F = [FEM.MODEL.F; F];

%% U Vector Displacements
u = zeros(size(FEM.MODEL.nodes,1),6);
u = u';
U = u(:);

FEM.MODEL.U_pt = [U];


%% Set forces
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F*0 FEM.MODEL.F];

