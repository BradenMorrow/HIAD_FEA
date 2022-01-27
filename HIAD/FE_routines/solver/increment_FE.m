function [FEM] = increment_FE(FEM)
% Step through loading using pseudo time

iter_info = zeros(2000,7);

% Store the location of the current analysis folder
current_folder = pwd;
file_path = fullfile(current_folder, 'analyses');
folder = dir(file_path);
pathCell = regexp(path, pathsep, 'split');
for i = 1:length(folder)
    path_to_be_searched = fullfile(file_path, folder(i).name);
    if any(ismember(path_to_be_searched,pathCell))
        current_analysis = path_to_be_searched;
    end
end


inc_target = FEM.ANALYSIS.inc_target;
inc_power = FEM.ANALYSIS.inc_power;
max_inc = FEM.ANALYSIS.max_inc;

% Initialize variables
if sum(FEM.ANALYSIS.control == 1:3) == 1  % For displacement control, newton, and arc length solvers
    F_pt = FEM.MODEL.F_pt; % Matrix of force vectors through time
    F = zeros(size(F_pt,1),1);
    pt = linspace(0,1,size(F_pt,2));
    F_pre0 = FEM.MODEL.F_pre;
    
    FEM.PASS.f_norm = norm(FEM.MODEL.F);
    FEM.PASS.set_L = 1;
    FEM.PASS.iter_i = 1;
    
    if FEM.ANALYSIS.control == 1 % For displacement control of the force vector
        D = FEM.MODEL.D;
        
        % Vector indicating DOFs of interest for displacement control
        b = zeros(size(F));
        b(FEM.MODEL.Di) = 1;
    end
    
elseif FEM.ANALYSIS.control == 4 % Enforced boundary conditions
    % U0 = FEM.MODEL.U0;
    U_pt = FEM.MODEL.U_pt; % [zeros(size(U0)) U0];
    pt = linspace(0,1,size(U_pt,2));
    
    FEM.PASS.f_norm = 1;
    
end

% Initialize variables
LAMBDA0 = 1/FEM.ANALYSIS.d_inc; % Initial load step
LAMBDA = LAMBDA0;
LAMBDA_old = 0;
FEM.ANALYSIS.d_inc = 1;
FEM.break = 0;
max_inc_count = FEM.ANALYSIS.max_inc_count;
FEM.PASS.min_inc_break = false;


FEM.PASS.iter_info = zeros(1,6);

if FEM.ANALYSIS.step == 1
    FEM.OUT.U = 0*FEM.MODEL.F;
    FEM.PASS.Fext = FEM.MODEL.F_pre;
end

try
    count = FEM.inc_count; % Count is the current number of increments, step is the step number
catch
    count = 1;
    FEM.inc_count = count;
end
Dmax = abs(FEM.ANALYSIS.Dmax);

% Preallocate rotation
n = size(FEM.MODEL.nodes,1);
FEM.OUT.rot = zeros(n,3);
FEM.OUT.DELTA_rot = zeros(n,3);

% Set the general element nodal location and orientation and element number
EL = FEM.EL;
nodes = FEM.MODEL.nodes; % Element nodes, set in analysis
orient = FEM.MODEL.orientation; % Element orientation, set in analysis
con = FEM.MODEL.connect(:,1:2); % Element connectivity, this is set in analysis
for i = 1:size(EL,1)
    EL(i).el_in.nodes_ij = [nodes(con(i,1),:)
        nodes(con(i,2),:)];
    EL(i).el_in.orient_ij = orient(i,:);
    EL(i).el_in0.el = i;
end
FEM.EL = EL;


% Step through load increments
while LAMBDA_old < 1 && max(abs(FEM.OUT.U)) < Dmax && count <= max_inc_count
    t_iter0 = tic;
    
    if FEM.ANALYSIS.control == 1 % For displacement control of force vector
        Dinc0 = D*LAMBDA;
        Dinc_old = D*LAMBDA_old;
        Dinc = Dinc0 - Dinc_old;
        FEM.MODEL.Dinc = Dinc;
        
        FEM.MODEL.Fr = FEM.MODEL.F*LAMBDA0;
        
    elseif sum(FEM.ANALYSIS.control == 2:3) == 1 % For load and arc-length control
        % Interpolate for force vector
        F = interp_fast(pt, F_pt, LAMBDA);
        F_old = interp_fast(pt, F_pt, LAMBDA_old);
        
        % Determine force increment
        F_inc = F - F_old;
        FEM.MODEL.F = F_inc;
        FEM.MODEL.F_pre = F_old + F_pre0;
        
    elseif FEM.ANALYSIS.control == 4 % For enforced boundary conditions
        FEM.MODEL.F_pre = FEM.PASS.Fext;
        
        % Interpolate for displacement
        U0_new = interp_fast(pt, U_pt, LAMBDA);
        U0_old = interp_fast(pt, U_pt, LAMBDA_old);
        
        FEM.MODEL.U0 = U0_new - U0_old;
        FEM.ANALYSIS.Dmax = .9*max(abs(FEM.OUT.U));
    end
    
    FEM.LAMBDA.current_LAMBDA = LAMBDA0; % Store the current increment size
    
    % Solve
    [FEM] = run_analysis(FEM);
    
    if FEM.PASS.min_inc_break
        % save(fullfile(current_analysis, 'FEM_interI'),'FEM')
        break
    end
    
    
    % Update LAMBDA
    if FEM.ANALYSIS.control == 1 % For displacement control
        Dinc_out = b'*FEM.OUT.DELTA_U;
        LAMBDA0 = Dinc_out/Dinc*LAMBDA0;
    else % For load and arc-length control
        LAMBDA0 = (LAMBDA - LAMBDA_old)*FEM.PASS.DELTA_lambda;
        LAMBDA0 = abs(LAMBDA0);
        FEM.PASS.set_L = 0;
    end
    
    % Current LAMBDA
    LAMBDA1 = LAMBDA_old + LAMBDA0;
    LAMBDA_old = LAMBDA1;
    FEM.LAMBDA.old = LAMBDA_old;
    
    % Display step counter for debugging
    t_iter = toc(t_iter0);
    LAMBDA_old_total = LAMBDA_old + FEM.ANALYSIS.step - 1;
    iter_info(count,:) = [FEM.inc_count FEM.PASS.iter_i LAMBDA_old_total LAMBDA0 FEM.cut - 1 FEM.PASS.res_error t_iter];
    
    iter_info0 = iter_info;
    iter_info0(iter_info(:,1) == 0,:) = [];
    FEM.PASS.iter_info = iter_info0;
    
    if (FEM.ANALYSIS.iter_info_disp)
        if(count == 1)
            fprintf('%-16s%-16s%-16s%-16s%-16s%-16s%-16s\n%-16u%-16u%-16.4f%-16.3g%-16u%-16.3g%-16.2f\n',...
                'Increment','Passes/Inc', 'Total Lambda', 'Delta Lambda', 'Cutbacks/Inc', 'Residual', 'Inc Time',iter_info(count,:))
        else
            fprintf('%-16u%-16u%-16.4f%-16.3g%-16u%-16.3g%-16.2f\n',iter_info(count,:))
        end
    end
    
    % Adaptive stepping
    adapt = FEM.ANALYSIS.adapt;
    if (adapt && count ~= 1)
        if FEM.cut > 1 % Don't adapt if cutbacks occured
%             LAMBDA0 = LAMBDA0*(inc_target/FEM.PASS.iter_i)^inc_power;
        end
        
        LAMBDA0 = LAMBDA0*(inc_target/FEM.PASS.iter_i)^inc_power;

        if LAMBDA0 > max_inc % Largest possible step is predefined
            LAMBDA0 = max_inc;
        end
        
        if FEM.ANALYSIS.control == 3 % For arc-length control
            FEM.PASS.L = FEM.PASS.L*(inc_target/FEM.PASS.iter_i)^inc_power;
        end
    end
    
    % Update lambda
    LAMBDA = LAMBDA_old + LAMBDA0;
    
    % Do not load or displace past maximum value
    if LAMBDA > 1
        LAMBDA = 1;
    end
    
    FEM.PASS.DELTA_lambda = 1;
    
    
    if count >= 23
        a = 1;
    end
    
    % Update increment counters
    count = count + 1;
    
    
    %     FEM.ANALYSIS.step = FEM.ANALYSIS.step + 1;
    FEM.inc_count = count;
    if rem(count,FEM.ANALYSIS.save_info_iter) == 0
        save(fullfile(current_analysis, 'FEM_interI'),'FEM')
    end
    
%     FEM.iter_info = iter_info;
%     FEM.iter_info(FEM.iter_info(:,1) == 0,:) = [];
    
    % % %     for i = 1:2
    % % %         dV_L(count - 1) = dV_L(count - 1) + FEM.EL(i + 1).el_in0.flex.dV_L*2;
    % % %         dV_H(count - 1) = dV_H(count - 1) + FEM.EL(i + 1).el_in0.flex.dV_H*2;
    % % %         dV(count - 1) = dV(count - 1) + FEM.EL(i + 1).el_in0.flex.dV*2;
    % % %     end
    % % %     FEM.OUT.dV_L = dV_L(dV_L ~= 0);
    % % %     FEM.OUT.dV_H = dV_H(dV_H ~= 0);
    % % %     FEM.OUT.dV = dV(dV ~= 0);
    % % %
    % % %     FEM.OUT.M(count - 1) = Mi;
    
    
end

% Save LAMBDA
FEM.OUT.LAMBDA = LAMBDA;




iter_info(all(iter_info==0,2),:)= [];
iter_info_table = table(iter_info(:,1),iter_info(:,2),iter_info(:,3),iter_info(:,4),iter_info(:,5),iter_info(:,6),...
    'VariableNames', {'Increment' 'Increment_Iterations' 'Total_Lambda' 'Delta_Lambda' 'Cutbacks_Per_Inc' 'Inc_Time'});


if (FEM.ANALYSIS.save_FE_info)
    try
        FEM.iter_info = vertcat(FEM.iter_info,iter_info_table);
    catch
        FEM.iter_info = iter_info_table;
    end
    writetable(FEM.iter_info,fullfile(current_analysis, 'iter_info.xls'))
end

end








