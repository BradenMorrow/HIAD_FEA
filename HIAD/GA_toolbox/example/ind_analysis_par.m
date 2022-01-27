function [pop_out] = ind_analysis_par(objective,constraint,population,mating_pool,mp_switch)
% Evaluate individuals in GA

pop = population(:,3:end);
obj = population(:,1);
con = population(:,2);

parfor i = 1:size(pop,1)
    if mp_switch
        if ((obj(i) == mating_pool(i,1)) && (con(i) == mating_pool(i,2)))
            % Nothing happens
        else
            obj(i) = feval(objective,pop(i,:));
            con(i) = feval(constraint,pop(i,:));
        end
    else
        obj(i) = feval(objective,pop(i,:));
        con(i) = feval(constraint,pop(i,:));
    end
end

pop_out = [obj con pop];


end

