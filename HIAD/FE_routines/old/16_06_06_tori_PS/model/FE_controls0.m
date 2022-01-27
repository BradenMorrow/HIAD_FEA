function [ANALYSIS] = FE_controls0
% Analysis controls for FE analysis

% Solver and analysis
ANALYSIS.d_inc = 5; % Starting number of loading increments
ANALYSIS.control = 4; % 1 - Displacement control solver;
                      % 2 - Newton-Raphson solver;
                      % 3 - Arc-length solver;
                      % 4 - Enforce boundary conditions
ANALYSIS.NR_iter = 1; % Newton-Raphson, update stiffness matrix every 'NR_iter' iterations
ANALYSIS.max_inc = 500; % Maximum number of increments

ANALYSIS.max_iter = 300; % Maximum number of iterations per increment
ANALYSIS.tol = 1e-4; % Solver tolerance, (normalized to force vector)
ANALYSIS.Dmax = 200; % Absolute maximum displacement
ANALYSIS.DOF = 6; % DOF/node
ANALYSIS.step = 1; % Initialize load step counter

% Automatic load stepping
ANALYSIS.adapt = 0;
ANALYSIS.inc_target = 10;
ANALYSIS.inc_power = .5;
ANALYSIS.max_inc = .1; % 1; % 

% Cord model
ANALYSIS.cord_update = 0;

% For nonconservative loading
ANALYSIS.follow = 0;
ANALYSIS.follow_F1 = @update_F;
ANALYSIS.follow_F2 = @update_F;
ANALYSIS.follow_Knc = @update_Knc;

end

