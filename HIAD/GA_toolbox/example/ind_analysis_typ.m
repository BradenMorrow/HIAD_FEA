function [pop_out] = ind_analysis_typ(objective,constraint,population,mating_pool,mp_switch)
% Evaluate individuals in GA


for i = 1:size(population,1)
    if mp_switch
        if ((population(i,1) == mating_pool(i,1)) && ...
            (population(i,2) == mating_pool(i,2)))
            % Nothing happens
        else
            population(i,1) = feval(objective,population(i,3:end));
            population(i,2) = feval(constraint,population(i,3:end));
        end
    else
        population(i,1) = feval(objective,population(i,3:end));
        population(i,2) = feval(constraint,population(i,3:end));
    end
end

pop_out = population;


end

