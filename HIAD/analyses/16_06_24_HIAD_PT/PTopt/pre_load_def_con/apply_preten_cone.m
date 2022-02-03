function [obj] = apply_preten_cone(eps)

global Cout

% New locations of torus centers
C0 = [185.185453 84.342298
	213.724769 94.729760
	242.558759 105.224474
	271.650278 115.812921
	300.963157 126.481936
	322.382105 124.113612];
[Crot] = rot_HIAD(eps(end),C0);


% Create new, prestrained model
% Load model
alpha = 70 - eps(end);
[FEM_pt] = HIAD_PT_preload(Crot,alpha);

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

% Strap forces
[strap_F_obj] = get_strap_obj(strap_F);
[di] = get_D(Cout);

obj = strap_F_obj + sum(di)*100;



end

