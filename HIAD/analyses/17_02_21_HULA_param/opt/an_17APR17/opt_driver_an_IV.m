% Driver for fmincon
% May 12, 2016

% Objective
fun = @HIAD_X_30MAR17;

% Initial input
X0 = [65 % Braid angle (deg)
    65
    65
    65
    65
    65
    65]';



A = []; % Linear inequality constraint (A*x <= B)
B = [];

Aeq = []; % Linear equality constraint (Aeq*x = Beq)
Beq = [];

LB = 57*ones(size(X0)); % Lower and upper bounds on x
UB = 75*ones(size(X0));

% Constraint
cfun = [];

% 

% fmincon(PROBLEM) finds the minimum for PROBLEM. PROBLEM is a
%     structure with the function FUN in PROBLEM.objective, the start point
%     in PROBLEM.x0, the linear inequality constraints in PROBLEM.Aineq
%     and PROBLEM.bineq, the linear equality constraints in PROBLEM.Aeq and
%     PROBLEM.beq, the lower bounds in PROBLEM.lb, the upper bounds in 
%     PROBLEM.ub, the nonlinear constraint function in PROBLEM.nonlcon, the
%     options structure in PROBLEM.options, and solver name 'fmincon' in
%     PROBLEM.solver. Use this syntax to solve at the command line a problem 
%     exported from OPTIMTOOL.

PROBLEM.objective = fun;
PROBLEM.x0 = X0;
PROBLEM.Aineq = A;
PROBLEM.bineq = B;
PROBLEM.Aeq = Aeq;
PROBLEM.beq = Beq;
PROBLEM.lb = LB;
PROBLEM.ub = UB;
PROBLEM.nonlcon = cfun;
PROBLEM.solver = 'fmincon';
PROBLEM.options = optimoptions('fmincon','UseParallel',true);
PROBLEM.options = optimoptions(PROBLEM.options,'Display','iter');
% PROBLEM.options = optimoptions(PROBLEM.options,'Algorithm','sqp');
PROBLEM.options = optimoptions(PROBLEM.options,'StepTolerance',1e-10);

tic
[X,FVAL,EXITFLAG,OUTPUT] = fmincon(PROBLEM)
toc


save('an_IV_30MAR17_4')