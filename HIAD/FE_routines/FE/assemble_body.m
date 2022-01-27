function [ el_out, fint_ii, Fint_ii, el_dof, Kel_out, dof_i, dof_j, ROT_out,  break_iter] = ...
    assemble_body( con, EL, U_input)
%The loop body for the assemble function
%   Calls element functions and assembles element K matrices.
%   Sets the nodal dof locations to assemble global K matrix.
%   Prepares the internal force vector to be assembled.
%   Desgined for 2 node elements with 6 dof per node.


% Element nodal displacements
U_in.U0 = [U_input(:,1:6,1); U_input(:,7:12,1)];
U_in.U = [U_input(:,1:6,2); U_input(:,7:12,2)];
U_in.delta_U = [U_input(:,1:6,3); U_input(:,7:12,3)];
U_in.DELTA_U = [U_input(:,1:6,4); U_input(:,7:12,4)];

% Prepare internal force vector (where the internal force vector will be added to)
el_dof1 = (con(1)*6-5):(con(1)*6);
el_dof2 = (con(2)*6-5):(con(2)*6);
el_dof_temp = (cat(2,el_dof1,el_dof2))';
el_dof = el_dof_temp(:);


switch EL.el
    case 'el1_nonlin'
        [Kel_out_fun,fint_ii,Fint_ii,ROT,el_out] = el1_nonlin(U_in, EL.el_in, EL.el_in0);
    case 'el1'
        [Kel_out_fun,fint_ii,Fint_ii,ROT,el_out] = el1(U_in, EL.el_in, EL.el_in0);
    case 'el2'
        [Kel_out_fun,fint_ii,Fint_ii,ROT,el_out] = el2(U_in, EL.el_in, EL.el_in0);
    case 'el3'
        [Kel_out_fun,fint_ii,Fint_ii,ROT,el_out] = el3(U_in, EL.el_in, EL.el_in0);
    otherwise
        [Kel_out_fun,fint_ii,Fint_ii,ROT,el_out] = el4(U_in, EL.el_in, EL.el_in0);
end


% Store element function outputs
ROT_out = zeros(1,12);
ROT_out(1:3) = ROT.rot(1,:);
ROT_out(4:6) = ROT.rot(2,:);
ROT_out(7:9) = ROT.DELTA_rot(1,:);
ROT_out(10:12) = ROT.DELTA_rot(2,:);
break_iter = el_out.break;

% Add global element stiffness matrix to system stiffness matrix
    temp2 = repmat(el_dof', 12,1);
    dof_i = repmat(el_dof,12,1);
    dof_j = temp2(:);
    
    Kel_out = Kel_out_fun(:);

end
