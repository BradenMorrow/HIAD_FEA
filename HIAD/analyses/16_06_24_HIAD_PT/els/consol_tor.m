% Consolidate FEM model
% February 09, 2016

% Elements
FEM.EL = [EL_tor1
    EL_tor2
    EL_tor3
    EL_tor4
    EL_tor5
    EL_tor6];

% Nodes
FEM.MODEL.nodes = [MODEL_tor1.nodes
    MODEL_tor2.nodes
    MODEL_tor3.nodes
    MODEL_tor4.nodes
    MODEL_tor5.nodes
    MODEL_tor6.nodes];

% Orientation nodes
FEM.MODEL.orientation = [MODEL_tor1.orientation
    MODEL_tor2.orientation
    MODEL_tor3.orientation
    MODEL_tor4.orientation
    MODEL_tor5.orientation
    MODEL_tor6.orientation];

% Connectivities
FEM.MODEL.connect = [MODEL_tor1.connect
    MODEL_tor2.connect
    MODEL_tor3.connect
    MODEL_tor4.connect
    MODEL_tor5.connect
    MODEL_tor6.connect];

% Boundary conditions
FEM.MODEL.B = [MODEL_tor1.bound
    MODEL_tor2.bound
    MODEL_tor3.bound
    MODEL_tor4.bound
    MODEL_tor5.bound
    MODEL_tor6.bound];

% Nodal forces
FEM.MODEL.F = [MODEL_tor1.F
    MODEL_tor2.F
    MODEL_tor3.F
    MODEL_tor4.F
    MODEL_tor5.F
    MODEL_tor6.F];

% % % FEM.MODEL.F = FEM.MODEL.F*p; % Scale uniform pressure

% Axisymmetric loading
F = FEM.MODEL.F;


% % % % Non-axisymmetric loading
% % % [F] = press_dist_nonaxi(theta,FEM.MODEL.F);


ind = 1:6:size(F,1);
ind = [ind ind + 1 ind + 2 ind + 3 ind + 4 ind + 5]';
F2 = zeros(length(F)/6,6);
F2(:) = F(ind);

% Calculate total drag load
Rx = sum(F2(:,1));
Ry = sum(F2(:,2));
Rz = sum(F2(:,3));
r1 = 657.5/2; % Outside radius (in)
r0 = 340/2; % Centerbody radius (in)

Atot = pi*r1^2; % Total area
Acb = pi*r0^2; % Centerbody area
Ainf = Atot - Acb; % Inflatable area
% % % Ftot_y = Ry/.8*Atot/Ainf; % Horizontal force on inflatable
% % % Ftot_z = Rz/.8*Atot/Ainf; % Vertical force on inflatable
Ryz = sqrt(Ry^2 + Rz^2)/.8*Atot/Ainf;

th = 22.5 - atan2(Ry,Rz)*180/pi;
FD = Ryz*cosd(th);

% Scale force vector to obtain total load
scale_force = F_drag/FD;
FEM.MODEL.F = F*scale_force;

FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];











