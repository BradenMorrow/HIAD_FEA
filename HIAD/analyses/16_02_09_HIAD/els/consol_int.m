% Consolidate FEM model
% February 09, 2016

% Elements
FEM.EL = [FEM.EL
    EL_int1
    EL_int2
    EL_int3
    EL_int4
    EL_int5
    EL_int6];

% Nodes
FEM.MODEL.nodes = [FEM.MODEL.nodes
    MODEL_int1.nodes
    MODEL_int2.nodes
    MODEL_int3.nodes
    MODEL_int4.nodes
    MODEL_int5.nodes
    MODEL_int6.nodes];

% Orientation nodes
FEM.MODEL.orientation = [FEM.MODEL.orientation
    MODEL_int1.orientation
    MODEL_int2.orientation
    MODEL_int3.orientation
    MODEL_int4.orientation
    MODEL_int5.orientation
    MODEL_int6.orientation];

% Connectivities
FEM.MODEL.connect = [FEM.MODEL.connect
    MODEL_int1.connect
    MODEL_int2.connect
    MODEL_int3.connect
    MODEL_int4.connect
    MODEL_int5.connect
    MODEL_int6.connect];

% Boundary conditions
FEM.MODEL.B = [FEM.MODEL.B
    MODEL_int1.bound
    MODEL_int2.bound
    MODEL_int3.bound
    MODEL_int4.bound
    MODEL_int5.bound
    MODEL_int6.bound];

% Nodal forces
FEM.MODEL.F = [FEM.MODEL.F
    MODEL_int1.F
    MODEL_int2.F
    MODEL_int3.F
    MODEL_int4.F
    MODEL_int5.F
    MODEL_int6.F];
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];


