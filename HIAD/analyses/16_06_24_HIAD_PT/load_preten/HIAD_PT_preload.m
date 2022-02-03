function [FEM] = HIAD_PT_preload(C,alpha,pre_comp,strap_offset)
% Preload analysis for strap pretension optimization

% General geometric inputs
n_strap = 148; % Number of radial straps (divisible by 4)
n_strap2 = n_strap*4;
el_int = 1; % Number of elements between strap nodes

% Theta location of nodes
theta = linspace(0,2*pi,(n_strap2*el_int) + 1)';
theta(end) = [];
I_theta = (1:el_int:size(theta,1))'; % Strap indices

% Total drag load
F_drag = 480000; % 0; % 

% HIAD geometry
% C = [185.185453 84.342298
% 	213.724769 94.729760
% 	242.558759 105.224474
% 	271.650278 115.812921
% 	300.963157 126.481936
% 	322.382105 124.113612];
r = [31.837/2 % Minor radii of tori
    31.837/2
    31.837/2
    31.837/2
    31.837/2
    12.735/2];

% Load elements
% Torus elements
[MODEL_tor1,EL_tor1] = tor1(theta,C,r,alpha,1);
[MODEL_tor2,EL_tor2] = tor2(theta,C,r,alpha,2);
[MODEL_tor3,EL_tor3] = tor3(theta,C,r,alpha,3);
[MODEL_tor4,EL_tor4] = tor4(theta,C,r,alpha,4);
[MODEL_tor5,EL_tor5] = tor5(theta,C,r,alpha,5);
[MODEL_tor6,EL_tor6] = tor6(theta,C,r,alpha,6);
consol_tor

% Interaction elements
[MODEL_int1,EL_int1] = int1(theta,C(1,:),r(1),alpha,pre_comp(1));
[MODEL_int2,EL_int2] = int2(theta,C(2,:),pre_comp(2));
[MODEL_int3,EL_int3] = int3(theta,C(3,:),pre_comp(3));
[MODEL_int4,EL_int4] = int4(theta,C(4,:),pre_comp(4));
[MODEL_int5,EL_int5] = int5(theta,C(5,:),pre_comp(5));
[MODEL_int6,EL_int6] = int6(theta,C(6,:),pre_comp(6));
consol_int

% Strap link elements
[MODEL_link,EL_link,str] = links(theta,I_theta,C,r,alpha);
consol_link

% Strap elements
[MODEL_strap,EL_strap,strap_ind] = straps(theta,I_theta,str,strap_offset);
consol_strap

% Element indices for post processing
FEM.MODEL.theta_ind = indices(theta,strap_ind,EL_link);

% FE controls
[FEM.ANALYSIS] = FE_controls0;
[FEM.PLOT] = plot_controls0;

% % % % Apply quarter symmetry
% % % [FEM] = Qsym(FEM);

% post_proc_driver_new(FEM)
end