function [pop_out] = ind_analysis_IV_30MAR17(objective,constraint,population,mating_pool,mp_switch)
% Evaluate individuals in GA

pop = population(:,3:end);
obj = population(:,1);
con = population(:,2);

parfor i = 1:size(pop,1)
    if mp_switch
        if ((obj(i) == mating_pool(i,1)) && (con(i) == mating_pool(i,2)))
            % Nothing happens
        else
            [k] = HIAD_X_30MAR17(pop(i,:));
            obj(i) = k;
            con(i) = 0;
        end
    else
        [k] = HIAD_X_30MAR17(pop(i,:));
        obj(i) = k;
        con(i) = 0;
    end
end

pop_out = [obj con pop];


end

