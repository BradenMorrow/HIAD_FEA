function [ANALYSIS] = FE_controls2
% Analysis controls for FE analysis

% Solver and analysis
ANALYSIS.d_inc = 100; % Starting number of loading increments
ANALYSIS.control = 4; % 1 - Displacement control solver;
                      % 2 - Newton-Raphson solver;
                      % 3 - Arc-length solver;
                      % 4 - Enforce boundary conditions
ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
ANALYSIS.max_inc_count = 1000; % Maximum number of increments
ANALYSIS.min_inc_size = 1e-10; %Minimum increment size before aborting

ANALYSIS.max_iter = 10; % Maximum number of iterations per increment
ANALYSIS.tol = 1e-4; % Solver tolerance, (normalized to force vector)
ANALYSIS.Dmax = 200; % Absolute maximum displacement
ANALYSIS.DOF = 6; % DOF/node
ANALYSIS.step = 2; % Initialize load step counter

% Automatic load stepping
ANALYSIS.adapt = true;
ANALYSIS.inc_target = 20; % 4; % 
ANALYSIS.inc_power = .5;
ANALYSIS.max_inc = .1; % .1; % 1; % 

% For nonconservative loading
ANALYSIS.follow = false;
ANALYSIS.follow_F = @update_F;
ANALYSIS.follow_Knc = @update_Knc;

ANALYSIS.parallelize = true; % true; % Run assemble loop parallelized
ANALYSIS.compiled = false; % true; % Run compiled assemble loop

% Cutback loadstep if convergence is not obtained
ANALYSIS.cutback = true;

% Save iteration info every nth interation
ANALYSIS.save_info_iter = 1e6; 

% Display iteration info for debugging.  true = display info, false = no info displayed
ANALYSIS.iter_info_disp = true; % interation info
ANALYSIS.res_error_info = false; % residual error info
ANALYSIS.warning = true; % Display warnings
ANALYSIS.save_FE_info = false; % Save FE info to a file


end
