function [FEM] = displacement_solver(FEM)
%ARC_LENGTH_SOLVER
%   Minimize residual

% Preallocate and initialize
U = FEM.OUT.U;
BOUND = logical(FEM.MODEL.B);
not_bound = ~BOUND;

disp_DOF = FEM.PASS.disp_DOF;
rot_DOF = FEM.PASS.rot_DOF;

NR_iter = FEM.ANALYSIS.NR_iter;
NR_iter_count = 1;
tol = FEM.ANALYSIS.tol;
max_iter = FEM.ANALYSIS.max_iter;
f_norm = FEM.PASS.f_norm;


DELTA_U = zeros(size(U));
F_pre = FEM.MODEL.F_pre;


res_error = 1;
assem = 0;
FEM.PASS.assemble = assem;

Dinc = FEM.MODEL.Dinc/FEM.ANALYSIS.d_inc;
Fr = FEM.MODEL.Fr;


R = Fr;
b = zeros(size(U));
b(FEM.MODEL.Di) = 1;

DELTA_lambda = 0;
lambda0 = 0;


% Iterate with a displacement solver
iter = 0;
while res_error > tol && iter <= max_iter && norm(U) < 100
    % Update iteration counter
    iter = iter + 1;
    FEM.PASS.iter_i = iter;
    
    % Update load correction matrix if follower forces are included
    if (FEM.ANALYSIS.follow)
        Knc = FEM.ANALYSIS.follow_Knc(U,F_pre + F0);
% % % %         Knc = FEM.ANALYSIS.follow_Knc(U,Fr + F0);
% % % %         eval(FEM.ANALYSIS.follow_Knc)
        Knc_sparse = Knc(not_bound,not_bound);%remove boundary conditions from Knc
        K_BC = FEM.PASS.K_BC - Knc_sparse;
    else
        K_BC = FEM.PASS.K_BC;
    end
    
    
    %Remove 0 elements of force and stiffness matrix
    R_BC = R(not_bound);
    
    % Calculate displacement increment
    delta_U_BC = K_BC\R_BC; %K_BC 0 rows and cols have already been deleted in apply_bound

    %Replace 0 elements in displacement increment
    delta_U = zeros(size(U,1),1);
    delta_U(not_bound) = delta_U_BC;
    

    % With constraint calculate delta_lambda and delta_U
    if iter == 1
        delta_U1 = delta_U;
        delta_lambda = Dinc/(b'*delta_U);
        delta_U = delta_lambda*delta_U1;
    else
        delta_lambda = -b'*delta_U/(b'*delta_U1);
        delta_U = delta_lambda*delta_U1 + delta_U;
    end
    
    
    
    
    % Update U and lambda
    % 
    % lambda0 is the previously converged lambda
    % lambda is the total lambda
    % DELTA_lambda is the step change in lambda
    % delta_lambda is the itteration change in lambda

    % U0 is the previously converged U
    % U is total U
    % DELTA_U is the step change in U
    % delta_U is the itteration change in U
    
    DELTA_lambda = DELTA_lambda + delta_lambda;
    lambda = lambda0 + DELTA_lambda;
    DELTA_U(disp_DOF) = DELTA_U(disp_DOF) + delta_U(disp_DOF);

    % Update displacement
    U(disp_DOF) = U(disp_DOF) + delta_U(disp_DOF);
    FEM.OUT.U = U;
    FEM.OUT.delta_U = delta_U;
    FEM.OUT.DELTA_U = DELTA_U;

    % Obtain the internal force vector and update the stiffness matrix
    [FEM] = assemble(FEM);
    Fint = FEM.PASS.Fint;

    if assem == 1
        [FEM] = apply_bound(FEM);
    end

    % Assembly flag
    if NR_iter_count < NR_iter
        assem = 0;
        NR_iter_count = NR_iter_count + 1;
    else
        assem = 1;
        NR_iter_count = 1;
    end
    FEM.PASS.assemble = assem;

    % Update rotation DOFs
    rot = FEM.OUT.rot';
    U(rot_DOF) = rot(:);
    FEM.OUT.U = U;

    DELTA_rot = FEM.OUT.DELTA_rot';
    DELTA_U(rot_DOF) = DELTA_rot(:);
    FEM.OUT.DELTA_U = DELTA_U;

    % Update the residual vector
    Fext = lambda*Fr;
    
    % Determine the normalized residual error
    R = Fext + F_pre - Fint; 
    R(BOUND) = 0;
    res_error = norm(R)/f_norm;

    if iter == max_iter + 1
        if (FEM.ANALYSIS.warning)
            warning('MAX_ITER has been reached - displacement solver')
        end
    end

    if isnan(res_error) == 1
        break
    end

    % Plot each iteration for debugging
    if (FEM.PLOT.plot_iter)
        eval(FEM.PLOT.plot_shape)
        FE_plot(FEM)
    end
    
    % Display redidual error
    if(FEM.ANALYSIS.res_error_info)
        disp(res_error)
    end
    
end

FEM.iter = iter;

FEM.MODEL.R = R;
FEM.PASS.res_error = res_error;
FEM.PASS.lambda = lambda;
FEM.PASS.DELTA_lambda = DELTA_lambda;
FEM.PASS.Fext = Fext + F_pre;

end

