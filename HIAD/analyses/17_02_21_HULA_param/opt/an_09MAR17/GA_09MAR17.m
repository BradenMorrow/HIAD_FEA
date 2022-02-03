% Main Genetic Algorithm (GA) Input Page
% Andrew Goupee
% Last modified:  4-27-04
% 
% This m-file allows one to select the values of various GA parameters used
% in searching for the minimum of an objective function under linear and/or 
% nonlinear constraints.  Recommended values of the GA parameters are given
% in the UMGAtoolbox1.0 User's Guide.  The paremeters to be chosen are as 
% follows:
% 
% GA parameters:
% max_gen - the maximum allowable number of generations
% n_pop - size of GA population (must be an even number)
% n_genes - number of genes in an individuals chromosome
% ub_1 - vector of upper bounds on genes (design parameters) for initial
%   population, dimensions of 1 row x n_genes columns
% lb_1 - vector of lower bounds on genes (design parameters) for initial
%   population, dimensions of 1 row x n_genes columns
% ub_2 - vector of upper bounds on genes (design parameters) for all
%   populations after initial, dimensions of 1 row x n_genes columns
% lb_2 - vector of lower bounds on genes (design parameters) for all
%   populations after initial, dimensions of 1 row x n_genes columns
% elite - elitism switch (1 is on, 0 is off)
% best - post crossover/mutation selection switch (1 selects the best of 
%   the parents and children, 2 selects the children)
% pc - probability of crossover per pair of parents
% pcg - probability of crossover per gene
% nc - crossover strength parameter (smaller values increase strength)
% pm - probability of mutation per individual
% pmg - probability of of mutation per gene
% nm - mutation strength parameter (smaller values increase strength)
% d_nich - maximum allowable normalized euclidian distance between mates
% nf_f - maximum percent of population to be searched for a compatible mate
% drop - overall percent reduction in chosen parameters (for those that
%   apply) calculated during dynamic parameter alteration
% dyn - strength parameter for dynamic alteration scheme (larger values
%   reduce parameters by percent alloted in 'drop' quicker)
% tolerance - convergence criteria: GA terminates if best individual does
%   not improve more than value alloted here in number of generations given in
%   'span'.
% span - number of generations used in convergence criteria (see 'tolerance')
% grad_switch - gradient based search switch (1 is on, 0 is off)
% plot_switch - plots best and average fitnesses as a function of
%   generations (1 is on, 0 is off)
% 
% As stated previously, this GA finds a minimum of an objective function
% under constraints.  The objective function must be an m-file that accepts
% a vector of design parameters (which possesses the number of entries set
% in 'n_genes') and has a single scalar as an output.  The constraint
% function must be an m-file that accepts a vector of design paramters and
% returns a single scalar proportional to the level of constraint violation.
% Please see UMGAtoolbox1.0 for advice on constructing objective and
% constraint functions.  Please note that this page requires the following:
% 
% Function inputs:
% objective - character string containing name of objective function m-file
% constraint - character string containing name of constraint function
%   m-file
% 
% The final result of the search and optimization procedure are contained in
% the following variables:
% x_min - value of solution at minimum found
% obj_value - value of the objective function at at specified solution
% drive

% Select GA paramters:
max_gen = 500; % 2; % 

n_pop = 400; % 4; % 

ub_09MAR17 % ub_1
lb_09MAR17 % lb_1

ub_2 = ub_1;

lb_2 = lb_1;

n_genes = size(ub_1,2); % 53



elite = 1;

best = 1;

pc = .9;

pcg = .5;

nc = 1;

pm = .3; % .02; % 

pmg = .5; % 

nm = 10; % 100; % 

d_nich = .1;

nf_f = 0.25;

drop = 0; % .5;

dyn = .001;

tolerance = .00001;

span = 10000;

grad_switch = 0;

plot_switch = 0;

% Provide objective and constraint function names
objective = [];

constraint = 'get_con_07MAR17';

ind_an = @ind_analysis_09MAR17;

RESTART.restart = 0;
% RESTART.restart = 1;
% RESTART.ga_info = 'ga_info1.mat';

% Perform GA search and optimization
% tic
[x_min,obj_value] = GAmain(max_gen,n_pop,n_genes,ub_1,lb_1,ub_2,lb_2,elite,best,...
    pc,pcg,nc,pm,pmg,nm,d_nich,nf_f,drop,dyn,tolerance,span,objective,...
    constraint,grad_switch,plot_switch,ind_an,RESTART);
% toc

% % % % Final report
% % % disp(' ')
% % % disp('     ***** Final Report *****')
% % % disp(['   ' 'Solution Vector:  ' '[ ' num2str(x_min) ' ]' ])
% % % disp(['   ' 'Objective Func.:  ' num2str(obj_value)])

% save('GA_07MAR17','x_min')



