function [FEM] = update_cords(FEM)


config = length(FEM.CONFIG);
n = length(FEM.CONFIG.element);

for i = 1:config % Torus configurations
    for j = 1:n % Elements
        % Element cord strains, strain rates and forces
        str_rate = FEM.CONFIG(i).element(j).eps - FEM.CONFIG(i).element(j).eps0;
        str = FEM.CONFIG(i).element(j).eps;
        str0 = FEM.CONFIG(i).element(j).eps0;
        
        F = FEM.CONFIG(i).element(j).f;
        F0 = FEM.CONFIG(i).element(j).f0;
        
        % Update element strain
        FEM.CONFIG(i).element(j).eps0 = FEM.CONFIG(i).element(j).eps;
        FEM.CONFIG(i).element(j).f0 = F;
        for k = 1:2 % Nodes
            for l = 1:length(FEM.CONFIG(i).alpha) % Cords
                % Cord strains, strain rates and forces
                eps0 = str0(l,k);
                eps = str(l,k);
                f0 = F0(l,k);
                f = F(l,k);
                eps_rate = str_rate(l,k);
                eps_rate_old = FEM.CONFIG(i).element(j).nodes(k).cords(l).eps_rate;
                
                % Update loading and unloading pivot points
                load_point = FEM.CONFIG(i).element(j).nodes(k).cords(l).load_point;
                unload_point = FEM.CONFIG(i).element(j).nodes(k).cords(l).unload_point;
                
                % Eliminate old pivot points if needed
                if eps > unload_point(end,2) && size(load_point,1) > 1 && size(unload_point,1) > 1
                    ind = size(unload_point,1);
                    unload_point(ind,:) = [];
                    if size(load_point,1) == ind;
                        load_point(ind,:) = [];
                    end
                end
                
                % Add new pivot points if needed
                if eps_rate < 0 && eps_rate_old > 0
                    unload_point = [unload_point
                        f0 eps0];
                elseif eps_rate > 0 && eps_rate_old < 0
                    load_point = [load_point
                        f0 eps0];
                end
                
                % Update element
                FEM.CONFIG(i).element(j).nodes(k).cords(l).eps_rate = eps_rate;
                FEM.CONFIG(i).element(j).nodes(k).cords(l).load_point = load_point;
                FEM.CONFIG(i).element(j).nodes(k).cords(l).unload_point = unload_point;
            end
        end
    end
end
end














