function [Kel_sp] = add_Kel_par(Kel,con)
%ADD_KEL
%   Assemble the system stiffness matrix from global element stiffness
%   matrices

% Sizes
num_nodes = length(con);
dof_per_node = length(Kel)/num_nodes;

% Start with the first node to create el_dof, which is a vector of integers
% containing the DOF to which the element contributes
start_dof = (con(1) - 1)*dof_per_node + 1;
el_dof = zeros(1,dof_per_node*num_nodes);
el_dof(1:dof_per_node) = start_dof:(start_dof + dof_per_node - 1);

% Loop over the rest of the nodes -- will work with any number of nodes
for j = 2:num_nodes
    start_dof = (con(j) - 1)*dof_per_node + 1;
    el_dof(dof_per_node*(j - 1) + 1:dof_per_node*j) = ...
        start_dof:(start_dof + dof_per_node - 1);
end

ind_j = [1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12
    1 2 3 4 5 6 7 8 9 10 11 12];
ind_i = ind_j';

Kel_sp = [el_dof(ind_i(:))' el_dof(ind_j(:))'];

% Add element K to the system K using el_dof as an index vector
% K(el_dof,el_dof) = K(el_dof,el_dof) + Kel;
end

