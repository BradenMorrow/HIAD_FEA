% Cantelever rectangular steel beam with a displaced spring at the end.
% Used for testing enforce displacement solver

clear

%%
% Load parameters
% Loading and elements
n_beam = 10; % Number of nodes of beam
n = n_beam + 1; % Number of nodes
load = .05e6; %End of beam reation

% Geometry
L_beam = 500; % Length of beam
L_spring = 10000; % Length of spring
A_spring = 1; % Area of spring
b = 15; % Width of the beam
h = 15; % Height of the beam

%% NODES
x_beam = linspace(0,L_beam,n_beam)'; % Beam nodes
x = [x_beam; L_beam]; % Add spring

y_beam = 0*x_beam; % Beam nodes
y = [y_beam; -L_spring]; % Add spring

z = 0*x;

nodes = [x y z];

%% ORIENT
orientation = nodes;
orientation(:,3) = orientation(:,3) + 1;

%% CONNECT
connect = [(1:n - 1)' (2:n)' 2*ones(n - 1,1)];

%% BOUND
fix = zeros(size(x,1),6);
fix(1,:) = 1;
fix(n,:) = 1; % Set boundaries on the displacement and rotational dof of the spring node
bound = fix';
bound = bound(:);

%% LOAD
force = fix*0;
force(end,2) = -load;
F = force';
F = F(:);

%% ENFORCE DISPLACEMENT
U0 = force*0;
disp = -67.0155223399249; % Displacement of spring at the end in y
U0(n,2) = disp;
U0 = U0';
U0 = U0(:);



%% ELEMENT PROPERTIES
E_beam = 29e6;
A_beam = b*h; % Area (in^2)
Izz = h*b^3/12; % Moment of inertia (in^4)
Iyy = b*h^3/12; % Moment of inertia (in^4)
J = h*b^3*.333;

K = 1e3; % Spring stiffness constant
E_spring = (K*L_spring)/A_spring;


%% ELEMENT STRUCTURE AND VALUES

% Preallocate element structure
EL(n - 1).el = [];
EL(n - 1).el_in.nodes_ij = [];
EL(n - 1).el_in.orient_ij = [];
EL(n - 1).el_in0.break = [];
EL(n - 1).el_in0.mat = [];
EL(n - 1).el_in0.geom = [];
EL = EL';

for i = 1:n - 2
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el2'; % Linear, corotational beam
    
    % Special element input
    EL(i).el_in0.break = 0;
    EL(i).el_in0.mat = [E_beam .3]; % [type E nu]
    EL(i).el_in0.geom = [A_beam Izz Iyy 0 J]; % [A Izz Iyy ky J]
end


EL(n-1).el_in0 = instantiate_EL; % Instatiate all element variables

% Define element functions
EL(n-1).el = 'el2'; % Linear, corotational beam

% Special element input
EL(n-1).el_in0.break = 0;
EL(n-1).el_in0.mat = [E_spring .3]; % [type E nu]
EL(n-1).el_in0.geom = [A_spring 0 0 0 0]; % [A Izz Iyy ky J]





FEM.EL = EL;

FEM.MODEL.nodes = nodes;
FEM.MODEL.connect = connect;
FEM.MODEL.orientation = orientation;
FEM.MODEL.B = bound;
FEM.MODEL.F = F;
FEM.MODEL.F_pt = [F*0 F];

FEM.MODEL.U_pt = [U0*0 U0];

FEM.MODEL.F_pre = F*0;
FEM.MODEL.Dinc = 0;
FEM.MODEL.D = -1;
FEM.MODEL.Di = n*6 -4; % The dof that will be used for the b matrix in displacement solver
FEM.PASS.Fext = F*0;



% FE controls
[FEM.ANALYSIS] = FE_controls_cant_beam_enf_disp;
[FEM.PLOT] = plot_controls_cant_beam;


[FEM_out] = increment_FE(FEM);













