% %% Test assemble_body
% This is a script to test the mex function generated from assemble_body



[el_out, fint_ii, Fint_ii, el_dof, Kel_out, dof_i, dof_j, ROT_out,  break_iter] = ...
    assemble_body(con, EL, U_input);