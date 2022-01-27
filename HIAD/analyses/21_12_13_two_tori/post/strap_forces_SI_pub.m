function strap_forces_SI_pub(FEM,straps,ID,EL_1,fig_1)
% Plot strap load history

Ffac_kN = 0.004448; % 1; % 
Ffac_kN = Ffac_kN; % *1000; % 

% Open figures
fig_N = max(ID);
for i = fig_1:fig_1 + fig_N - 1
    figure(i)
    clf
    box on
    hold on
    
    xlabel('Ram Load (kN)')
    ylabel('Strap Load (kN)')
end

EL_ID = (EL_1:EL_1 + size(ID,1) - 1)';


RZ_ind = (3:6:size(FEM.OUT.Fext_inc,1))';
Rz = sum(FEM.OUT.Fext_inc(RZ_ind,:))';


for j = 1:fig_N
    
    
    EL_IDj = EL_ID(ID == j);
    
    f = FEM.OUT.fint_el(7,EL_IDj(1),:);
    f = permute(f,[2 3 1])';
    
    % PRETENSION
    % % % f = f + straps(j).PT;
    
    figure(fig_1 + j - 1)
    hold on
    plot(Rz*Ffac_kN,f*Ffac_kN,'r-','linewidth',1.5)
    
    title(straps(j).strap_ID)

    
    
end






end

