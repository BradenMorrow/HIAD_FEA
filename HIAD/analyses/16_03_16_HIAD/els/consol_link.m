% Consolidate FEM model
% February 09, 2016

% Elements
FEM.EL = [FEM.EL
    EL_link];

% Nodes
FEM.MODEL.nodes = [FEM.MODEL.nodes
    MODEL_link.nodes];

% Orientation nodes
FEM.MODEL.orientation = [FEM.MODEL.orientation
    MODEL_link.orientation];

% Connectivities
FEM.MODEL.connect = [FEM.MODEL.connect
    MODEL_link.connect];

% Boundary conditions
FEM.MODEL.B = [FEM.MODEL.B
    MODEL_link.bound];

% Nodal forces
FEM.MODEL.F = [FEM.MODEL.F
    MODEL_link.F];
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];


