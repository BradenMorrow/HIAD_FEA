% Consolidate FEM model
% February 09, 2016

% Elements
FEM.EL = [FEM.EL
    EL_strap];

% Nodes
FEM.MODEL.nodes = [FEM.MODEL.nodes
    MODEL_strap.nodes];

% Orientation nodes
FEM.MODEL.orientation = [FEM.MODEL.orientation
    MODEL_strap.orientation];

% Connectivities
FEM.MODEL.connect = [FEM.MODEL.connect
    MODEL_strap.connect];

% Boundary conditions
FEM.MODEL.B = [FEM.MODEL.B
    MODEL_strap.bound];

% Nodal forces
FEM.MODEL.F = [FEM.MODEL.F
    MODEL_strap.F];
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];


% FEM.MODEL.F = FEM.MODEL.F*0;
% FEM.MODEL.F_pre = FEM.MODEL.F_pre*0;
% FEM.MODEL.F_pt = FEM.MODEL.F_pt*0;


% Indices of elements for post processing
theta_ind.tor1 = (1:size(theta,1))' + size(theta,1)*0;
theta_ind.tor2 = (1:size(theta,1))' + size(theta,1)*1;
theta_ind.tor3 = (1:size(theta,1))' + size(theta,1)*2;
theta_ind.tor4 = (1:size(theta,1))' + size(theta,1)*3;
theta_ind.tor5 = (1:size(theta,1))' + size(theta,1)*4;
theta_ind.tor6 = (1:size(theta,1))' + size(theta,1)*5;

theta_ind.ind1 = (1:size(theta,1))' + size(theta,1)*6;
theta_ind.ind2 = (1:size(theta,1))' + size(theta,1)*7;
theta_ind.ind3 = (1:size(theta,1))' + size(theta,1)*8;
theta_ind.ind4 = (1:size(theta,1))' + size(theta,1)*9;
theta_ind.ind5 = (1:size(theta,1))' + size(theta,1)*10;
theta_ind.ind6 = (1:size(theta,1))' + size(theta,1)*11;

theta_ind.link = (1:size(EL_link,1))' + size(theta,1)*12;

strap_ind_all = (1:size(strap_ind,1))' + theta_ind.link(end);

theta_ind.loop1_1aft = strap_ind_all(strap_ind == 1);
theta_ind.loop1_2aft = strap_ind_all(strap_ind == 2);
theta_ind.loop1_3aft = strap_ind_all(strap_ind == 3);
theta_ind.loop1_1fore = strap_ind_all(strap_ind == 4);
theta_ind.loop1_2fore = strap_ind_all(strap_ind == 5);
theta_ind.loop1_3fore = strap_ind_all(strap_ind == 6);
theta_ind.loop2_1aft = strap_ind_all(strap_ind == 7);
theta_ind.loop2_2aft = strap_ind_all(strap_ind == 8);
theta_ind.loop2_3aft = strap_ind_all(strap_ind == 9);
theta_ind.loop2_1fore = strap_ind_all(strap_ind == 10);
theta_ind.loop2_2fore = strap_ind_all(strap_ind == 11);
theta_ind.loop2_3fore = strap_ind_all(strap_ind == 12);
theta_ind.rad_aft = strap_ind_all(strap_ind == 13);
theta_ind.chev_aft = strap_ind_all(strap_ind == 14);
theta_ind.rad_fore = strap_ind_all(strap_ind == 15);
theta_ind.chev_fore = strap_ind_all(strap_ind == 16);





