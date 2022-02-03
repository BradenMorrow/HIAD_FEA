% Driver for fminsearch
% May 12, 2016

% Objective
fun = @HIAD_0;

% Strap prestrain (x0)
X0 = [...
    0.0728170697175947
    0.0775960493870776
    0.0851203608004301
    0.0811458641119393
    0.0766263959131938
    0.0818195620454586
    0.0899422111388671
    0.0737782197749814
    0.0793203521839783
    0.0834412160052283
    0.0901005245257181
    0.0804989955604103
    0.085952791481723
    0.0815722143007484
    0.118875011163805
    0.103507556960681
    0.103986046205358
    0.0911348219210264
    0.396061805340215];

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
PROBLEM.options = optimset('UseParallel',true);
PROBLEM.options = optimset('Display','iter');
PROBLEM.options = optimset('MaxFunEvals',1e6);
PROBLEM.solver = 'fminsearch';


tic
% [X,FVAL,EXITFLAG,OUTPUT] = fminsearch(fun,X0)
[X,FVAL,EXITFLAG,OUTPUT] = fminsearch(PROBLEM)
toc
