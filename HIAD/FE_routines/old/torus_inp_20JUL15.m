% Pre-process the torus object
% Andy Young
% December 31, 2014
%
% Preprocess the:
%   Location of nodes
%   Element connectivities
%   Element orientations
%   Boundary conditions
%   Force vector
% 
% Expanding to include geometric imperfections.  Must still include twist
% perturbations.

%% Nodes


% Nodal location, (nodes to obtain required number of elements and nodes
% for loading)
theta1 = linspace(0,2*pi - 2*pi/n,n)';

% strap0 = pi/2 - 5.63*pi/180; % Location of first strap
strap0 = 0;

% theta_strap = strap0 - linspace(0,2*pi - 2*pi/nP,nP)';
theta_strap = linspace(0,2*pi - 2*pi/nP,nP)';
% theta_strap(theta_strap < 0) = theta_strap(theta_strap < 0) + 2*pi;

theta_support = [pi/2 pi 3*pi/2]';
ind = [theta1; theta_strap; theta_support]; % [torus straps supports]
[theta,~,J] = unique(ind);


% Perfect geometry
theta_ip = nip*theta; % linspace(0,nip*2*pi,length(theta))';
theta_op = nop*theta; % linspace(0,nop*2*pi,length(theta))';

a = R + delta_a; % x radius
b = R + delta_b; % y radius

% Major diameter, (incorporate geometric imperfections)
x = a*cos(theta) + Aip*cos(theta_ip);
y = b*sin(theta) + Aip*sin(theta_ip);
z = Aop*sin(theta_op);

tor_nodes = [x y z];

% From PONTOS - get initial displacement
% T5C_1_U0



% Total number of nodes
nn = size(tor_nodes,1); % Total torus nodes
N = 0;
N = N + nn; % Torus
N = N + 0; % Torus radial
N = N + 4; % Torus tangential
N = N + 4; % Torus vertical

N = N + nP; % Straps
N = N + 0; % Straps radial
N = N + nP; % Straps tangential
N = N + nP; % Straps vertical


%% Orientation nodes
tor_orientation = tor_nodes;
tor_orientation(:,3) = tor_nodes(:,3) + 1;


%% Connectivities
tor_connect = [(1:size(x,1))' [(2:size(x,1))'; 1]];


%% Boundaries
% 1 = fixed
% 0 = free
fix = zeros(size(tor_nodes,1),6);

% For initial displacement analysis
str_ind = J(size(theta1,1) + 1:size(theta1,1) + 1 + size(theta_strap,1));
% fix(str_ind,1:3) = 1;
% fix(str_ind,3) = 1;
% fix(:,1:3) = 1;
% fix(:,:) = 1;


% % For enforcing initial configuration
% fix(:,1:3) = 1;


tor_bound = fix';
tor_bound = tor_bound(:);



%% Loading
% Gravity loading, first step
n1 = tor_nodes(tor_connect(:,1),:);
n2 = tor_nodes(tor_connect(:,2),:);
L_el = sum((n2 - n1).^2,2).^.5; % Length of element
w_el = L_el*10/15/12; % Weight of element estimation, 15 foot beams are 10 lbs

grav_F = zeros(size(fix));
grav_F(tor_connect(:,1),3) = w_el/2;
grav_F(tor_connect(:,2),3) = grav_F(tor_connect(:,2),3) + w_el/2;

tor_F1 = grav_F';
tor_F1 = -tor_F1(:);

grav_norm = norm(tor_F1);

% Second step
% proc_tor_load_test_15APR15
F_ind = J(n + 1:end - 3);
tor_F = zeros(size(tor_nodes,1),6);


% Test loading
% M_strap = zeros(nP,6,2);
% P_strap = zeros(nP,6,2);

P_vec = -[cos(theta) sin(theta) zeros(size(sin(theta),1),4)];
P_mag = P*(1 + e*cos(2*theta));

P_vec(:,1) = P_vec(:,1).*P_mag;
P_vec(:,2) = P_vec(:,2).*P_mag;

% Torus test
tor_F2 = P_vec';
tor_F2 = tor_F2(:);
tor_F2 = [zeros(size(tor_F2)) tor_F2];




% for i = 1:size(M_strap,3)
%     tor_F(F_ind,:) = P_strap(:,:,i) + M_strap(:,:,i);
%     tor_Ft = tor_F';
%     tor_F2(:,i) = tor_Ft(:);
% end



% tor_F2 = zeros(size(tor_F2));

% % % % Location of loaded nodes
% % % F_ind = J(n + 1:end);
% % % % theta_F = theta(F_ind);
% % % 
% % % % Components of force
% % % Pvec = -normr(tor_nodes(F_ind,:));
% % % loads = zeros(size(tor_nodes,1),6);
% % % loads(F_ind,1:3) = P*Pvec;
% % % 
% % % tor_F = loads';
% % % tor_F = tor_F(:);


%% Element type
% 1 = truss
% 2 = beam (Cook et al., 3D Beam Element)
% 3 = same as 2 without shear deformation
% 4 = Corotational formulation (Crisfield)
% 5 = Corotational formulation (Crisfield) with material nonlinearity
type = 4*ones(size(tor_connect,1),1);
config = 1*ones(size(tor_connect,1),1);
tor_connect = [tor_connect type config];


%% Materials and cross section
% Memeber configuration
p = 20; % Internal pressure
r = 13.6/2; % Shell (minor) radius
beta = 60; % Braid angle
props12 = [15655.8378114503 0.001 11.3599117025832 0]; %[14444.41201	0.001	11.67629614	0]; % Shell properties
alpha = [210 330]'; % [60 -60]'; % [0 120 240]'; % Location of cords on shell cross section
% axial_table = 'axial_table_0'; % Cord force/strain lookup table

% Shell
propsB = [54.8 19]'; % Bladder properties [E nu]' (lb/in)
propsB(3) = propsB(1)/(2*propsB(2)) - 1; % Bladder Poisson ratio

% Cord
Fc = p*pi*r^2/length(alpha)*(1 - 2*cot(beta*pi/180)^2); % Force in cord after inflation (lb)
CONFIG(1).Fc = Fc;

% axial = load(axial_table); % Cord force - strain lookup table
% axial1 = [(interp1(axial(:,2),axial(:,1),axial(:,2) + 1e-6) - axial(:,1))/1e-6 axial(:,2)];
% axial1(end,1) = (axial(end,1) - axial(end - 1,1))/(axial(end,2) - axial(end - 1,2));
% axial_0 = pchip(axial(:,2),axial(:,1));
% axial_1 = fnder(axial_0);
% eps0 = interp1(axial(:,1),axial(:,2),Fc);
% cord_inp_28MAY15

% Material preprocessor
t = .1/3; % Lamina thickness

% Fiber (lamina) properties
E1 = props12(1)/t; % psi
E2 = props12(2)/t;
G12 = props12(3)/t;
nu12 = props12(4);

% Bladder properties
E_b = propsB(1)/t; % psi
G_b = propsB(2)/t;
nu_b = propsB(3);

[A,~] = get_A([E1 E1 E_b]', [E2 E2 E_b]', [nu12 nu12 nu_b]', [G12 G12 G_b]', [beta -beta 0]', [t t t]');

% Laminate properties
EL = (A(1,1) - A(1,2)^2/A(2,2))/(3*t); % psi
EH = (A(2,2) - A(1,2)^2/A(1,1))/(3*t); % psi
GLH = A(3,3)/(3*t); % psi
nuHL = A(1,2)/A(1,1);

% % % % For linear elastic analysis
% % % EL = 100000;
% % % EH = EL;
% % % nuHL = .3;
% % % GLH = EL/(2*(1 + nuHL));

% Initialize other variables
y_bar = zeros(N,1);
EI = zeros(N,3);
% ax = [ones(N,2)*Fc*length(alpha) zeros(N,1)]; % ones(N,1)*eps0];

tor_ind = (1:size(tor_nodes,1))';

% % % CONFIG(1).r = r;
% % % CONFIG(1).alpha = alpha;
% % % % % % CONFIG(1).axial = axial;
% % % % % % CONFIG(1).axial1 = axial1;
% % % % % % CONFIG(1).axial_1 = axial_1;
% % % % % % CONFIG(1).axial_0 = axial_0;
% % % CONFIG(1).element = element;
% % % CONFIG(1).d_LOAD = d_LOAD;
% % % CONFIG(1).d_UNLOAD = d_UNLOAD;
% % % 
% % % CONFIG(1).eps0 = eps0;
% % % CONFIG(1).propsLH = [EL EH GLH nuHL t]';
% % % CONFIG(1).y_bar = y_bar;
% % % CONFIG(1).EI = EI;
% % % CONFIG(1).y_bar0 = y_bar;
% % % CONFIG(1).EI0 = EI;
% % % 
% % % CONFIG(1).nodes = tor_nodes;
% % % CONFIG(1).connect = tor_connect;
% % % CONFIG(1).ind = tor_ind;


%% MATERIALS
E = 2.1e7*100^2; % 10e6;
material = [ones(size(tor_nodes,1),1) ones(size(tor_nodes,1),1)*E ones(size(tor_nodes,1),1)*.3]; % [type E nu]

A = 20/100^2;
I = 1.666667/100^4;
geom = [A.*ones(size(tor_nodes,1),1) I.*ones(size(tor_nodes,1),2) ones(size(tor_nodes,1),1)*2 2*I.*ones(size(tor_nodes,1),1)]; % [A Izz Iyy ky J]

SPRING.material = material;
SPRING.geom = geom;
SPRING.nodes = tor_nodes;
SPRING.connect = tor_connect;
SPRING.ind = tor_ind;
FEM.SPRING = SPRING;
