% %% Test assemble_prebody
% This is a script to test the mex function generated from assemble_prebody

par1 = true;
par2 = false;
n = 20;

tic
for i = 1:n
    [EL, fint_i, Fint_i, dof_Fint, Kel, dof_i, dof_j, ROT, break_iter] = ...
        assemble_prebody_mex(con, EL, U_input, par1);
end
toc

% tic
% for i = 1:n
%     [EL, fint_i, Fint_i, dof_Fint, Kel, dof_i, dof_j, ROT, break_iter] = ...
%         assemble_prebody_mex(con, EL, U_input, par2);
% end
% toc