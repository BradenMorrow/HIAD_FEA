function [ Fint_sp ] = add_Fint_par( con )
%Sets up the internal force vectors to be stored

dof_per_node = 6;
num_nodes = 2;
el_dof = zeros(1,dof_per_node*num_nodes);

% Start with the first node to create el_dof, which is a vector of integers
% containing the DOF to which the element contributes
start_dof = (con(1) - 1)*dof_per_node + 1;
el_dof(1:dof_per_node) = start_dof:(start_dof + dof_per_node - 1);

% Loop over the rest of the nodes -- will work with any number of nodes
for j = 2:num_nodes
    start_dof = (con(j) - 1)*dof_per_node + 1;
    el_dof(dof_per_node*(j - 1) + 1:dof_per_node*j) = ...
        start_dof:(start_dof + dof_per_node - 1);
end


Fint_sp = el_dof';

end