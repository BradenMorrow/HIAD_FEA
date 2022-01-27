function [FEM] = FE_solver(FEM)
%FE_SOLVER
%   Drives solver

%% Extract variables and preallocate
% Geometry and configuration
connect = FEM.MODEL.connect;
B = FEM.MODEL.B;
F = FEM.MODEL.F;

% Solver and analysis - extract variables
d_inc = FEM.ANALYSIS.d_inc; % Starting number of loading increments
control = FEM.ANALYSIS.control; % 3 - arc-length solver
max_inc = FEM.ANALYSIS.max_inc; % Maximum number of increments
max_iter = FEM.ANALYSIS.max_iter; % Maximum number of iterations per increment
tol = FEM.ANALYSIS.tol; % Residual error
Dmax = FEM.ANALYSIS.Dmax; % Absolute maximum displacement
DOF = FEM.ANALYSIS.DOF; % DOF/node

% Preallocate and initialize
if FEM.ANALYSIS.step == 1 % For the first step
    U = FEM.OUT.U; % Displacement
    FEM.PASS.NR_inc_count = 1;

    FEM.OUT.Uinc = zeros(size(U,1),d_inc); % Increment variables
    FEM.OUT.Finc = zeros(size(U,1),d_inc);
    FEM.OUT.Fext_inc = zeros(size(U,1),d_inc);
    
    FEM.OUT.iter = zeros(d_inc,1);
    FEM.OUT.Fint_el = zeros(DOF*2,size(connect,1),2);
    FEM.OUT.fint_el = zeros(DOF*2,size(connect,1),2);

    FEM.OUT.D0 = zeros(6,size(connect,1));
    FEM.OUT.D = zeros(6,size(connect,1));
    FEM.OUT.P0 = zeros(6,size(connect,1));
    FEM.OUT.P = zeros(6,size(connect,1));
    
    i = 0;
    inc_count = i;
    res_error = 1;

else % For all other steps
    U = FEM.OUT.U;
    i = 0;
    res_error = 1;
    
    inc_count = FEM.inc_count;
    
    
end

% Displacement
U0 = U;
FEM.OUT.U0 = U;
FEM.OUT.delta_U = zeros(size(U));
FEM.OUT.DELTA_U = zeros(size(U));

% Total force normal
f_norm = FEM.PASS.f_norm;
F_norm = 0;

% Load increment variables
FEM.PASS.lambda0 = 0;
DELTA_lambda = (1/d_inc);
FEM.PASS.DELTA_lambda = DELTA_lambda;
DELTA_lambda0 = DELTA_lambda;
cutback_count = 1;
conv_it = 1;


% DOF indices for adding incremental displacements and rotations
FEM.PASS.disp_DOF = sort([1:6:size(U,1) 2:6:size(U,1) 3:6:size(U,1)])';
FEM.PASS.rot_DOF = sort([4:6:size(U,1) 5:6:size(U,1) 6:6:size(U,1)])';

% % % % Saved values for inflatable members
% % % if FEM.ANALYSIS.control == 3 && FEM.ANALYSIS.analysis == 3
% % %     for j = 1:length(FEM.CONFIG)
% % %         FEM.CONFIG(j).y_bar0 = FEM.CONFIG(j).y_bar;
% % %         FEM.CONFIG(j).EI0 = FEM.CONFIG(j).EI;
% % %     end
% % % end

%% LOOP STEPS
while F_norm < f_norm && isnan(F_norm) ~= 1 && max(abs(U)) <= abs(Dmax) && i < max_inc || res_error > tol || isnan(res_error) == 1
    % Update counter
    i = i + 1;
    FEM.i = i;
    inc_count = inc_count + 1;
    
    % For the first step...
    if i == 1
        % Increment force vector
        DELTA_lambda = 1/d_inc;
        FEM.PASS.DELTA_lambda = DELTA_lambda;
        FEM.PASS.lambda = DELTA_lambda;
        
        R = F*DELTA_lambda;
        R(B == 1) = 0;
        FEM.PASS.R = R;
        FEM.PASS.Fext = R;
        
        % Assemble the stiffness matrix based on current displacement
        FEM.PASS.assemble = 1;
        FEM.PASS.first_flag = 1;
        [FEM] = assemble(FEM);
        FEM.PASS.first_flag = 0;
        
% % %         % Saved values for inflatable members
% % %         if FEM.ANALYSIS.analysis == 3
% % %             for j = 1:length(FEM.CONFIG)
% % %                 FEM.CONFIG(j).EI = FEM.CONFIG(j).EI1;
% % %                 FEM.CONFIG(j).y_bar = zeros(size(FEM.CONFIG(j).y_bar));
% % %             end
% % %         end
        
        % apply boundary conditions -- generates the matrix K_BC
        [FEM] = apply_bound(FEM);
        K_BC_store = FEM.PASS.K_BC;
        
        
    % For all other steps...
    else
        % If the previous step did not converge...
        if iter >= max_iter || F_norm == 1 || res_error > tol || isnan(res_error) == 1
            
            % Reset to previous step
            i = i - 1;
            FEM.i = i;
            inc_count = inc_count - 1;
            
            % If back to the first step...
            if i == 1
                % Reset values
                U = U0;
                FEM.OUT.U = U;
                DELTA_U = zeros(size(U));
                FEM.OUT.DELTA_U = DELTA_U;
                FEM.OUT.delta_U = zeros(size(U));
                
                % For inflatable members
                if FEM.ANALYSIS.analysis == 3
                    for j = 1:length(FEM.CONFIG)
                        FEM.CONFIG(j).y_bar = FEM.CONFIG(j).y_bar0;
                        FEM.CONFIG(j).EI = FEM.CONFIG(j).EI0;
                        
                        FEM.CONFIG(j).element = FEM.CONFIG(j).element0;
                    end
                end
                
                FEM.OUT.D0 = FEM.OUT.D00;
                FEM.OUT.P0 = FEM.OUT.P00;
                
                
                % Reduce first force increment
                d_inc = d_inc*2;
                FEM.ANALYSIS.d_inc = d_inc;
                DELTA_lambda = 1/d_inc;
                conv_it = conv_it + 1;
                FEM.PASS.DELTA_lambda = DELTA_lambda;
                FEM.PASS.lambda = DELTA_lambda;
                
                if FEM.ANALYSIS.control == 4 % For arc-length control
                    FEM.PASS.L = FEM.PASS.L/2;
                end
                
                FEM.MODEL.Dinc = FEM.MODEL.Dinc*DELTA_lambda; % For displacement control of the force vector
                
                % % % FEM.PASS.DELTA_W = FEM.PASS.DELTA_W/2; % For work control
                
                % Update loading
                R = F*(1/d_inc);
                R(B == 1) = 0;
                FEM.PASS.R = R;
                FEM.PASS.Fext = R;
                
                % Restore initial stiffness matrix
                FEM.PASS.K_BC = K_BC_store;
                
                
                

% % %                 % Assemble the stiffness matrix based on current displacement
% % %                 FEM.PASS.assemble = 1;
% % %                 FEM.PASS.first_flag = 1;
% % %                 
% % %                 [FEM,~] = assemble_stiff_Fint(FEM);
% % %                 
% % %                 FEM.PASS.first_flag = 0;
% % % 
% % %                 if FEM.ANALYSIS.analysis == 3
% % %                     for j = 1:length(FEM.CONFIG)
% % %                         FEM.CONFIG(j).EI = FEM.CONFIG(j).EI1;
% % %                         FEM.CONFIG(j).y_bar = zeros(size(FEM.CONFIG(j).y_bar));
% % %                     end
% % %                 end
% % % 
% % %                 % apply boundary conditions -- generates the matrix K_BC
% % %                 [FEM] = apply_bound(FEM);
% % %                 K_BC_store = FEM.PASS.K_BC;
        
                
            % For all other steps...
            else
                % Reset values
                U = U0;
                FEM.OUT.U = U;
                FEM.OUT.U0 = U0;
                
                DELTA_U = zeros(size(U));
                FEM.OUT.DELTA_U = DELTA_U;
                FEM.OUT.DELTA_rot = zeros(size(FEM.OUT.DELTA_rot));
                
                % For inflatable members
                if FEM.ANALYSIS.control == 3 && FEM.ANALYSIS.analysis == 3
                    for j = 1:length(FEM.CONFIG)
                        FEM.CONFIG(j).y_bar = FEM.CONFIG(j).y_bar0;
                        FEM.CONFIG(j).EI = FEM.CONFIG(j).EI0;
                    end
                end
                
                % Reduce force increment
                d_inc = d_inc*2;
                FEM.ANALYSIS.d_inc = d_inc;
                
                DELTA_lambda = DELTA_lambda_store/conv_it;
                conv_it = conv_it + 1;
                FEM.PASS.DELTA_lambda = DELTA_lambda;
                FEM.PASS.lambda = lambda0 + DELTA_lambda;
                FEM.PASS.L = FEM.PASS.L/2;
                
                FEM.MODEL.Dinc = Dinc*DELTA_lambda;
                
                % % % FEM.PASS.DELTA_W0 = FEM.PASS.DELTA_W0/2; % For work control
                
                % Update loading
                R = F*DELTA_lambda;
                R(B == 1) = 0;
                FEM.PASS.R = R;
                FEM.PASS.lambda = lambda0 + DELTA_lambda;
                
                % Assemble the stiffness matrix based on current displacement
                FEM.ANALYSIS.NR_inc_count = FEM.ANALYSIS.NR_inc;
                FEM.PASS.K_BC = K_BC_store;
                
                FEM.OUT.Fint_el(:,:,FEM.i + 1) = FEM.OUT.Fint_el(:,:,FEM.i);
                FEM.OUT.fint_el(:,:,FEM.i + 1) = FEM.OUT.Fint_el(:,:,FEM.i);
            end
            
        % If the previous step did converge...    
        else
            % Update force vector and load factor
            R = F*DELTA_lambda;
            FEM.PASS.R = R;
            FEM.PASS.lambda = lambda0 + DELTA_lambda;
        end
    end
    
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
    % Look at total applied force for convergence criteria
    F_norm = norm(FEM.PASS.Fint(B == 0));
    if isnan(F_norm) == 1
        F_norm = 1;
    end
    
    % Update variables
    res_error = FEM.PASS.res_error;
    iter = FEM.PASS.iter_i;
    U = FEM.OUT.U;
    DELTA_lambda = FEM.PASS.DELTA_lambda;
    
    % Save converged values
    if res_error < tol && iter < max_iter && F_norm ~= 1 % If step converged
        % Update U0 and lambda0
        U0 = U;
        FEM.OUT.U0 = U0;
        
        lambda0 = FEM.PASS.lambda;
        FEM.PASS.lambda0 = lambda0;
        K_BC_store = FEM.PASS.K_BC;
        DELTA_lambda_store = FEM.PASS.DELTA_lambda;
        FEM.PASS.DELTA_W0 = FEM.PASS.DELTA_W;
        
% % %         % For inflatable members
% % %         if FEM.ANALYSIS.analysis == 3
% % %             for j = 1:length(FEM.CONFIG)
% % %                 FEM.CONFIG(j).y_bar0 = FEM.CONFIG(j).y_bar;
% % %                 FEM.CONFIG(j).EI0 = FEM.CONFIG(j).EI1;
% % %                 FEM.CONFIG(j).EI = FEM.CONFIG(j).EI1;
% % %                 
% % %                 FEM.CONFIG(j).element0 = FEM.CONFIG(j).element;
% % %             end
% % %         end
        
        conv_it = 2;
        cutback_count = 0;
        
        FEM.OUT.D00 = FEM.OUT.D;
        FEM.OUT.P00 = FEM.OUT.P;
        
        FEM.MODEL.F_pre = FEM.PASS.Fext; % Update external force vector
    else
        cutback_count = cutback_count + 1;
    end
    
    % Store step displacement, internal force vector and iterations
    FEM.OUT.Uinc(:,inc_count) = U;
    FEM.OUT.Finc(:,inc_count) = FEM.PASS.Fint;
    FEM.OUT.Fext_inc(:,inc_count) = FEM.MODEL.F_pre;
    FEM.inc_count = inc_count;
    
    % Display step counter for debugging
    disp([inc_count iter control])
    
    FEM.PASS.NR_inc_count = FEM.PASS.NR_inc_count + 1;
    
    % Plot each increment
    if FEM.PLOT.plot_inc == 1
        FE_plot(FEM)
        eval(FEM.PLOT.plot_shape)
    end
    
    % Switch to arc-length solver is necessary
    if cutback_count >= FEM.ANALYSIS.arc_switch && control ~=3 && cutback_count ~= 0
        FEM.ANALYSIS.control = 4;
        control = 4;
        DELTA_lambda = DELTA_lambda0;
    end
    
    % If doing a 'pseudo time' analysis, break after the first converged
    % step
    if cutback_count == 0 && isfield(FEM.MODEL,'F_pt')
        break
    end
    
end
end








