function [Cout] = get_Cout(FEM)
% Get location of tori
% May 11, 2016

ind = FEM.MODEL.theta_ind;
th = ind(1).ind;
dof = (1:size(th,1):size(th,1)*6)';

% Displacement
U2 = reorg_vec(FEM.OUT.U);

% Torus locations
Cout = FEM.MODEL.nodes(dof,[1 3]) + U2(dof,[1 3]);




end

