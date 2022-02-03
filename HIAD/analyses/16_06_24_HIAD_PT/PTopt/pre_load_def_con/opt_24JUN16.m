% Optimize HIAD prestress, after initial GA optimization
% June 21, 2016

% Objective
fun = @apply_preten_cone;

X0 = [-0.0134391718019738 % From opt_23JUN16_48.mat
    0.0129521548286767
    0.00152032488912141
    0.01617336729262
    0.0148818120879623
    -0.00774898846496717
    0.00665421855246958
    0.0298268857076248
    0.0213429481522681
    0.018853755638744
    0.023893024167849
    0.0203092389854977
    0.0131567515026935
    0.0104099029088964
    0.0196107608569695
    0.0171169666583283
    -1.6];

A = []; % Linear inequality constraint (A*x <= B)
B = [];

Aeq = []; % Linear equality constraint (Aeq*x = Beq)
Beq = [];

LB = -.1*ones(size(X0)); % Lower and upper bounds on x
LB(end) = -5;
UB = .5*ones(size(X0));
UB(end) = 5;

% Constraint
% cfun = @get_def_con;
cfun = @zero_con;


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
PROBLEM.options.UseParallel = 1;
PROBLEM.solver = 'fmincon';

tic
[X,FVAL,EXITFLAG,OUTPUT] = fmincon(PROBLEM)
toc





