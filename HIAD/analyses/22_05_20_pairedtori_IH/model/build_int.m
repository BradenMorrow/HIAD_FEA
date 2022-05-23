function [FEM, K_shear] = build_int(FEM,theta,C,tor,pre_str)
%% Generate properties and geometry for interaction elements
% Evenly spaced theta

%% Preallocate and declare variables
EL(size(theta,1)).el = [];
EL(size(theta,1)).el_in = [];
EL(size(theta,1)).el_in0.mat = [];
EL(size(theta,1)).el_in0.geom = [];
EL = EL';


%% Create interaction elements
r1 = tor(1).r;
r2 = tor(2).r;
L0 = r1 + r2;

K_ax1 = tor(1).K_ax*2; % lbf/in/in
K_ax2 = tor(2).K_ax*2; % lbf/in/in
K_ax_eq = 1/(1/K_ax1 + 1/K_ax2)*L0; % Equivalent axial stiffness lbf/in
K_ax = K_ax_eq*2*pi*C(2)/size(theta,1); % Distribute to each node (assumes uniform nodal distribution) lbf/strain



K_shear1 = tor(1).K_shear*8; % Stiffness (of half of member) lbf/in/in
K_shear2 = tor(2).K_shear*8; % Stiffness (of half of member) lbf/in/in

% Find the equivalent shear stiffness of two section, treat like
% a stepped cantelever beam
d1 = 1/K_shear1 + 3*r2/(2*K_shear1*r1); % Deflection of first section due to a unit load (in*in) (deflection*unit width)
d2 = 1/K_shear2; % Deflection of the second section due to a unit load (in*in)
rot = 3/K_shear1*(1/(2*r1) + r2/r1^2); % Rotation at end of first section (rad*in)
d3 = r2*rot; % Deflection of the second section due to a rotation at the end of the first section (in*in)
K_sh_eq = 1/(d1 + d2 + d3); % lbf/in/in

% K_sh_eq = 1/(1/K_shear1 + 3*r2/(r1*K_shear1) + 3*r2^2/(r1^2*K_shear1) + 1/K_shear2);
K_shear = K_sh_eq*2*pi*C(1)/size(theta,1); % Distribute to each node

    
% Determine geometric properties
E = 10e6; % Arbitralily fixed
A = K_ax/E;
Izz = K_shear*L0^3/(3*E);
Iyy = pi/4*2^4;
J = 1;

    
%% ORIENTATION
orientation = zeros(size(theta,1),3);
orientation(:,3) = 1e6;


%% CONNECTIVITIES
connect_i = [(1:size(theta,1))' (1:size(theta,1))' + size(theta,1)];

connect = [connect_i 2*ones(size(connect_i,1),1)];

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
    EL(j).el_in0.eps0 = pre_str(1);
end

%% MODEL
FEM.EL = [FEM.EL; EL];
FEM.MODEL.orientation = [FEM.MODEL.orientation; orientation];
FEM.MODEL.connect = [FEM.MODEL.connect; connect];
end


