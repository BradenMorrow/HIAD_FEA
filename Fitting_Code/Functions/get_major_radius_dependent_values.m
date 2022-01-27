function [Xguess, r_bound, z_bound_t] = get_major_radius_dependent_values(name)

rmin = -250;
rmax = 95+100;
zmin = -130;
if strfind(name,'T1')
    Xguess = [0.1; 0.1; 1; 38; 0.001; 0.001];% x, y, z [shifts], R, thetaX, thetaY
    r_bound= 976 + [rmin rmax]; z_bound_t=[zmin 0]; % Define r_bound_t based on R - Use SI units to be consistent with what we've been doing (mm)
elseif strfind(name,'T2')
    Xguess = [0.1; 0.1; 1; 49; 0.001; 0.001];% x, y, z [shifts], R, thetaX, thetaY
    r_bound= 1240 + [rmin rmax]; z_bound_t=[zmin 0]; % Define r_bound_t based on R - Use SI units to be consistent with what we've been doing (mm)
elseif strfind(name,'T3')
    Xguess = [0.1; 0.1; 1; 59; 0.01; 0.01];% x, y, z [shifts], R, thetaX, thetaY
    r_bound= 1505 + [rmin rmax]; z_bound_t=[zmin 0]; % Define r_bound_t based on R - Use SI units to be consistent with what we've been doing (mm)
elseif strfind(name,'T4')
    Xguess = [0.1; 0.1; 15; 69; 0.001; 0.001];% x, y, z [shifts], R, thetaX, thetaY
    r_bound= 1772 + [rmin rmax]; z_bound_t=[zmin 0]; % Define r_bound_t based on R - Use SI units to be consistent with what we've been doing (mm)
elseif strfind(name,'T5')
    Xguess = [0.1; 0.1; 15; 80; 0.001; 0.001];% x, y, z [shifts], R, thetaX, thetaY
    r_bound= 2047 + [rmin rmax]; z_bound_t=[zmin 0]; % Define r_bound_t based on R - Use SI units to be consistent with what we've been doing (mm)
else
        Xguess = [0.1; 0.1; 1; 59; 0.01; 0.01];% x, y, z [shifts], R, thetaX, thetaY
    r_bound= 1505 + [rmin rmax]; z_bound_t=[zmin 0]; % Define r_bound_t based on R - Use SI units to be consistent with what we've been doing (mm)
    disp('Cannot get major radius, using T3 values')
end