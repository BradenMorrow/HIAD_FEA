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

FEM.MODEL.F = FEM.MODEL.F*p; % Scale pressure

FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];

