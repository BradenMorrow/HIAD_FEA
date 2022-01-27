function [FEM] = apply_bound(FEM)
%APPLY_BOUND Summary of this function goes here
%   Apply boundary conditions to the system stiffness matrix.

% Extract required variables
bound = FEM.MODEL.B;

% % % % Initialize variables
% % % FEM.PASS.K_BC = FEM.PASS.K;

% delete rows and columns of fixed DOFs
FEM.PASS.K_BC = FEM.PASS.K(~logical(bound),~logical(bound));

end

