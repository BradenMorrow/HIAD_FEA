function post_proc_copy(FEM, plot_tor)
% post_proc
% Plots model of either torus or HIAD

for i = 1:length(plot_tor)
    if plot_tor(i).n ~= 0
        
        % Get inputs from structures
        n = plot_tor(i).n;
        n = n + 1;
        LS = plot_tor(i).LS;
        
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
        [x_plot,y_plot,z_plot,xyz,x2,y2,z2] = plotting_matrices_copy(Connect,U2,nodes,orientation,EL,plot_tor(i).scale,plot_tor(i).def,n);

        % Get color matrix
        if plot_tor(i).plot_type == 1
            [color_plot] = color_matrix_copy(plot_tor(i).u_comp,Connect,U2,n,x_plot);
        else
            color_plot = 0;
        end

        % Plot the figure
        figure(plot_tor(i).fig)
        hold on
        plot_elements_3(x_plot,y_plot,z_plot,xyz,color_plot,plot_tor(i))

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
        end
        
        % Axes
        if plot_tor(i).axis == 0
            axis off
        end

        axis equal

        % View of torus
        view_orient(plot_tor(i).view)

        % Helps speed up rotating figure
        set(plot_tor(i).fig,'renderer','opengl')

    end
end
end