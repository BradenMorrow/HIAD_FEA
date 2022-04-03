function [FEM] = run_analysis(FEM)
%FE_SOLVER
%   Run FE analysis, cutback load step if needed

% Initialize variables
F_norm = 0;

% Initialize
BOUND = logical(FEM.MODEL.B);
F = FEM.MODEL.F;
U = zeros(size(F));
FEM.OUT.delta_U = zeros(size(F));
FEM.OUT.DELTA_U = zeros(size(F));
FEM.OUT.U0 = zeros(size(F));
cut = 0;
FEM.iter = 1;
max_iter = FEM.ANALYSIS.max_iter; % Maximum number of iterations per increment
tol = FEM.ANALYSIS.tol; % Allowable residual error
d_inc = .5;
control = FEM.ANALYSIS.control;
res_error = 1;

LAMBDA0 = FEM.LAMBDA.current_LAMBDA; % Set the current increment size
min_inc_size = FEM.ANALYSIS.min_inc_size; % Minimum acceptable increment size

% DOF indices for adding incremental displacements and rotations
FEM.PASS.disp_DOF = sort([1:6:size(U,1) 2:6:size(U,1) 3:6:size(U,1)])';
FEM.PASS.rot_DOF = sort([4:6:size(U,1) 5:6:size(U,1) 6:6:size(U,1)])';

% Store starting configuration
FEM.PASS.assemble = 1;
FEM.PASS.iter_i = 1;
FEM0 = FEM;

while (res_error > tol || FEM.iter > max_iter || F_norm == 1 || isnan(res_error)) && (FEM.ANALYSIS.cutback || cut == 0) % If step converged or only one pass
    %% PRE
    % Update counter
    cut = cut + 1;

    d_inc = d_inc*2; % Calculate the size of an increment
    inc_size = LAMBDA0/d_inc; % Calculate the total relative increment size

    % Abort progam if increment size is less than the minimum acceptable increment szie
    if inc_size <= min_inc_size
        save('FEM_min_cutback','FEM')
        warning(['Model has not converged with an increment size of ' num2str(min_inc_size)])

        FEM = FEM0;
        FEM.PASS.min_inc_break = true;
        break
    end

    if cut == 1
        % Assemble the stiffness matrix based on current displacement
        [FEM] = assemble(FEM);
        
        % Apply boundary conditions and store the starting configuration
        [FEM] = apply_bound(FEM);
        FEM0 = FEM;
    else
        % Reset to the stored starting configuration
        FEM = FEM0;
    end

    FEM.ANALYSIS.d_inc = d_inc;
    DELTA_lambda = 1/d_inc;
    FEM.PASS.DELTA_lambda = DELTA_lambda;
    FEM.PASS.lambda = DELTA_lambda;

    if control == 2 % For Newton solver
        R = F*DELTA_lambda;
    elseif control == 3 % For arc-length control
        R = F;
        if FEM.PASS.set_L ~= 1
            FEM.PASS.L = FEM.PASS.L*DELTA_lambda;
        end
    elseif control == 4 % For Enforce displacement control
        FEM.MODEL.U0 = FEM.MODEL.U0*DELTA_lambda;
        FEM.OUT.U = FEM.OUT.U + FEM.MODEL.U0;
    end

    R(BOUND) = 0; % Set the boudaries to 0
    FEM.PASS.R = R;
    FEM.PASS.Fext = R;


    %% SOLVER
    if control == 1
        [FEM] = displacement_solver(FEM);
    elseif control == 2
        [FEM] = newton_solver(FEM);
    elseif control == 3
        [FEM] = arc_length_solver(FEM);
    elseif control == 4
        [FEM] = enforce_displacement_solver(FEM);
    end

    %% POST
    % Store step displacement, internal force vector and iterations
    FEM.OUT.Uinc(:,FEM.inc_count + 1) = FEM.OUT.U;
    FEM.OUT.Finc(:,FEM.inc_count + 1) = FEM.PASS.Fint;
    FEM.OUT.Fext_inc(:,FEM.inc_count + 1) = FEM.PASS.Fext;

    res_error = FEM.PASS.res_error;

    if FEM.break == 1
        FEM.break = 0;
        FEM.iter = max_iter + 1;
    end
end

% Plot each increment
if (FEM.PLOT.plot_inc)
    % FE_plot(FEM)
    eval(FEM.PLOT.plot_shape)
end

FEM.cut = cut;

end
