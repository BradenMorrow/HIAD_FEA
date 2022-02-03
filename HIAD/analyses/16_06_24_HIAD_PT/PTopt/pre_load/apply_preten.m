function [strap_F,Cout] = apply_preten(FEM_pt,eps)

% global FEM
% 
% % Create new, prestrained model
% FEM_pt = FEM;

% Apply strap pretension
ind = FEM_pt.MODEL.theta_ind; % Extract indices

count = 1;
for i = 14:29 % Loop through strap element sets
    for j = 1:size(ind(i).ind,1) % Loop through straps
        FEM_pt.EL(ind(i).ind(j)).el_in0.eps0 = eps(count); % Apply pretension
    end
    count = count + 1;
end


% Analysis
[FEM_out] = increment_FE(FEM_pt);

% Strap forces
[strap_F] = get_strap_F(FEM_out);

% Torus locations
[Cout] = get_Cout(FEM_out);

end

