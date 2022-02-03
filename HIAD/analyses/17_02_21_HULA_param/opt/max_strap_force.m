function [f_penalty] = max_strap_force(FEM,straps,ID,EL_1)
% Find maximum strap forces

% Strap elements
EL_ID = (EL_1:EL_1 + size(ID,1) - 1)';

% External load
RZ_ind = (3:6:size(FEM.OUT.Fext_inc,1))';
Rz = sum(FEM.OUT.Fext_inc(RZ_ind,:))';

% Initialize penalty
f_penalty = 0;

% Loop through strap sets
for j = 1:max(ID)
    
    EL_IDj = EL_ID(ID == j);
    
    % Internal strap forces in set
    f = FEM.OUT.fint_el(7,EL_IDj,:);
    f = permute(f,[2 3 1]);
    
    f = f + straps(j).PT;
    
    f_max = max(f,[],2); % Maximum force in each strap
    
    maxF = straps(j).maxF; % Check if strap violates maximum allowable force
    if maxF > 0
        f_delta = f_max - maxF; % Magnitude above maximum force
        f_penalty_j = sum(f_delta(f_delta > 0).^2); % Penalty
    else
        f_penalty_j = 0;
    end
    
    f_penalty = f_penalty + f_penalty_j; % Total penalty
end

end

