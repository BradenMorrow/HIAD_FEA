% Cantelever cylindrical steel beam under end load.  Can be used for
% testing displacement solver, newton solver, and arc length solver.
clear

%%
% Load parameters
% Loading and elements
n = 10; % Number of nodes
load = 132000; %End of beam reation

% Geometry
L = 1; % Length

%% NODES
x = linspace(0,L,n)';
y = 0*x;
z = 0*x;

nodes = [x y z];

%% ORIENT
orientation = nodes;
orientation(:,2) = orientation(:,2) + 1;

%% CONNECT
connect = [(1:n - 1)' (2:n)' 2*ones(size(nodes,1) - 1,1)];

%% BOUND
fix = zeros(size(x,1),6);
fix(1,:) = 1;
bound = fix';
bound = bound(:);

%% LOAD
force = fix*0;
force(end,2) = -load;
F = force';
F = F(:);

%% ELEMENTS
E = 2.1e11;
A = .002/10;
I = 1.666667e-8;

% Preallocate element structure
EL(n - 1).el = [];
EL(n - 1).el_in.nodes_ij = [];
EL(n - 1).el_in.orient_ij = [];
EL(n - 1).el_in0.break = [];
EL(n - 1).el_in0.mat = [];
EL(n - 1).el_in0.geom = [];
EL = EL';

for i = 1:n - 1
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el2'; % Linear, corotational beam
    
    % Special element input
    EL(i).el_in0.break = 0;
    EL(i).el_in0.mat = [E .3]; % [type E nu]
    EL(i).el_in0.geom = [A I I 0 2*I]; % [A Izz Iyy ky J]
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
FEM.MODEL.Di = n*6 -4; % The dof that will be used for the b matrix in displacement solver
FEM.PASS.Fext = F*0;



% FE controls
[FEM.ANALYSIS] = FE_controls_cant_beam;
[FEM.PLOT] = plot_controls_cant_beam;


[FEM_out] = increment_FE(FEM);

% cant_def(FEM_out)













