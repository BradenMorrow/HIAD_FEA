function plot_tor_shear_delta(FEM)

try
    n = size(FEM.MODEL.nodes,1);
    m_node = floor(n/2)+rem(n,2);
    
    Uinc = FEM.OUT.Uinc;
    Utip = Uinc(m_node*6 - 5,:); % Displacement increments of the end of the torus
    Utip = 2*Utip; % To account for the deflection on both sides of the structure
    Utip(:,1) = []; % Remove zeros colum (We are not starting at 0 loading)
    Utip = mean(Utip,1);
    
    Finc = FEM.OUT.Finc;
    Ftip = Finc(m_node*6-5,:); % Load a the bottom support (this will be the total load on the structure in the y direction
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
    disp('error');
end

% if (FEM.ANALYSIS.step == 25 || FEM.ANALYSIS.step == 35)
%     disp('display info');
% end


end