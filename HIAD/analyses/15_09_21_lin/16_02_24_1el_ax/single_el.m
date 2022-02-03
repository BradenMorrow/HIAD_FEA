% Test with single element
% February 23, 2016

clear

n = 2; % Number of nodes
L = 10;
nodes = [linspace(0,L,n)' zeros(n,1) zeros(n,1)];

orientation = nodes;
orientation(:,2) = 1;

connect = [(1:n - 1)' (2:n)' 3*ones(n - 1,1)];

b = zeros(n,6);
b(1,[1 2 3 4]) = 1;
b(end,[2 3]) = 1;
% b(1,:) = 1;
% b(end,2:end) = 1;
b1 = b';
bound = b1(:);

f = zeros(n,6);
f(n,1) = -60;
f = f';
F = f(:);

MODEL.nodes = nodes;
MODEL.orientation = orientation;
MODEL.connect = connect;
MODEL.B = bound;
MODEL.F = F;


% Inflatable
% Preallocate element structure
EL(size(connect,1)).el = [];
EL(size(connect,1)).el_in.nodes_ij = [];
EL(size(connect,1)).el_in.orient_ij = [];
EL(size(connect,1)).el_in.connect_ij = [];
EL(size(connect,1)).el_in0.mat = [];
EL(size(connect,1)).el_in0.geom = [];
EL = EL';

% Cord force/strain lookup table
% ax_loop = load('loop_straps');

% axial = load('ax_test');
% axial = load('loop_straps');
[strap_f,strap_k] = strap_response(114000,300,50,2,0);


E_loop = 114000;
t = .0285;
w = 2;
A = t*w;
Izz = w*t^3/12;
Iyy = w^3*t/12;
J = .312*w*t^3;

Nint = 5; % Number of integration points (3 to 10)
for i = 1:size(connect,1)
    % Define element functions
%     EL(i).el = @el4_14MAR16; % Corotational beam with axial lookup table
    EL(i).el = @el4; % Corotational beam with axial lookup table

    % Element geometry
    EL(i).el_in.connect_ij = connect(i,1:2);

    % Special element input
    E = E_loop;
    
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
    
    EL(i).el_in0.axial = strap_f;
    EL(i).el_in0.axial_k = strap_k;
    
    EL(i).el_in0.D0 = [0 0 0 0 0 0]';
    EL(i).el_in0.P0 = [0 0 0 0 0 0]';
    
    EL(i).el_in0.n = Nint;
    
    % Initialize stored variables for fiber model
    EL(i).el_in0.flex.K = zeros(5); % Element stiffness
    EL(i).el_in0.flex.D = zeros(5,Nint); % Section forces
    EL(i).el_in0.flex.Du = zeros(5,Nint); % Unbalanced section forces
    EL(i).el_in0.flex.Q = zeros(5,1); % Element forces
    EL(i).el_in0.flex.f = zeros(5,5,Nint); % Section compliance matrices
    EL(i).el_in0.flex.d = zeros(5,Nint); % Section deformations
    EL(i).el_in0.flex.e = zeros(1,Nint); % Section fiber strains
    
    % Iterative or non-iterative state determination procedure
    EL(i).el_in0.state_it = 0;
end




FEM.MODEL = MODEL;
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];

FEM.EL = EL;
% FE controls
[FEM.ANALYSIS] = FE_controls;
[FEM.PLOT] = plot_controls;





% % % figure(100)
% % % clf
% % % box on
% % % hold on
% % % plot(ax_pt(:,2),ax_pt(:,1),'b-')
% % % % xlim([-10 1])
% % % % ylim([-120 20])


tic
[FEM_out] = FE_solver(FEM);



toc
sum(sum(FEM_out.iter_info(:,2)))
















