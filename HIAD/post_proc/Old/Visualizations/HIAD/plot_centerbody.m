function plot_centerbody( centerbody )
% plot_centerbody 
%   Plots centerbody for HIAD

% Get rest of structure
[centerbody] = HIAD_var(centerbody);

% Get variables
c_c = centerbody.c_c;
h_c1 = centerbody.h_c1;
h_c2 = centerbody.h_c2;
h_c3 = centerbody.h_c3;
h_z = centerbody.h_z;
n = centerbody.n;
r_c1 = centerbody.r_c1;
r_c2 = centerbody.r_c2;
r_c3 = centerbody.r_c3;


% Cylinder with radius r_c, starting at h_z with height h_c
[X,Y,Z] = cylinder(r_c1,n);
Z = Z*h_c1 + (h_z + 5);

% Plot main cylinder
surf(X,Y,Z,'FaceColor',c_c,'LineStyle','none')
theta = linspace(0,2*pi,n);
fill3((r_c1)*cos(theta),(r_c1)*sin(theta),ones(size(theta))*(h_z + h_c1 + 5),c_c,'EdgeColor','none')

% Plot smaller cylinders
[X1,Y1,Z1] = cylinder(r_c2,n);
Z1 = Z1*h_c2 + h_z + h_c1;
surf(X1,Y1,Z1,'FaceColor',c_c,'LineStyle','none')
fill3((r_c2)*cos(theta),(r_c2)*sin(theta),ones(size(theta))*(h_z + h_c1 + h_c2),c_c,'EdgeColor','none')

[X2,Y2,Z2] = cylinder(r_c3,n);
Z2 = Z2*h_c3 + h_z + h_c1 + h_c2;
surf(X2,Y2,Z2,'FaceColor',c_c,'LineStyle','none')
fill3((r_c3)*cos(theta),(r_c3)*sin(theta),ones(size(theta))*(h_z + h_c1 + h_c2 + h_c3),c_c,'EdgeColor','none')
end

