function [FEM] = gen_model(theta,I_theta_cable,I_theta_support,tor,cable_pp)
% April 29, 2016
% Generate torus load testing model

% Load elements
% Torus elements
[MODEL_tor,EL_tor] = torus(theta,tor);

% Link elements
[MODEL_link,EL_link] = links(theta,I_theta_cable,tor);

% Cable elements
[MODEL_cable,EL_strap] = cables(theta,I_theta_cable,cable_pp);

% Boundary elements
[MODEL_bound_vert,EL_bound_vert] = bound_vert(theta,I_theta_cable,I_theta_support,tor);
[MODEL_bound_tan,EL_bound_tan] = bound_tan(theta,I_theta_cable,I_theta_support,tor);
[MODEL_bound_rad,EL_bound_rad] = bound_rad(theta,I_theta_cable,I_theta_support,tor);

[MODEL_bound_tan_cable,EL_bound_tan_cable] = bound_tan_cable(theta,I_theta_cable,I_theta_support,MODEL_cable);
[MODEL_bound_vert_cable,EL_bound_vert_cable] = bound_vert_cable(theta,I_theta_cable,I_theta_support,MODEL_cable);


% Consolidate element types
FEM.EL = [EL_tor
    EL_link
    EL_strap
    EL_bound_vert
    EL_bound_tan
    EL_bound_rad
    EL_bound_tan_cable
    EL_bound_vert_cable];

FEM.MODEL.nodes = [MODEL_tor.nodes
    MODEL_link.nodes
    MODEL_cable.nodes
    MODEL_bound_vert.nodes
    MODEL_bound_tan.nodes
    MODEL_bound_rad.nodes
    MODEL_bound_tan_cable.nodes
    MODEL_bound_vert_cable.nodes];

FEM.MODEL.orientation = [MODEL_tor.orientation
    MODEL_link.orientation
    MODEL_cable.orientation
    MODEL_bound_vert.orientation
    MODEL_bound_tan.orientation
    MODEL_bound_rad.orientation
    MODEL_bound_tan_cable.orientation
    MODEL_bound_vert_cable.orientation];

FEM.MODEL.connect = [MODEL_tor.connect
    MODEL_link.connect
    MODEL_cable.connect
    MODEL_bound_vert.connect
    MODEL_bound_tan.connect
    MODEL_bound_rad.connect
    MODEL_bound_tan_cable.connect
    MODEL_bound_vert_cable.connect];

FEM.MODEL.B = [MODEL_tor.bound
    MODEL_link.bound
    MODEL_cable.bound
    MODEL_bound_vert.bound
    MODEL_bound_tan.bound
    MODEL_bound_rad.bound
    MODEL_bound_tan_cable.bound
    MODEL_bound_vert_cable.bound];

FEM.MODEL.F = [MODEL_tor.F
    MODEL_link.F
    MODEL_cable.F
    MODEL_bound_vert.F
    MODEL_bound_tan.F
    MODEL_bound_rad.F
    MODEL_bound_tan_cable.F
    MODEL_bound_vert_cable.F];

% Element indices
FEM.el_ind = indices(theta,I_theta_cable,I_theta_support);

% Cable force vector
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];

% % % % Cable displacement vector
% % % [FEM.MODEL.U_pt] = tor_disp(FEM.el_ind,tor);


end

