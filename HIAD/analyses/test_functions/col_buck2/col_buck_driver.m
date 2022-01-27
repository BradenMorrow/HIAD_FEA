% Analyze the response of a column under buckling.  
% Use a small perturbation force to induce buckling.
clear
%%

% Load parameters
% Loading and elements
n = 10; % Number of nodes
react = 1.25; % 12000*1.1/1.4*10; 

% Geometry
L = 1; % Length

%% NODES
e = .001; % Ecentricity
x = linspace(0,L,n)';
theta = linspace(0,pi,n)';
y = e*sin(theta);
z = 0*x;

nodes = [x y z];

%% ORIENT
orientation = nodes;
orientation(:,2) = orientation(:,2) + 1;

%% CONNECT
connect = [(1:n - 1)' (2:n)' 4*ones(size(nodes,1) - 1,1)];

%% BOUND
fix = zeros(size(x,1),6);
fix(:,[3 4 5]) = 1;
fix(1,[1 2]) = 1;
fix(end,2) = 1;

bound = fix';
bound = bound(:);

%% LOAD
force = fix*0;
force(end,1) = -react;
F = force';
F = F(:);

U0 = F*0;

%% MATERIALS
% Preallocate element structure
EL(n - 1).el = [];
EL(n - 1).el_in.nodes_ij = [];
EL(n - 1).el_in.orient_ij = [];
EL(n - 1).el_in.connect_ij = [];
EL(n - 1).el_in0.mat = [];
EL(n - 1).el_in0.geom = [];
EL = EL';



E = 1;
A = 100e6;
I = 1/pi^2;
GAv = 100; % lbf
r = sqrt(2*I/A); % Shell (minor) radius
t = A/(2*pi)*sqrt(A/(2*I))/3;
G = 2*GAv/A;

% Inflatable beam
% Configuration
p = 0; % Internal pressure
alpha = [0 90 180 270]'; % Location of cords on shell cross section 

% Material preprocessor
beta = 90; % Braid angle

nu = .3;

% Cord force/strain lookup table
% % % axial_table = axial_table_i;
d = [-10 -100
    10 100];
Fc = p*pi*r^2/length(alpha)*(1 - 2*cot(beta*pi/180)^2); % Force in one cord after inflation (lb)
eps0 = interp1(d(:,1),d(:,2),Fc); % Initial cord strain

load_point = [0 0];
unload_point = [0 0];

% Number of integration points (3 to 10)
Nint = 5;

% Gauss-Lobatto integration constants
[xi,~] = get_GL(Nint);
xi = (xi - xi(1))/2; % From 0 to L

% Pre-calculate displacement interpolation functions
Gmat = ones(Nint);
exp = 0:Nint - 1;
l2 = zeros(Nint);
l1 = zeros(Nint);
for i = 1:Nint
    Gmat(i,:) = Gmat(i,:)*xi(i); % G matrix
    Gmat(i,:) = Gmat(i,:).^exp;
    l1(i,:) = 1/i*(xi(i).^(1:Nint) - xi(i)); % First integral of interpolation functions
    l2(i,:) = 1/(i*(i + 1))*(xi(i).^(2:Nint + 1) - xi(i)); % Second integral of interpolation functions
end
Ginv = Gmat\eye(Nint);
v_kappa = l2*Ginv; % Store vectors for calculation of element displacement at integration points
v_gamma = l1*Ginv;


% Loop through elements and load relevant data
for i = 1:n - 1
    % Define element functions
    EL(i).el = 'el3'; % Pneumatic, corotational beam
    
    % Element geometry
    EL(i).el_in.nodes_ij = [nodes(connect(i,1),:)
        nodes(connect(i,2),:)];
    EL(i).el_in.orient_ij = [orientation(connect(i,1),:)
        orientation(connect(i,2),:)];
    EL(i).el_in.connect_ij = connect(i,1:2);
    
    % Special element input
    EL(i).el_in0.p = p;
    EL(i).el_in0.r = r;
    EL(i).el_in0.alpha = zeros(size(alpha,1),Nint);
    EL(i).el_in0.beta = beta;
    
    EL(i).el_in0.eps = eps0*ones(size(alpha,1),2);
    EL(i).el_in0.f = Fc*ones(size(alpha,1),2);
    EL(i).el_in0.Fc = Fc;
    
    % Cord input
    for j = 1:Nint % Loop through integration points
        for k = 1:length(alpha) % Loop through each cord
            EL(i).el_in0.nodes(j).cords(k).axial = d;
            EL(i).el_in0.nodes(j).cords(k).load_point = load_point;
            EL(i).el_in0.nodes(j).cords(k).unload_point = unload_point;
            EL(i).el_in0.nodes(j).cords(k).eps_rate = 1;
        end
        
        EL(i).el_in0.alpha(:,j) = alpha;
    end
    
    EL(i).el_in0.propsLH = [E E G nu t]'; % Shell properties
    EL(i).el_in0.EI = [0 0 0]; % Tangent EI
    EL(i).el_in0.y_bar = [0 0]'; % Location of NA
    
    EL(i).el_in0.D0 = [0 0 0 0 0 0]';
    EL(i).el_in0.P0 = [0 0 0 0 0 0]';
    
    EL(i).el_in0.PV_work = 0; % [0 0]';
    EL(i).el_in0.n = Nint;
    
    % Initialize stored variables for fiber model
    EL(i).el_in0.flex.K = zeros(5); % Section forces
    EL(i).el_in0.flex.D = zeros(5,Nint); % zeros(3,Nint); % Section forces
    EL(i).el_in0.flex.Du = zeros(5,Nint); % Unbalanced section forces
    EL(i).el_in0.flex.Q = zeros(5,1); % Element forces
    EL(i).el_in0.flex.f = zeros(5,5,Nint); % zeros(3,3,Nint); % Section compliance matrices
    EL(i).el_in0.flex.d = zeros(5,Nint); % zeros(3,Nint); % Section deformations
    EL(i).el_in0.flex.e = zeros(size(alpha,1),Nint) + eps0; % Section fiber strains

    % Iterative or non-iterative state determination procedure
    EL(i).el_in0.state_it = false;
end











% % % E = 2.1e11;
% % % A = .002/10;
% % % I = 1.666667e-8;
% % % 
% % % % Preallocate element structure
% % % EL(n - 1).el = [];
% % % EL(n - 1).el_in.nodes_ij = [];
% % % EL(n - 1).el_in.orient_ij = [];
% % % EL(n - 1).el_in.connect_ij = [];
% % % EL(n - 1).el_in0.mat = [];
% % % EL(n - 1).el_in0.geom = [];
% % % EL = EL';
% % % 
% % % for i = 1:n - 1
% % %     % Define element functions
% % %     EL(i).el = @el2; % Corotational formulation, linear elastic
% % %     
% % %     % Special element input
% % %     EL(i).el_in0.mat = [E .3]; % [type E nu]
% % %     EL(i).el_in0.geom = [A I I 0 2*I]; % [A Izz Iyy ky J]
% % % end












FEM.EL = EL;

FEM.MODEL.nodes = nodes;
FEM.MODEL.orientation = orientation;
FEM.MODEL.connect = connect;
FEM.MODEL.B = bound;
FEM.MODEL.F = F;
FEM.MODEL.F_pt = [F*0 F];

FEM.MODEL.F_pre = F*0;
FEM.MODEL.Dinc = 0;
FEM.MODEL.D = -1;
FEM.MODEL.Di = n*6 - 4; % The dof that will be used for the b matrix in displacement solver
FEM.PASS.Fext = F*0;

FEM.ANALYSIS = FE_controls_col_buck;
FEM.PLOT = plot_controls_col_buck;

FEM.OUT.U = bound*0;
FE_plot(FEM)


%% Analyze
FEM.PASS.f_norm = react;
FEM.PASS.set_L = 1;

FEM.BOUND.U0 = U0;

tic
[FEM_out] = increment_FE(FEM);
toc



%%
FE_plot(FEM_out)
Fout = col_buck_def(FEM_out);

Fcr = (E*I*pi^2/L^2*(p + GAv))./(E*I*pi^2/L^2 + p + GAv);

% disp([Fcr Fout (Fout - Fcr)/Fcr*100])
Fout












