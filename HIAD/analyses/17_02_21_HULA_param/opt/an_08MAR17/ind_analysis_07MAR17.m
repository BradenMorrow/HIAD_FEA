function [pop_out] = ind_analysis_07MAR17(objective,constraint,population,mating_pool,mp_switch)
% Evaluate individuals in GA

pop = population(:,3:end);
obj = population(:,1);
con = population(:,2);

parfor i = 1:size(pop,1)
    if mp_switch
        if ((obj(i) == mating_pool(i,1)) && (con(i) == mating_pool(i,2)))
            % Nothing happens
        else
            [out] = HIAD_X_07MAR17(pop(i,:));
            obj(i) = out.mass;
            con(i) = feval(constraint,out.k_0); % out.con;
        end
    else
        [out] = HIAD_X_07MAR17(pop(i,:));
        obj(i) = out.mass;
        con(i) = feval(constraint,out.k_0); % out.con;
    end
end

pop_out = [obj con pop];


end

