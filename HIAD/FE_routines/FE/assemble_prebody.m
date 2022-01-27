function [EL, fint_i, Fint_i, dof_Fint, Kel, dof_i, dof_j, ROT, break_iter] = assemble_prebody(con, EL, U_input, par)


% Preallocate for parfor loop
fint_i = zeros(12,size(EL,1));
Fint_i = zeros(12,size(EL,1));
break_iter = zeros(size(EL,1),1);
dof_i = zeros(144,size(EL,1));
dof_j = zeros(144,size(EL,1));
Kel = zeros(144,size(EL,1));
dof_Fint = zeros(12, size(EL,1));
ROT = zeros(size(EL,1),12); % Colums 1:3 = roti, 4:6 = rotj, 7:9 = DELTA_roti, 10:12 = DELTA_rotj


if (par)
    parfor i = 1:size(EL,1)
        [EL(i).el_in0, fint_i(:,i), Fint_i(:,i), dof_Fint(:,i), Kel(:,i), dof_i(:,i), dof_j(:,i), ROT(i,:), break_iter(i)] = ...
            assemble_body( con(i,:), EL(i), U_input(i,:,:));
    end
else
    for i = 1:size(EL,1)
        [EL(i).el_in0, fint_i(:,i), Fint_i(:,i), dof_Fint(:,i), Kel(:,i), dof_i(:,i), dof_j(:,i), ROT(i,:), break_iter(i)] = ...
            assemble_body( con(i,:), EL(i), U_input(i,:,:));
    end
end
