function plot_tor_ax_delta(FEM)
try
    Uinc = FEM.OUT.Uinc;
    n_loaded_num = FEM.MODEL.n_loaded';
    Utip = -Uinc(n_loaded_num*6 - 4,:); % Displacement increments of the end of the torus
    Utip = 2*Utip; % To account for the deflection on both sides of the structure
    Utip(:,1) = []; % Remove zeros colum (We are not starting at 0 loading)
    Utip = mean(Utip,1);
    
    Finc = FEM.OUT.Finc;
    Ftip = Finc(2,:); % Load a the bottom support (this will be the total load on the structure in the y direction
    Ftip = 2*Ftip; % Because half the load was used for quarter symmetry
    Ftip(:,1) = []; % Remove zeros colum
    
    
    figure(5)
    clf
    box on
    hold on
    
    Fmax = min(Ftip);
    Ftip = Ftip + (-Fmax);
    plot(Utip, Ftip, 'b-x');
    xlabel('Displacement (in)');
    ylabel('Load (lb)');
   
   
catch
%     disp('error')
end

% if (FEM.ANALYSIS.step == 33 || FEM.ANALYSIS.step == 66)
%     disp('display info');
% end


end