function cant_delta_tip(FEM)
try
    n = size(FEM.MODEL.nodes,1);
    
    if exist('FEM.MODEL.U_Pt')
    Uinc = [zeros(size(FEM.OUT.U)) FEM.OUT.Uinc];
    Utip = -Uinc(n*6 - 10,:);
    else
    Uinc = [zeros(size(FEM.OUT.U)) FEM.OUT.Uinc];
    Utip = -Uinc(n*6 - 4,:);
    end
        
    Finc = [zeros(size(FEM.OUT.U)) FEM.OUT.Finc];
    Ftip = -Finc(n*6 - 4,:); 
    
    figure(4)
    clf
    box on
    hold on
    
     plot(Utip, Ftip, 'b-')
     
     xlabel('Tip Displacement (in)');
     ylabel('Load (lb)');
     
catch
end
end