function [population] = create_population(n_pop,n_genes,ub_1,lb_1,...
    objective,constraint,ind_an)
%Initial population creator
%Andrew Goupee
%Last modified:  4-21-04

%This function creates the initial population and assigns their fitness.
%The fitness of each individual is assigned as described by K. Deb in his
%paper 'An efficient constraint handling method for genetic algorithms'.
%Simply put, if an individual possesses a feasible solution, then the
%fitness of that individual is equal to the objective function.  If an
%individual possesses an infeasible soltuion, then the fitness of that
%individual is equal to the fitness of the worst feastible solution in the
%population plus the constraint violation.  For more details, please see
%the UMGAtoolbox1.0 User's Guide.  Definitions for the inputs can be found
%in the m-file 'GA' and definitions of the outputs can be found in
%'GAmain'.

%Additional variables used in this function:
%worst - objective function value of worst feasible solution in the
%   population


%Reset random number generator
% rand('state',sum(100*clock));
rng(sum(100*clock));

%Size population
population = zeros(n_pop,(n_genes+2));

%Create genes values
for i = 1:n_pop
    for j = 3:(n_genes+2)
        population(i,j) = (rand*(ub_1(j-2)-lb_1(j-2)))+lb_1(j-2);
    end
end

% % % % Determine objective function and constraint function values
% % % global FEM
% % % FEM_worker = FEM;
% % % 
% % % pop_vals = population(:,3:n_genes + 2);
% % % obj = zeros(size(population,1),1);
% % % con = zeros(size(population,1),1);
% % % 
% % % parfor i = 1:n_pop;
% % %     % disp('********')
% % %     % disp(i)
% % %     
% % %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %     % Modified May 11, 2016
% % %     % Problem specific
% % %     % Also modified SBX_PBN
% % %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %     [strap_F,Cout] = apply_preten(FEM_worker,pop_vals(i,:));
% % %     obj(i) = feval(objective,strap_F);
% % %     con(i) = feval(constraint,Cout);
% % %     
% % %     % % Initial
% % %     % population(i,1) = feval(objective,[population(i,3:(n_genes+2))]);
% % %     % population(i,2) = feval(constraint,[population(i,3:(n_genes+2))]);
% % % end;
% % % 
% % % population(:,1) = obj;
% % % population(:,2) = con;

[population] = ind_an(objective,constraint,population,1,false);



%Determine worst feasible solution
worst = 0;
for i = 1:n_pop
    if ((population(i,1) > worst) && (population(i,2) <= 0))
        worst = population(i,1);
    end
end

%Assign fitness value, finish initial population
for i = 1:n_pop
    if (population(i,2) > 0)
        population(i,1) = worst + population(i,2);
    end
end

