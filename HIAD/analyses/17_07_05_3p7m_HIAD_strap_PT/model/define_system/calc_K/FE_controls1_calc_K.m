function [ANALYSIS] = FE_controls1_calc_K
% Analysis controls for FE analysis

% Solver and analysis
ANALYSIS.d_inc = 1; % Starting number of loading increments
ANALYSIS.control = 2; % 1 - Displacement control solver;
                      % 2 - Newton-Raphson solver;
                      % 3 - Arc-length solver;
                      % 4 - Enforce boundary conditions
ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
ANALYSIS.max_inc_count = 100; % Maximum number of increments
ANALYSIS.min_inc_size = 1e-5; %Minimum increment size to abort program

ANALYSIS.max_iter = 20; % Maximum number of iterations per increment
ANALYSIS.tol = 1e-4; % Solver tolerance, (normalized to force vector)
ANALYSIS.Dmax = 300; % Absolute maximum displacement
ANALYSIS.DOF = 6; % DOF/node
ANALYSIS.step = 1; % Initialize load step counter

% Automatic load stepping
ANALYSIS.adapt = true;
ANALYSIS.inc_target = 3;
ANALYSIS.inc_power = .5;
ANALYSIS.max_inc = 1;

% For nonconservative loading
ANALYSIS.follow = true;
ANALYSIS.follow_F = @update_F;
ANALYSIS.follow_Knc = @update_Knc;

ANALYSIS.parallelize = true; % Run assemble loop parallelized
ANALYSIS.compiled = true; % Run compiled assemble loop

% Cutback loadstep if convergence is not obtained
ANALYSIS.cutback = true;

% Save iteration info every nth interation
ANALYSIS.save_info_iter = 1e6; 

% Display iteration info for debugging.  true = display info, false = no info displayed
ANALYSIS.iter_info_disp = false; % interation info
ANALYSIS.res_error_info = false; % residual error info
ANALYSIS.warning = true; % Display warnings
ANALYSIS.save_FE_info = false; % Save FE info to a file

end

