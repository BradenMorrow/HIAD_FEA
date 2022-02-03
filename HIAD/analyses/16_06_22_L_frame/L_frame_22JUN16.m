% Model for testing arc-length solver
clear
warning('on','all')

%%
% Load parameters
% Loading
P1 = 1.6;
P2 = 2e-4;

%% NODES
n1 = 5; % Elements per leg
n = n1*2; % Number of elements
L = 240; % Length of leg
x1 = linspace(0,L,n1 + 1)';
x2 = 240*ones(n1,1);
x = [x1; x2];

y1 = x2;
y2 = x1(end:-1:1);
y = [y1; y2];

z = zeros(size(x));

nodes = [x y z];

%% ORIENT
orientation = nodes;
orientation(:,3) = 1;

%% CONNECT
connect = [(1:size(nodes,1) - 1)' (2:size(nodes,1))' 2*ones(size(nodes,1) - 1,1)];

%% BOUND
fix = zeros(size(x,1),6);
fix(1,:) = 1;
bound = fix';
bound = bound(:);

%% LOAD
force = fix*0;
% force(end,1) = react*cosd(45);
% force(end,2) = react*sind(45);
force(end,[1 3]) = [P1 P2];
F = force';
F = F(:);

U0 = F*0;

%% ELEMENTS
E = 71240;
nu = .31;
b = .6;
h = 30;
A = b*h; % Area (in^2)
Izz = h*b^3/12; % Moment of inertia (in^4)
Iyy = b*h^3/12; % Moment of inertia (in^4)
J = 30*.6^3*.333;

% Preallocate element structure
EL(n - 1).el = [];
EL(n - 1).el_in.nodes_ij = [];
EL(n - 1).el_in.orient_ij = [];
EL(n - 1).el_in.connect_ij = [];
EL(n - 1).el_in0.mat = [];
EL(n - 1).el_in0.geom = [];
EL = EL';

for i = 1:n
    % Define element functions
    EL(i).el = @el2; % Linear, corotational beam
    
    % Element geometry
    EL(i).el_in.nodes_ij = [nodes(connect(i,1),:)
        nodes(connect(i,2),:)];
    EL(i).el_in.orient_ij = [orientation(connect(i,1),:)
        orientation(connect(i,2),:)];
    
    % Special element input
    EL(i).el_in0.mat = [E nu]; % [type E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
end


FEM.EL = EL;

FEM.MODEL.nodes = nodes;
FEM.MODEL.connect = connect;
FEM.MODEL.orientation = orientation;
FEM.MODEL.B = bound;
FEM.MODEL.F = F;
FEM.MODEL.F_pt = [F*0 F];

FEM.MODEL.F_pre = F*0;
FEM.MODEL.Dinc = 0;
FEM.MODEL.D = -1;
FEM.MODEL.Di = n*6 - 4;

FEM.PASS.Fext = F*0;



% FE controls
[FEM.ANALYSIS] = FE_controls;
[FEM.PLOT] = plot_controls;


FE_plot(FEM)

[FEM_out] = increment_FE(FEM);




%FE_plot(FEM_out)
L_plot(FEM_out)













