% Driver for torus analysis
% April 19, 2016

clear

%% START ANALYSIS
set_working_dir
warning('on','all')
dir0 = 'C:\Users\andrew.young\Desktop\FE_code\16_04_19_tori';
t0 = tic;


r = 2;
E = 1e6;
[cable_f,cable_k] = lin_strap_response(E,E,.0001);

A = pi*r^2;
Izz = pi/4*r^4;
Iyy = pi/4*r^4;
J = pi/2*r^4;


%% NODES
L = 10; % Length
n = 2; % Nodes
nodes = [linspace(0,L,n)' zeros(n,2)];


%% ORIENTATION
orientation = nodes;
orientation(:,2) = 1;


%% CONNECTIVITIES
connect = [(1:n - 1)' (2:n)'];
connect = [connect ones(size(connect,1),1)*4];


%% BOUNDARIES
b = zeros(size(nodes,1),6);
b(1,:) = [1 1 1 1 0 0];
b(n,:) = [0 1 1 0 0 0];
b = b';
bound = b(:);


%% LOADING
f = zeros(size(nodes,1),6);
f(n,1) = 0;
f = f';
F = f(:);


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
    EL(i).el = @el2;

    % Element geometry
    EL(i).el_in.connect_ij = connect(i,1:2);

    % Special element input
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
    
    % Axial response
    EL(i).el_in0.axial = cable_f;
    EL(i).el_in0.axial_k = cable_k;
    
    EL(i).el_in0.eps0 = -.001;
end


%% MODEL
FEM.MODEL.nodes = nodes;
FEM.MODEL.orientation = orientation;
FEM.MODEL.connect = connect;
FEM.MODEL.B = bound;
FEM.MODEL.F = F;
FEM.EL = EL;

% Nodal forces
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];


% FE controls
[FEM.ANALYSIS] = FE_controls_test;
[FEM.PLOT] = plot_controls_test;
% FE_plot(FEM)
% post_proc_driver1

t_pre = toc(t0);


%% ANALYSIS
[FEM_out] = FE_solver(FEM);


%% POST PROCESS
t_tot = toc(t0);
t_an = t_tot - t_pre;
fprintf('\nPreprocessor time = %g s\nAnalysis time = %g s\n\n',t_pre,t_an)

