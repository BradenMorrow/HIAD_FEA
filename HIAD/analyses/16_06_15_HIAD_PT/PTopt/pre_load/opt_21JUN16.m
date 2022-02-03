% Optimize HIAD prestress, after initial GA optimization
% June 21, 2016

% Baseline HIAD model
global FEM

% Load model
[FEM] = HIAD_PT_preload;

% Objective
fun = @apply_preten2;

X0 = [-0.0319653543523395
    0.0323973085126497
    0.0034226140097386
    0.0413971210179593
    0.037337606404266
    -0.0199259177929993
    0.0152637621650454
    0.0749450820291568
    0.0545982046954083
    0.0459289757747195
    0.0599038672600228
    0.0517078470235172
    0.0477223736732323
    0.0068752569760874
    0.0813878427679857
    0.00100945429454903]*0;

A = []; % Linear inequality constraint (A*x <= B)
B = [];

Aeq = []; % Linear equality constraint (Aeq*x = Beq)
Beq = [];

LB = -.1*ones(size(X0)); % Lower and upper bounds on x
UB = .5*ones(size(X0));

% Constraint
cfun = @get_def_con;


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
PROBLEM.options = optimoptions('fmincon','Display','iter','Algorithm','interior-point');
% PROBLEM.options.TolFun = 10;
% PROBLEM.options.TolX = 1e-6;
PROBLEM.options.ObjectiveLimit = 10;
PROBLEM.solver = 'fmincon';

tic
[X,FVAL,EXITFLAG,OUTPUT] = fmincon(PROBLEM)
toc





