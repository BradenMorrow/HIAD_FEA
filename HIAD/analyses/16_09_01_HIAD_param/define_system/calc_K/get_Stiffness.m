function [K_ax,K_shear] = get_Stiffness(r,p)
% Finds the cross direction axial and shear stiffness of a slender, 
% inflatable member given its minor radius and inflation pressure 
% r = minor radius
% inflation_P = inflation pressure
    
% r = 16; % inches
% p = 20; % psi

K_ax = calc_K_ax_driver(r,p); % lbf/in/in
K_shear = calc_K_shear_driver(r,p); % lbf/in/in
end

