function [elite_no,avg_fit,best_fit] = pop_report(generation,n_pop,...
    population,n_genes);
% Population report generator
% Andrew Goupee
% Last modified:  4-23-04
% 
% This function displays a report segment which contains the generation
% number, the population average fitness, and the statistics of the most fit
% individual in the current population.  This function also returns the
% number of the most fit individual in the population, as well as the the
% value of the average fitness of the population and the value of the
% most fit individual in the population.  For definitions of the inputs and
% outputs, see m-file 'GAmain'.
% 
% Additional variables used in this function:
% fit_sum - sum of fitnesses


%Initialize best_fit, fit_sum, elite_no
best_fit = population(1,1);
fit_sum = 0;
elite_no = 1;

%Determine best fitness, sum of fitnesses
for i = 1:n_pop;
    if (population(i,1) < best_fit);
        best_fit = population(i,1);
        elite_no = i;
    end;
    fit_sum = fit_sum + population(i,1);
end;

%Calculate average fitness
avg_fit = fit_sum/n_pop;

%Display fitness report
%disp(' ')
%disp('     ***** Population Fitness Report *****')
%disp(['   ' '     Generation:  ' num2str(generation)])
%disp(['   ' 'Average Fitness:  ' num2str(avg_fit)])
%disp(['   ' 'Best Individual:  ' 'chromosome = [ ' num2str(population...
%        (elite_no,(3:n_genes+2))) ' ]' ])
%disp(['                     ' 'constraint violation = ' num2str(population...
%        (elite_no,2)) ])
%disp(['                     ' 'fitness = ' num2str(population...
%        (elite_no,1)) ]) 