function [FEM] = assemble(FEM)
%ASSEMBLE
%   Loop through elements and assemble the stiffness matrix

% Extract elements
EL = FEM.EL;

% Extract displacement variables
U = FEM.OUT.U;
delta_U = FEM.OUT.delta_U;
DELTA_U = FEM.OUT.DELTA_U;
U0 = FEM.OUT.U0;

% Reorganize displacements
ind = 1:6:size(U,1);
ind = [ind ind + 1 ind + 2 ind + 3 ind + 4 ind + 5]';
U2 = zeros(length(U)/6,6);
U2(:) = U(ind);
DELTA_U2 = zeros(length(U)/6,6);
DELTA_U2(:) = DELTA_U(ind);
delta_U2 = zeros(length(U)/6,6);
delta_U2(:) = delta_U(ind);
U02 = zeros(length(U)/6,6);
U02(:) = U0(ind);

n = size(FEM.MODEL.nodes,1);
% % % U2 = zeros(n,6);
% % % for j = 1:6
% % %     U2(:,j) = U(j:6:length(U));
% % %     DELTA_U2(:,j) = DELTA_U(j:6:length(U));
% % %     delta_U2(:,j) = delta_U(j:6:length(U));
% % %     U02(:,j) = U0(j:6:length(U));
% % % end

% Initialize output variables
FEM.PASS.K = spalloc(6*n,6*n,1); % zeros(6*n);
FEM.OUT.rot = zeros(n,3);
FEM.OUT.DELTA_rot = zeros(n,3);
Fint = zeros(size(U));


% Loop through each element
tic
for i = 1:length(EL)
    % Element connectivity
    con = EL(i).el_in.connect_ij;
    con(con == 0) = [];
    
    % Element nodal displacements
    U_in.U0 = [U02(con(1),:)
        U02(con(2),:)];
    U_in.U = [U2(con(1),:)
        U2(con(2),:)];
    U_in.delta_U = [delta_U2(con(1),:)
        delta_U2(con(2),:)];
    U_in.DELTA_U = [DELTA_U2(con(1),:)
        DELTA_U2(con(2),:)];
    
    % General element inputs
    el_in = EL(i).el_in;
    
    % Nodal locations and orientation
    el_in.nodes_ij = [FEM.MODEL.nodes(con(1),:)
        FEM.MODEL.nodes(con(2),:)];
    el_in.orient_ij = [FEM.MODEL.orientation(con(1),:)
        FEM.MODEL.orientation(con(2),:)];
    
    % Element specific inputs
    el_in0 = EL(i).el_in0;
    
    el_in0.el = i;
    el_in0.iter = FEM.PASS.iter_i;
    el_in0.inc = FEM.inc_count;
    
    if i == 32 && FEM.inc_count >= 16
        % a = 1;
    end
    
    % Run element routines    
    [Kel,fint_i,Fint_i,ROT,el_out] = EL(i).el(U_in,el_in,el_in0);
    FEM.EL(i).el_in0 = el_out;
    
    % Break if flexibility iterations haven't converged
    if el_out.break == 1
        FEM.break = 1;
        i = length(EL);
    end
    
    % Add global element stiffness matrix to system stiffness matrix
    if FEM.PASS.assemble == 1
        [FEM.PASS.K] = add_Kel(FEM.PASS.K,Kel,con);
    end
    
    % Add element internal force vector to global internal force vector
    start1 = con(1)*6 - 5;
    start2 = con(2)*6 - 5;
    Fint(start1:start1 + 5) = Fint(start1:start1 + 5) + Fint_i(1:6);
    Fint(start2:start2 + 5) = Fint(start2:start2 + 5) + Fint_i(7:12);
    FEM.PASS.Fint = Fint;
    
    FEM.OUT.Fint_el(:,i,FEM.ANALYSIS.step + 1) = Fint_i;
    FEM.OUT.fint_el(:,i,FEM.ANALYSIS.step + 1) = fint_i;
    
    % Nodal rotations
    FEM.OUT.rot(con(1),:) = ROT.rot(1,:);
    FEM.OUT.DELTA_rot(con(1),:) = ROT.DELTA_rot(1,:);
    FEM.OUT.rot(con(2),:) = ROT.rot(2,:);
    FEM.OUT.DELTA_rot(con(2),:) = ROT.DELTA_rot(2,:);
    
    if isnan(sum(fint_i))
        a = 1;
    end
%     toc
%     tic
end

toc
end


