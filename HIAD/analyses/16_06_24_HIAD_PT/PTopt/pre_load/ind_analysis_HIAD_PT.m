function [pop_out] = ind_analysis_HIAD_PT(objective,constraint,population,mating_pool,mp_switch)
% Evaluate individuals in GA


% Determine objective function and constraint function values
global FEM
FEM_worker = FEM;

pop_vals = population(:,3:end);
obj = zeros(size(population,1),1);
con = zeros(size(population,1),1);

if mp_switch
    MP1 = mating_pool(:,1);
    MP2 = mating_pool(:,2);
else
    MP1 = zeros(size(population,1),1);
    MP2 = zeros(size(population,1),1);
end


parfor i = 1:size(population,1);
    if mp_switch
        if obj(i) == MP1(i) && con(i) == MP2(i)
            % Nothing happens
        else
            [strap_F,Cout] = apply_preten(FEM_worker,pop_vals(i,:));
            obj(i) = feval(objective,strap_F);
            con(i) = feval(constraint,Cout);
        end
    else
        [strap_F,Cout] = apply_preten(FEM_worker,pop_vals(i,:));
        obj(i) = feval(objective,strap_F);
        con(i) = feval(constraint,Cout);
    end
end

pop_out = population;

pop_out(:,1) = obj;
pop_out(:,2) = con;

end

