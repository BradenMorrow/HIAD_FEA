function [FEM] = newton_solver(FEM)
%Iterates until the convergence of the increment is found or the maximum
%number of interations is reached.

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

% if FEM.inc_count == 1
%     max_iter = 40;
% end



f_norm = FEM.PASS.f_norm;
if f_norm == 0
    f_norm = 1;
end

lambda = FEM.PASS.lambda;
F0 = FEM.MODEL.F*lambda;

if (FEM.ANALYSIS.follow)
    R = FEM.ANALYSIS.follow_F(U,FEM.MODEL.F*lambda);
else
    R = FEM.MODEL.F*lambda;
end

R(BOUND) = 0;


Fext = R;
Fpre = FEM.MODEL.F_pre;
Fpre0 = Fpre;

FEM.PASS.assemble = 1; % Stiffness matrix assembly flag
% assem = 1;

% Iterate with a Newton solver
res_error = 1;
iter = 1;
FEM.PASS.iter = 1;

%%
Unorm_max = 10000;
while res_error > tol && iter <= max_iter && norm(U) < Unorm_max
    % Update load correction matrix if follower forces are included
    if (FEM.ANALYSIS.follow)
        Knc = FEM.ANALYSIS.follow_Knc(U,Fpre0 + F0);
        Knc_sparse = Knc(not_bound,not_bound);
        K_BC = FEM.PASS.K_BC - Knc_sparse;
    else
        K_BC = FEM.PASS.K_BC;
    end
    
    % Remove bound DOFs from residual vector
    R_BC = R(not_bound);
    
    % Calculate displacement increment
    delta_U_BC = K_BC\R_BC; % K_BC bound DOF rows and cols have been removed in apply_bound

    % Replace bound DOFs in displacement vector
    delta_U = zeros(size(U,1),1);
    delta_U(not_bound) = delta_U_BC;
    
    % Update displacement
    U(disp_DOF) = U(disp_DOF) + delta_U(disp_DOF);
    FEM.OUT.U = U;
    FEM.OUT.delta_U = delta_U;

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
    
    % Apply boundaries to stiffness matrix
    if assem == 1
        [FEM] = apply_bound(FEM);
    end

    % Update rotation DOFs (rotation DOFs are not addative)
    rot = FEM.OUT.rot';
    U(rot_DOF) = rot(:);
    FEM.OUT.U = U;

    % Update the residual vector if follower forces are included
    if (FEM.ANALYSIS.follow)
        Fpre = FEM.ANALYSIS.follow_F(U,Fpre0);
        Fext = FEM.ANALYSIS.follow_F(U,F0);
        
        FEM.MODEL.F = Fext; % Update external force
    end
    
    % Determine the normalized residual error
    R = Fext + Fpre - Fint;
    R(BOUND) = 0;
    res_error = norm(R)/f_norm;

    
    % Break if the residual is NAN
    if isnan(res_error) == 1
        if (FEM.ANALYSIS.warning)
            warning('Residual error is NAN')
        end
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
    
    % Update iteration counter
    FEM.PASS.iter_i = iter;
    iter = iter + 1;
end

if norm(U) > Unorm_max
    if (FEM.ANALYSIS.warning)
        warning('Dispacement increment too large, Unorm = %g',norm(U))
    end
end

% If the maximum number of iterations has been reached
if iter == max_iter + 1 && res_error > tol
    if (FEM.ANALYSIS.warning)
        warning('MAX_ITER has been reached without convergence - Newton solver')
    end
end

% Update values
FEM.MODEL.R = R;
FEM.PASS.res_error = res_error;
FEM.PASS.Fext = Fext + Fpre;

% For arc-length solver
if FEM.PASS.set_L == 1
    FEM.PASS.L = sqrt(U'*U);
end

if isnan(sum(U))
    a = 1;
end

end




