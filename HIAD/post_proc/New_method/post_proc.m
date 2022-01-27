function post_proc(FEM, plot_tor)
% post_proc
% Plots model of either torus or HIAD

for i = 1:length(plot_tor)
    if plot_tor(i).n ~= 0
        
        % Get inputs from structures
        n = plot_tor(i).n;
        if (mod(n,2) == 0) && (mod(n,4) ~= 0)
            n = n + 1;
        end
        n = n + 1;
        LS = plot_tor(i).LS;
        frac = plot_tor(i).frac;
        tor_num = plot_tor(i).tor_num;
        
        
        Connect = FEM.MODEL.connect;
        nodes = FEM.MODEL.nodes;
        F = FEM.MODEL.F;
        orientation = FEM.MODEL.orientation;
        
        try
            FEM.OUT.U(1:size(FEM.OUT.Uinc,1)) = FEM.OUT.Uinc(:,LS);
            U = FEM.OUT.U;
        catch
            U = F*0;
        end
        
        % Get F2 and U2, add to FEM
        ind = 1:6:size(U,1);
        ind = [ind ind + 1 ind + 2 ind + 3 ind + 4 ind + 5]';
        U2 = zeros(length(U)/6,6);
        U2(:) = U(ind);
        F2 = zeros(length(F)/6,6);
        F2(:) = F(ind);
        
        FEM.OUT.U2 = U2;
        FEM.MODEL.F2 = F2;

        
        EL = FEM.EL;
        
        % Get plotting matrices
        [v,f,xyz,x2,y2,z2,N,n] = plotting_matrices(Connect,U2,nodes,orientation,...
           EL,plot_tor(i).scale,plot_tor(i).def,n,frac,tor_num);

        % Get color matrix
        if plot_tor(i).plot_type == 1
            [color_plot] = color_matrix(plot_tor(i).u_comp,Connect,U2,n,frac,N,tor_num);
        else
            color_plot = 0;
        end

        % Plotting
        figure(plot_tor(i).fig)
        hold on

        % Plot element 3s
        plot_el3( v,f,xyz,plot_tor(i),color_plot )

        %Plot elements other than 3
        if numel(unique(Connect(:,3))) ~= 1 || isempty(plot_tor(i).el_type) == 0
                plot_elements_24(plot_tor(i),Connect,x2,y2,z2)
            
        end

        % Plot forces
        if plot_tor(i).PF == 1
            plot_forces(F2,U2,nodes,plot_tor(i).scale)
        end

        % Triad
        if plot_tor(i).triad == 1;
            triad_loc = plot_tor(i).triad_loc;
            L = max(max(nodes))*.2;
            axes_triad(triad_loc(1),triad_loc(2),triad_loc(3),L,3)
        elseif plot_tor(i).triad == 2;
            triad_loc = plot_tor(i).triad_loc;
            L = max(max(nodes))*.1;
            axes_triad_cyl(triad_loc(1),triad_loc(2),triad_loc(3),L,3)
        end
        
        % Axes
        if plot_tor(i).axis == 0
            axis off
        end

        axis equal
        
        % Set view of torus
        view_orient(plot_tor(i).view)
        
        % Helps speed up rotating figure
        set(plot_tor(i).fig,'renderer','opengl')

        
% % %         FEM.PLOT.fig = plot_tor(i).fig;
% % %         FEM.PLOT.undef = 0;
% % %         FEM.PLOT.def = 1;
% % %         FEM.PLOT.scale = plot_tor.scale;
% % %         FE_plot_post(FEM)
    end
ax = gca;               % get the current axis
ax.Clipping = 'off';    % turn clipping off

end

end

