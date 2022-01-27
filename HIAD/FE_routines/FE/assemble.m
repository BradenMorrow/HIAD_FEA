function [FEM] = assemble(FEM)
%ASSEMBLE
%   Loop through elements and assemble the stiffness matrix
%   Assume 2 nodes per element and 6 dof


% Extract elements
EL = FEM.EL;

% Store the FEM variables
con = FEM.MODEL.connect(:,1:2); % Element connectivity, this is set in analysis
n = size(FEM.MODEL.nodes,1); % Number of nodes
assemble_K = FEM.PASS.assemble;

% Extract displacement variables
U = FEM.OUT.U;
delta_U = FEM.OUT.delta_U;
DELTA_U = FEM.OUT.DELTA_U;
U0 = FEM.OUT.U0;

% Reorganize displacements
ind = 1:6:size(U,1);
ind = [ind ind + 1 ind + 2 ind + 3 ind + 4 ind + 5]';
U2 = zeros(length(U)/6,6); % Initializ and preallocate U2
U2(:) = U(ind);
DELTA_U2 = zeros(length(U)/6,6); % Initializ and preallocate DELTA_U2
DELTA_U2(:) = DELTA_U(ind);
delta_U2 = zeros(length(U)/6,6); % Initializ and preallocate delta_U2
delta_U2(:) = delta_U(ind);
U02 = zeros(length(U)/6,6); % Initializ and preallocate UO2
U02(:) = U0(ind);
U03 = [U02(con(:,1),:)  U02(con(:,2),:)];
U3 = [U2(con(:,1),:)  U2(con(:,2),:)];
delta_U3 = [delta_U2(con(:,1),:)  delta_U2(con(:,2),:)];
DELTA_U3 = [DELTA_U2(con(:,1),:) DELTA_U2(con(:,2),:)];
U_input = zeros(size(U3,1), 12, 4);
U_input(:,:,1) = U03; % Store U03 in the first plane of U_input, each row is an element
U_input(:,:,2) = U3; % Store U03 in the second plane of U_input
U_input(:,:,3) = delta_U3; % Store U03 in the third plane of U_input
U_input(:,:,4) = DELTA_U3; % Store U03 in the 4th plane of U_input

if(FEM.ANALYSIS.compiled)
    [EL, fint_i, Fint_i, dof_Fint, Kel, dof_i, dof_j, ROT, break_iter] = ...
        assemble_prebody_mex(con, EL, U_input, FEM.ANALYSIS.parallelize);
else
    [EL, fint_i, Fint_i, dof_Fint, Kel, dof_i, dof_j, ROT, break_iter] = ...
        assemble_prebody(con, EL, U_input, FEM.ANALYSIS.parallelize);
end


% Nodal rotations
FEM.OUT.rot(con(1:length(EL),1),:) = ROT(1:length(EL),1:3);
FEM.OUT.DELTA_rot(con(1:length(EL),1),:) = ROT(1:length(EL),7:9);
FEM.OUT.rot(con(1:length(EL),2),:) = ROT(1:length(EL),4:6);
FEM.OUT.DELTA_rot(con(1:length(EL),2),:) = ROT(1:length(EL),10:12);

% Assemble and set internal forces
Fint_i = Fint_i(:)';
dof_Fint = dof_Fint(:);
Fint = accumarray(dof_Fint, Fint_i); % Accululate internal forces at nodes based on dof
FEM.OUT.Fint_el(:,:,FEM.inc_count + 1) = Fint_i;
FEM.OUT.fint_el(:,:,FEM.inc_count + 1) = fint_i;
FEM.PASS.Fint = Fint;

% Assemble sparse stiffness matrix
if assemble_K == 1
    FEM.PASS.K = sparse(dof_i(:),dof_j(:),Kel(:),n*6,n*6);
end

FEM.EL = EL;

% Break if flexibility iterations haven't converged
if sum(break_iter) > 0
    FEM.break = 1;
end


end







