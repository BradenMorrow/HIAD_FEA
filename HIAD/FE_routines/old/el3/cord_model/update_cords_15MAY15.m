function [FEM] = update_cords_15MAY15(FEM)


config = length(FEM.CONFIG);
n = length(FEM.CONFIG.element);


for i = 1:config % Torus configurations
    d_LOAD = FEM.CONFIG(i).d_LOAD;
    d_UNLOAD = FEM.CONFIG(i).d_UNLOAD;
    
    for j = 1:n % Elements
        % Element cord strains, strain rates and forces
        str_rate = FEM.CONFIG(i).element(j).eps - FEM.CONFIG(i).element(j).eps0;
        str = FEM.CONFIG(i).element(j).eps;
        str0 = FEM.CONFIG(i).element(j).eps0;
        FEM.CONFIG(i).element(j).eps0 = FEM.CONFIG(i).element(j).eps;
        
        
        F = FEM.CONFIG(i).element(j).f;
        F0 = FEM.CONFIG(i).element(j).f0;
        FEM.CONFIG(i).element(j).f0 = FEM.CONFIG(i).element(j).f;
        
        FEM.CONFIG(i).element(j).f_shell0 = FEM.CONFIG(i).element(j).f_shell;
        
        
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
                
                % Add new pivot points if needed
                if eps_rate < 0 && eps_rate_old > 0 && eps > 0 && abs(f - unload_point(end,1)) > unload_point(end,1)/100
                    unload_point = [unload_point
                        f0 eps0];
                elseif eps_rate > 0 && eps_rate_old < 0 && eps > 0 && size(load_point,1) + 1 == size(unload_point,1) && abs(f - load_point(end,1)) > load_point(end,1)/100
                    load_point = [load_point
                        f0 eps0];
                end
                
                % Eliminate old pivot points if needed
                while (eps > unload_point(end,2) || f > unload_point(end,1)) && size(load_point,1) > 1 && size(unload_point,1) > 1
                    ind = size(unload_point,1);
                    unload_point(ind,:) = [];
                    if size(load_point,1) >= ind;
                        load_point(ind,:) = [];
                    end
                end
                
                if load_point(end,1) < 0
                    load_point(end,:) = [];
                end
                
                if eps < 0 || unload_point(end,2) < 0 || load_point(end,2) < 0
                    unload_point = [0 0];
                    load_point = [0 0];
                end
                
                
                if eps < 0
                    a = 1;
                end
                
                % Update cord model
                if FEM.ANALYSIS.cord_update == 1
                    [d] = cord_model_27MAY15(eps,f,load_point,unload_point,d_LOAD,d_UNLOAD,eps_rate);
                else
                    d = FEM.CONFIG(i).element(j).nodes(k).cords(l).axial; % load('axial_table_12_03SEP15');
                end
                
                if i == 1 && j == 15 && k == 1 && l == 1
%                     eps
%                     disp(d)
                end
                
%                 if sum((d(2:end,2) - d(1:end - 1,2)) < 0) > 0
%                     a = 1;
%                 end
%                 
%                 if k == 2
%                     d_j = d;
%                 end
%                 if k == 1 && j > 1
%                     d = d_j;
%                 end
                
                % Update element
                FEM.CONFIG(i).element(j).nodes(k).cords(l).eps_rate = eps_rate;
                FEM.CONFIG(i).element(j).nodes(k).cords(l).load_point = load_point;
                FEM.CONFIG(i).element(j).nodes(k).cords(l).unload_point = unload_point;
                FEM.CONFIG(i).element(j).nodes(k).cords(l).axial = d;
                
%                 cords.CONFIG(i).element(j).nodes(k).cords(l).axial = d0;
                
                
%                 FEM.CONFIG(i).element(j).nodes(k).cords(l).axial1 = d1;
                
% % %                 if j == n
% % %                     figure(12)
% % %                     clf
% % %                     box on
% % %                     hold on
% % %                     plot(d(:,2),d(:,1),'bx-')
% % %                     plot(d(:,2),d(:,1),'bx-')
% % %                     
% % %                     xlim([0 .03])
% % %                     ylim([-50 3000])
% % %                 end
            end
        end
    end
end
end














