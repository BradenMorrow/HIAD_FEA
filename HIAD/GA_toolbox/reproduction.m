function [mating_pool] = reproduction(population,n_pop,elite,elite_no,...
    n_genes,d_nich,nf_f,ub_2,lb_2);
%Reproduction function
%Andrew Goupee
%Last modified:  5-14-04

%This reproduction function creates a mating pool from a population of
%individuals.  Tournament selection is employed for this purpose and a
%niching method is also used to maintain diversity in the population.  For
%definitions of the inputs and outputs, please see m-file 'GAmain'.

%Additional variables used in this function:
%start - parameter used in filling out the remainder of the mating pool.
%individual_1 - first individual in tournament
%individual_2 - second individual in tournament
%d12 - euclidian distance between solutions
%count - counter
%opponent - intermediate individual to possibly compete in tournament
%nich_sum - component of d12
%gap - value used in calculating d12 (used for avoiding divide by zero
%   erros)


%Initialize mating_pool
mating_pool = zeros(n_pop,(n_genes+2));
    
%Perform elitist operation if desired, initialize start parameter
start = 1;
if elite > 0;
    mating_pool(1,:) = population(elite_no,:);
    mating_pool(2,:) = population(elite_no,:);
    start = 3;
end;
    
%Fill out mating pool
for j = start:n_pop;
    
    %Select first individual for tournament, initialize second individual
    individual_1 = population(random(n_pop),:);
    individual_2 = individual_1;
    
    %Initialize d12, count
    d12 = 2*d_nich;
    count = 1;
    
    %Find second acceptable individual
    while ((d12 > d_nich) & (count <= round(nf_f*n_pop)));
        
        %Determine possible opponent
        opponent = population(random(n_pop),:);
        
        %Calculate new d12;
        nich_sum = 0;
        for k = 3:(n_genes+2);
            
            %Calculate gap
            if (ub_2(k-2) == lb_2(k-2));
                gap = 1;
            else;
                gap = ub_2(k-2)-lb_2(k-2);
            end;            
            
            nich_sum = nich_sum + ((individual_1(1,k)-opponent(1,k))/...
                (gap))^2;
        end;
        
        d12=(nich_sum/n_genes)^.5;
        
        %Assign individual_2 if necessary
        if (d12 < d_nich)
            individual_2 = opponent;
        end;
        
        %Count up count
        count = count + 1;
        
    end;
    
    %Conduct tournament
    if (individual_1(1,1) < individual_2(1,1));
        mating_pool(j,:) = individual_1;
    else;
        mating_pool(j,:) = individual_2;
    end;
    
end;