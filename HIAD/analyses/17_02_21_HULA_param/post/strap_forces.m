function strap_forces(FEM,straps,ID,EL_1,fig_1)
% Plot strap load history

% Open figures
fig_N = max(ID);
for i = fig_1:fig_1 + fig_N - 1
    figure(i)
    clf
    box on
    hold on
    
    xlabel('Ram Load (lbf)')
    ylabel('Strap Load (lbf)')
end

EL_ID = (EL_1:EL_1 + size(ID,1) - 1)'; % Strap elements

% Vertical reaction
RZ_ind = (3:6:size(FEM.OUT.Fext_inc,1))';
Rz = sum(FEM.OUT.Fext_inc(RZ_ind,:))';


for j = 1:fig_N
    % Elements for strap set j
    EL_IDj = EL_ID(ID == j);
    
    % Element axial forces
    f = FEM.OUT.fint_el(7,EL_IDj,:);
    f = permute(f,[2 3 1]);
    
    % Superimpose pretension
    f = f + straps(j).PT;
    
    % Plot
    figure(fig_1 + j - 1)
    hold on
    plot(Rz,f,'k--','linewidth',2)
    
    title(straps(j).strap_ID)
end






end

