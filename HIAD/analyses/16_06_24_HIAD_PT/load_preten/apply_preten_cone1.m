function [obj,FEM_out1] = apply_preten_cone1(eps,F_pt)

global Cout


%% Prestrain step
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

pre_comp = [-.04605 -.04605 -.0362 -.027592 -.020193 -.033048]';
strap_offset = false;
[FEM_pt] = HIAD_PT_preload(Crot,alpha,pre_comp,strap_offset);


% Save loading vector for subsequent analysis
% F_pt = FEM_pt.MODEL.F_pt;
% FEM_pt.MODEL.F_pt = F_pt*0;
FEM_pt.MODEL.F_pt = FEM_pt.MODEL.F_pt*0;

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
[FEM_out0] = increment_FE(FEM_pt);

% Strap forces
[strap_F] = get_strap_F(FEM_out0);

% Torus locations
[Cout] = get_Cout(FEM_out0);

% Strap forces
[strap_F_obj] = get_strap_obj(strap_F);
[di] = get_D(Cout);

obj = strap_F_obj + sum(di)*100;




%% Loading step
FEM_load = FEM_out0;
FEM_load.MODEL.F_pt = F_pt;

FEM_load.ANALYSIS = FE_controls1;
FEM_load.PLOT = plot_controls1;
FEM_load.PLOT.pt = [0 0 0 0 0 0]';


[FEM_out1] = increment_FE(FEM_load);






end

