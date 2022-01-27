function [FEM] = arc_length_solver(FEM)
%ARC_LENGTH_SOLVER
%   Minimize residual
 
% Preallocate and initialize
U = FEM.OUT.U;
F = FEM.MODEL.F;
 
disp_DOF = FEM.PASS.disp_DOF;
rot_DOF = FEM.PASS.rot_DOF;
NR_iter = FEM.ANALYSIS.NR_iter;
NR_iter_count = 1;
tol = FEM.ANALYSIS.tol;
max_iter = FEM.ANALYSIS.max_iter;
F_norm = FEM.PASS.f_norm;
 
DELTA_U = zeros(size(U));
BOUND = logical(FEM.MODEL.B);
not_bound = ~BOUND;

res_error = 1;
assem = 0;
FEM.PASS.assemble = assem;
 
R = FEM.PASS.R;

Fpre = FEM.MODEL.F_pre;
Fpre0 = Fpre;
 
DELTA_lambda = 0;
lambda0 = 0;
lambda = 1;
if FEM.PASS.set_L ~= 1
    L = FEM.PASS.L;
end
 
% Iterate with a arc-length solver
iter = 1;
Unorm_max = 10000;
while res_error > tol && iter <= max_iter && norm(U) < Unorm_max
 
    % Update load correction matrix if follower forces are included
    if (FEM.ANALYSIS.follow)
        Knc = FEM.ANALYSIS.follow_Knc(U,Fpre0 + lambda*F);
        Knc_sparse = Knc(not_bound,not_bound);
        K_BC = FEM.PASS.K_BC - Knc_sparse;
    else
        K_BC = FEM.PASS.K_BC;
    end
 
    % Remove 0 elements of force and stiffness matrix
    R_BC = R(not_bound);
 
    % Calculate displacement increment
    delta_U_BC = K_BC\R_BC; % K_BC 0 rows and cols have already been deleted in apply_bound
 
    % Replace 0 elements in displacement increment
    delta_Ur = zeros(size(U,1),1);
    delta_Ur(not_bound) = delta_U_BC;
 
 
    if iter == 1
        delta_U1 = delta_Ur;
        delta_U1t = delta_U1;
        % delta_U1t(rot_DOF) = 0;
 
        if FEM.PASS.set_L == 1
            L = sqrt(delta_U1'*delta_U1);
            FEM.PASS.L = L;
        end
        delta_lambda = L/sqrt(delta_U1'*delta_U1); % Must update sign of delta_lambda
 
        delta_U = delta_lambda*delta_U1;
    else
        delta_Urt = delta_Ur;
        % delta_Urt(rot_DOF) = 0;
        DELTA_Ut = DELTA_U;
        % DELTA_Ut(rot_DOF) = 0;
 
        A = delta_U1t'*delta_U1t;
        B = 2*(DELTA_Ut + delta_Urt)'*delta_U1t;
        C = (DELTA_Ut + delta_Urt)'*(DELTA_Ut + delta_Urt) - L^2;
 
        delta_lambda1 = (-B + sqrt(B^2 - 4*A*C))/(2*A);
        delta_lambda2 = (-B - sqrt(B^2 - 4*A*C))/(2*A);
 
        theta1 = (DELTA_Ut + delta_lambda1*delta_U1t + delta_Urt)'*DELTA_Ut;
        theta2 = (DELTA_Ut + delta_lambda2*delta_U1t + delta_Urt)'*DELTA_Ut;
 
        % Choose correct root
        if theta1 > 0 && theta2 < 0
            delta_lambda = delta_lambda1;
        elseif theta1 < 0  && theta2 > 0
            delta_lambda = delta_lambda2;
        elseif theta1 > 0 && theta2 > 0
            delta_lambda_lin = -C/B;
            if abs(delta_lambda1 - delta_lambda_lin) > abs(delta_lambda2 - delta_lambda_lin)
                delta_lambda = delta_lambda1;
            else
                delta_lambda = delta_lambda2;
            end
        end
 
        % delta_lambda = 0;
        delta_U = delta_lambda*delta_U1 + delta_Ur;
 
        if (B^2 - 4*A*C) < 0 % Newton solver
            if (FEM.ANALYSIS.warning)
                warning('Imaginary cutback')
            end
            delta_U = delta_Ur;
            delta_lambda = 0;
            % break
        end
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
 
    % Assembly flag
    if NR_iter_count < NR_iter
        assem = 0;
        NR_iter_count = NR_iter_count + 1;
    else
        assem = 1;
        NR_iter_count = 1;
    end
    FEM.PASS.assemble = assem;
 
    % Obtain the internal force vector and update the stiffness matrix
    [FEM] = assemble(FEM);
    Fint = FEM.PASS.Fint;
 
    % State determination cutback
    if FEM.break == 1
        break
    end
 
    % Apply boundaries
    if assem == 1
        [FEM] = apply_bound(FEM);
    end
 
    % Update rotation DOFs
    rot = FEM.OUT.rot';
    U(rot_DOF) = rot(:);
    FEM.OUT.U = U;
 
    DELTA_rot = FEM.OUT.DELTA_rot';
    DELTA_U(rot_DOF) = DELTA_rot(:);
    FEM.OUT.DELTA_U = DELTA_U;
 
    % Update the residual vector
    if FEM.ANALYSIS.follow
        Fpre = FEM.ANALYSIS.follow_F(U,Fpre0);
        Fext = FEM.ANALYSIS.follow_F(U,lambda*F); % Needs testing
    else
        Fext = lambda*F;
    end

    % Determine the normalized residual error
    R = Fext + Fpre - Fint;
    R(BOUND) = 0;
    res_error = norm(R)/F_norm;
 
    % Update iteration counter
    FEM.PASS.iter_i = iter;
    iter = iter + 1;
 
    if isnan(res_error) == 1
        break
    end
 
    % Plot each iteration for debugging
    if (FEM.PLOT.plot_iter)
        FEM.MODEL.F = Fext;
        FE_plot(FEM)
        eval(FEM.PLOT.plot_shape)
    end
 
    % Display redidual error
    if(FEM.ANALYSIS.res_error_info)
        disp(res_error)
    end
 
end
 
if norm(U) > Unorm_max
    if (FEM.ANALYSIS.warning)
        warning('Dispacement increment too large, Unorm = %g',norm(U))
    end
end
 
% If the maximum number of iterations has been reached
if iter == max_iter + 1 && res_error > tol
    if (FEM.ANALYSIS.warning)
        warning('MAX_ITER has been reached without convergence - arc-length solver')
    end
end
 
 
FEM.MODEL.R = R;
FEM.PASS.res_error = res_error;
FEM.PASS.lambda = lambda;
FEM.PASS.DELTA_lambda = DELTA_lambda;
FEM.PASS.Fext = lambda*F + Fpre; % Fint; %

end
 
