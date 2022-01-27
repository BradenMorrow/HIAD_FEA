function [population] = SBX_PBM(mating_pool,pc,pcg,nc,pm,pmg,nm,ub_2,...
    lb_2,objective,constraint,elite,best,n_pop,n_genes,ind_an)
%Crossover and mutation function
%Andrew Goupee
%Last modified:  5-14-04

%This function takes the mating pool post tournament selection and applies
%the crossover and mutation operators to create a new population.  The
%simulated binary crossover operator (SBX) and parameter based mutation
%operator (PBM) are used for this purpose.  For details on the input and
%output definitions, please see m-file 'GAmain'.  More details on these
%specific operators can be found in the UMGAtoolbox1.0 User's Guide.

%Additional variables used in this function:
%start - variable for determining where to begin SBX and PBM operations
%parent_1 - first parent
%parent_2 - second parent
%x1, x2 - parent genes
%difference - parameter used in SBX operations
%beta - parameter used in SBX operations
%alpha - parameter used in SBX operations
%u - random number between 0 and 1
%beta_bar - parameter used in SBX operations
%y1, y2 - children genes
%child_1 - first child
%child_2 - second child
%x - child gene before mutation
%delta - parameter used in PBM operations
%delta_bar - parameter used in PBM operations
%y - child gene after mutation
%worst - worst feasible solution in populations
%group - collection of individuals competiting in 'best' tournament
%fit - vector fitnesses
%value - placeholder
%flag - indicates best individual in the 'best' tournament
%count - counter
%group2 - second collection of individuals in 'best' tournament
%fit2 - additional fitness vector
%gap - value used in mutation calculation (for ensuring there is no divide
%   by zero)


%Create starting point
if (elite == 1)
    population(1,:) = mating_pool(1,:);
    population(2,:) = mating_pool(2,:);
    start = 2;
else
    start = 1;
end

%Begin looping through mating pool
for i = start:(n_pop/2)
    
    %Extract parents from mating pool
    parent_1 = mating_pool(2*i-1,:);
    parent_2 = mating_pool(2*i,:);
        
    %Perform crossover if necessary
    if (rand <= pc)
        
        %Loop through genes
        for j = 3:(n_genes+2)
            
            %Determine if genes are to be crossed
            if (rand <= pcg)
                
                %Perform crossover
                if (parent_1(1,j) < parent_2(1,j))
                    x1 = parent_1(1,j);
                    x2 = parent_2(1,j);
                else
                    x1 = parent_2(1,j);
                    x2 = parent_1(1,j);
                end
                
                if (x2 == x1)
                    difference = .01;
                else
                    difference = x2 - x1;
                end
                
                beta = 1 + (2/difference)*...
                    (min([(x1-lb_2(1,j-2)),(ub_2(1,j-2)-x2)]));
                
                alpha = 2 - beta^(-(nc+1));
                
                u = rand;
                if (u <= (1/alpha))
                    beta_bar = (alpha*u)^(1/(nc+1));
                else
                    beta_bar = (1/(2-alpha*u))^(1/(nc+1));
                end
                
                y1 = 0.5*((x1+x2) - beta_bar*(x2-x1));
                y2 = 0.5*((x1+x2) + beta_bar*(x2-x1));         
                
                if (parent_1(1,j) < parent_2(1,j))
                    child_1(1,j) = y1;
                    child_2(1,j) = y2;
                else
                    child_1(1,j) = y2;
                    child_2(1,j) = y1;
                end
            else
                child_1(1,j) = parent_1(1,j);
                child_2(1,j) = parent_2(1,j);
            end
        end
    else
        %Just copy over parents to children if no crossover at all
        child_1 = parent_1;
        child_2 = parent_2;
    end
    
    %Now perform mutation operations
    %child_1
    if (rand < pm)
        
        %Erase fitness and constraint violation
        child_1(1,1) = 0;
        child_1(1,2) = 0;
        
        %Loop through genes
        for j=3:(n_genes+2)
            
            %Determine if gene is to be mutated
            if (rand < pmg)
                
                %Perform mutation
                x = child_1(1,j);
                
                %Calcualte gap
                if (ub_2(1,j-2) == lb_2(1,j-2))
                    gap = 1;
                else
                    gap = ub_2(1,j-2)-lb_2(1,j-2);
                end
                
                delta = (min([(x-lb_2(1,j-2)),(ub_2(1,j-2)-x)]))/...
                    gap;
                
                u = rand;
                if (u <= 0.5)
                    delta_bar = ((2*u+(1-2*u)*((1-delta)^(nm+1)))...
                        ^(1/(nm+1))) - 1;
                else
                    delta_bar = 1 - (2*(1-u)+2*(u-0.5)*((1-delta)^(nm+1)))...
                        ^(1/(nm+1));
                end
                
                y = x + delta_bar*(ub_2(1,j-2) - lb_2(1,j-2));
                
                child_1(1,j) = y;
            end
        end
    end
    
    %child_2
    if (rand < pm)
        
        %Erase fitness and constraint violation
        child_2(1,1) = 0;
        child_2(1,2) = 0;
        
        %Loop through genes
        for j=3:(n_genes+2)
            
            %Determine if gene is to be mutated
            if (rand < pmg)
                
                %Perform mutation
                x = child_2(1,j);
                
                %Calculate gap
                if (ub_2(1,j-2) == lb_2(1,j-2))
                    gap = 1;
                else
                    gap = ub_2(1,j-2)-lb_2(1,j-2);
                end
                
                delta = (min([(x-lb_2(1,j-2)),(ub_2(1,j-2)-x)]))/...
                    gap;
                
                u = rand;
                if (u <= 0.5)
                    delta_bar = ((2*u+(1-2*u)*((1-delta)^(nm+1)))...
                        ^(1/(nm+1))) - 1;
                else
                    delta_bar = 1 - (2*(1-u)+2*(u-0.5)*((1-delta)^(nm+1)))...
                        ^(1/(nm+1));
                end
                
                y = x + delta_bar*(ub_2(1,j-2) - lb_2(1,j-2));
                
                child_2(1,j) = y;
            end
        end
    end
    %Insert new members into population
    population(i*2-1,:) = child_1;
    population(i*2,:) = child_2;
end

% % % % Determine objective function and constraint function values
% % % global FEM
% % % 
% % % pop_vals = population(:,3:n_genes + 2);
% % % obj = population(:,1);
% % % con = population(:,2);
% % % MP1 = mating_pool(:,1);
% % % MP2 = mating_pool(:,2);
% % % 
% % % parfor i = 1:n_pop;
% % %     % if ((population(i,1) == mating_pool(i,1)) &...
% % %     %         (population(i,2) == mating_pool(i,2)));
% % %     if obj(i) == MP1(i) && con(i) == MP2(i)
% % %         % Nothing happens
% % %     else
% % %         % disp('********')
% % %         % disp(i)
% % %         
% % %         
% % %         
% % %         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %         % Modified May 11, 2016
% % %         % Problem specific
% % %         % Also modified create_population
% % %         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %         [strap_F,Cout] = apply_preten(FEM,pop_vals(i,:));
% % %         obj(i) = feval(objective,strap_F);
% % %         con(i) = feval(constraint,Cout);
% % %         
% % %         % population(i,1) = feval(objective,[population(i,3:(n_genes+2))]);
% % %         % population(i,2) = feval(constraint,[population(i,3:(n_genes+2))]);
% % %     end
% % % end
% % % 
% % % population(:,1) = obj;
% % % population(:,2) = con;

[population] = ind_an(objective,constraint,population,mating_pool,true);


%Find a new worst feasible solution between population and mating pool
worst = 0;
for i = 1:n_pop
    if ((population(i,1) > worst) && (population(i,2) <= 0))
        worst = population(i,1);
    end
    
    if ((mating_pool(i,1) > worst) && (mating_pool(i,2) <= 0))
        worst = mating_pool(i,1);
    end
end

%Reassign fitness
for i = 1:n_pop
    if (population(i,2) > 0)
        population(i,1) = worst + population(i,2);
    end
    
    if (mating_pool(i,2) > 0)
        mating_pool(i,2) = worst + mating_pool(i,2);
    end
end

%Perform best function if required
if (best == 1)
    for i = 1:(n_pop/2)
        group(1,:) = population(i*2-1,:);
        group(2,:) = population(i*2,:);
        group(3,:) = mating_pool(i*2-1,:);
        group(4,:) = mating_pool(i*2,:);
        
        fit = [group(1,1) group(2,1) group(3,1) group(4,1)];
        
        [value,flag] = min(fit);
        
        %Insert first new member into population
        population(i*2-1,:) = group(flag,:);
        
        count = 1;
        for j = 1:4
            if (j == flag)
                %Nothing happens
            else
                group2(count,:) = group(j,:);
                count = count + 1;
            end
        end
        
        fit2 = [group2(1,1) group2(2,1) group2(3,1)];
        
        [value,flag] = min(fit2);
        
        %Insert second new member into population
        population(i*2,:) = group2(flag,:);
    end
end

%Refind worst
worst = 0;
for i = 1:n_pop
    if ((population(i,1) > worst) & (population(i,2) <= 0));
        worst = population(i,1);
    end
end

%Assign final fitness
for i = 1:n_pop
    if (population(i,2) > 0)
        population(i,1) = worst + population(i,2);
    end
end