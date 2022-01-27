function [FEM] = enforce_displacement_solver(FEM)
%ARC_LENGTH_SOLVER
%   Minimize residual

% Preallocate and initialize
U = FEM.OUT.U;
U0 = FEM.MODEL.U0;


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

F_pre = FEM.MODEL.F_pre;

res_error = 1;
R = -FEM.PASS.K*U0; % F_pre - FEM.PASS.Fint; % 
R(BOUND) = 0;

% Iterate with a Newton solver
iter = 1;
while res_error > tol && iter <= max_iter && norm(U) < 1000
    K_BC = FEM.PASS.K_BC;
    
    %Remove 0 elements of force and stiffness matrix
    R_sparse = R(not_bound);
    
    % Calculate displacement increment
    delta_U_sparse = K_BC\R_sparse; %K_BC 0 rows and cols have already been deleted in apply_bound

    %Replace 0 elements in displacement increment
    delta_U = zeros(size(U,1),1);
    delta_U(not_bound) = delta_U_sparse;
    
    % lambda0 is the previously converged lambda
    % lambda is the total lambda
    % DELTA_lambda is the step change in lambda
    % delta_lambda is the itteration change in lambda

    % U0 is the previously converged U
    % U is total U
    % DELTA_U is the step change in U
    % delta_U is the itteration change in U
    
    DELTA_U(disp_DOF) = DELTA_U(disp_DOF) + delta_U(disp_DOF);

    % Update displacement
    U(disp_DOF) = U(disp_DOF) + delta_U(disp_DOF);
    FEM.OUT.U = U;
    FEM.OUT.delta_U = delta_U;
    FEM.OUT.DELTA_U = DELTA_U;
    
    % Obtain the internal force vector and update the stiffness matrix if
    % needed
    [FEM] = assemble(FEM);
    Fint = FEM.PASS.Fint;

        % Assembly flag
    if NR_iter_count < NR_iter
        assem = 0;
        NR_iter_count = NR_iter_count + 1;
    else
        assem = 1;
        NR_iter_count = 1;
    end
    FEM.PASS.assemble = assem;

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
    R = F_pre - Fint;
    R(BOUND) = 0;
    
    % % % %%%
    % % % R(169:180) = 0;
    
    res_error = norm(R)/F_norm;

    % Update iteration counter
    FEM.PASS.iter_i = iter;
    iter = iter + 1;
    

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
    
    
% % %     disp(FEM.EL(18).el_in0.K0)
% % %     disp(FEM.EL(18).el_in0.flex.e)
% % %     disp(interp1(FEM.EL(18).el_in0.nodes(1).cords(1).axial(:,2),FEM.EL(18).el_in0.nodes(1).cords(1).axial(:,1),FEM.EL(18).el_in0.flex.e))
% % %     disp(FEM.EL(18).el_in0.flex.D)
% % %     disp(FEM.EL(18).el_in0.flex.d)

end

% If the maximum number of iterations has been reached
if res_error > tol
    if (FEM.ANALYSIS.warning)
        warning('MAX_ITER has been reached without convergence - Enforce displacement solver')
    end
end

% Update values
FEM.MODEL.R = R;
FEM.PASS.res_error = res_error;

Fext0 = Fint;
Fext0(~BOUND) = 0;
Fext0(U0 == 0) = 0;
F_pre(BOUND) = 0;
FEM.PASS.Fext = Fext0 + F_pre;

end

