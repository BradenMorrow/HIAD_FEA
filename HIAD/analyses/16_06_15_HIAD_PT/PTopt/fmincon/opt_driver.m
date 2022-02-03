% Driver for fmincon
% May 12, 2016

% Objective
fun = @HIAD_PT0;

% Strap prestrain (x0)
X0 = [.0004386 % Loop1, aft1
    .0004386 % Loop1, aft2
    .0004386 % Loop1, aft3
    .0004386 % Loop1, fore1
    .0004386 % Loop1, fore2
    .0004386 % Loop1, fore3
    .0004386 % Loop2, aft1
    .0004386 % Loop2, aft2
    .0004386 % Loop2, aft3
    .0004386 % Loop2, fore1
    .0004386 % Loop2, fore2
    .0004386 % Loop2, fore3
    .0004386 % Radial, aft
    .0004386 % Chevron, aft
    .0004386 % Radial, fore
    .0004386]; % Chevron, fore

X0 = X0*0;

A = []; % Linear inequality constraint (A*x <= B)
B = [];

Aeq = []; % Linear equality constraint (Aeq*x = Beq)
Beq = [];

LB = -.001*ones(size(X0)); % Lower and upper bounds on x
UB = .01*ones(size(X0));

% Constraint
cfun = @get_def_con;

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
PROBLEM.options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
PROBLEM.solver = 'fmincon';

tic
[X,FVAL,EXITFLAG,OUTPUT] = fmincon(PROBLEM)
toc
