function [MODEL,EL] = torus(theta,tor)
% Generate properties and geometry for torus

%% GENERAL
r = tor.r; % Minor radius (in)
p = tor.p; % Inflation pressure (psi)
beta = tor.beta; % Braid angle (deg)
alpha = tor.alpha; % Cord locations (deg from vertical)
ELong1 = tor.ELong; % Measured zylon longitudinal stiffness (lb/in)
GLH = tor.GLH; % Measured zylon inplane shear stiffness (lb/in)
Nint = tor.Nint; % Number of integration points (3 to 10)


%% NODES
nodes = tor.nodes;


%% ORIENTATION
orientation = nodes;
orientation(:,3) = orientation(:,3) + 100;

perturb = false;
perturb_plot = false;
if perturb
    delta_gamma = -1; % Purturbation angle
    delta_gamma = delta_gamma*pi/180;
    
    l = 100; % Height above node
    gamma = delta_gamma*cos(2*theta + 30*pi/180); % 
    
    delta_R = l*sin(gamma); % Change in radius
    Xo = (tor.R + delta_R).*cos(theta); % New X
    Yo = (tor.R + delta_R).*sin(theta); % New Y
    Zo = l*cos(gamma); % New Z
    
    orientation = [Xo Yo Zo]; % Update location of orientation node
    
    if perturb_plot
        figure(111)
        clf
        box on
        hold on
        plot(theta*180/pi,gamma,'bx-')
        xlim([0 360])
    end
    
    gamma2 = -gamma/max(abs(gamma))*.5;
    nodes(:,3) = gamma2;
    
end


%% CONNECTIVITIES
connect = [(1:size(theta,1) - 1)' (2:size(theta,1))'];
connect = [connect; size(theta,1) 1];
connect = [connect 3*ones(size(connect,1),1)];


%% BOUNDARIES
b = [zeros(size(nodes,1),3) zeros(size(nodes,1),3)];
b = b';
bound = b(:);


%% LOADING
f = zeros(size(nodes,1),6);
f = f';
F = f(:);


%% MODEL
MODEL.nodes = nodes;
MODEL.orientation = orientation;
MODEL.connect = connect;
MODEL.bound = bound;
MODEL.F = F;


%% ELEMENTS
% Preallocate element structure
EL(size(connect,1)).el = [];
EL(size(connect,1)).el_in.nodes_ij = [];
EL(size(connect,1)).el_in.orient_ij = [];
EL(size(connect,1)).el_in0.break = [];
EL(size(connect,1)).el_in0.K0 = zeros(6,6);
EL = EL';

% Inflatable specific
% Shell
[ELong] = get_beam_EL(beta,p,r,ELong1); % Gross axial stiffness

% Cord force/strain lookup table
% % % axial_table = 'axial_T4_20psi';
% % % d = load(axial_table);
[d] = cord_response(p,r,beta,size(alpha,1));
% 
% d = [-3000*10 -10
%     0 0
%     1.4363e+05*10*.75 10];



Fc = p*pi*r^2/length(alpha)*(1 - 2*cotd(beta)^2); % Force in one cord after inflation (lb)
eps0 = interp1(d(:,1),d(:,2),Fc); % Initial cord strain

% Loop through elements and load relevant data
for i = 1:size(connect,1)
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el3'; % Linear, corotational beam
    
    % Special element input
    EL(i).el_in0.break = 0;
    EL(i).el_in0.K0 = zeros(6,6);
    EL(i).el_in0.p = p;
    EL(i).el_in0.r = r;
    EL(i).el_in0.alpha = zeros(size(alpha,1),Nint);
    EL(i).el_in0.beta = beta;
    
    EL(i).el_in0.eps = eps0*ones(size(alpha,1),2);
    EL(i).el_in0.f = Fc*ones(size(alpha,1),2);
    
    % Cord input
    for j = 1:Nint % Loop through integration points
        for k = 1:length(alpha) % Loop through each cord
            EL(i).el_in0.nodes(j).cords(k).axial = d;
        end
        
        EL(i).el_in0.alpha(:,j) = alpha;
    end
    
    EL(i).el_in0.propsLH = [ELong 0 GLH 0 1]'; % [ELong EHoop GLH nuHL 1]'; % Shell properties
    
    EL(i).el_in0.D0 = [0 0 0 0 0 0]';
    EL(i).el_in0.P0 = [0 0 0 0 0 0]';
    
    EL(i).el_in0.n = Nint;
    
    % Initialize stored variables for fiber model
    EL(i).el_in0.flex.break = 0;
    EL(i).el_in0.flex.K = zeros(5); % Element stiffness
    EL(i).el_in0.flex.D = zeros(5,Nint); % Section forces
    EL(i).el_in0.flex.Du = zeros(5,Nint); % Unbalanced section forces
    EL(i).el_in0.flex.Q = zeros(5,1); % Element forces
    EL(i).el_in0.flex.f = zeros(5,5,Nint); % Section compliance matrices
    EL(i).el_in0.flex.d = zeros(5,Nint); % Section deformations
    EL(i).el_in0.flex.e = zeros(size(alpha,1),Nint) + eps0; % Section fiber strains
    
    % Iterative or non-iterative state determination procedure
    EL(i).el_in0.state_it = false;
end



end

