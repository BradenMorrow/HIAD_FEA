function [KL] = k3(tan_stiff,L,e,r,t,p)
%K3
%   Calculate the element tangent stiffness matrix.  3D beam element, Cook 
%   et al. (2002), condensed for corotational forumlation, Crisfield (1997)
%   and de Souza (2000) Shear based on Friedman and Kosmatka (1992), (also 
%   in Cook 2002)

% Extract variables
EA = tan_stiff(1);
EIzz = tan_stiff(2); % + mean(abs(PV_work));
EIyy = tan_stiff(3); % + mean(abs(PV_work));
G = tan_stiff(4);
GJ = G*2*pi*r^3*t;

A = 2*pi*r*t; % Area of shell
ke = 2.0; % A/k = effective shear area (ke is 2.0 for a thin walled tube)

% Constant axial and shear stiffness over element length
X = EA/L;
S = GJ/L;

% Bending and shear stiffness are constant over element length
phi_y = 12*EIzz/((G*A/ke + p*pi*r^2)*L^2);
Y1 = 12*EIzz/((1 + phi_y)*L^3);
Y2 = 6*EIzz/((1 + phi_y)*L^2);
Y3 = 4*EIzz/(L + phi_y*L) + phi_y*EIzz/(L + phi_y*L);
Y4 = 2*EIzz/(L + phi_y*L) - phi_y*EIzz/(L + phi_y*L);

phi_z = 12*EIyy/((G*A/ke + p*pi*r^2)*L^2);
Z1 = 12*EIyy/((1 + phi_z)*L^3);
Z2 = 6*EIyy/((1 + phi_z)*L^2);
Z3 = 4*EIyy/(L + phi_z*L) + phi_z*EIyy/(L + phi_z*L);
Z4 = 2*EIyy/(L + phi_z*L) - phi_z*EIyy/(L + phi_z*L);

% Assemble matrix
% [u1x u1y u1z r1x r1y r1z u2x u2y u2z r2x r2y r2z]
k0 = [X  0   0   0   0   0   -X  0   0   0   0   0
    0   Y1  0   0   0   Y2  0   -Y1 0   0   0   Y2
    0   0   Z1  0   -Z2 0   0   0   -Z1 0   -Z2 0
    0   0   0   S   0   0   0   0   0   -S  0   0
    0   0   -Z2 0   Z3  0   0   0   Z2  0   Z4  0
    0   Y2  0   0   0   Y3  0   -Y2 0   0   0   Y4
    -X  0   0   0   0   0   X   0   0   0   0   0
    0   -Y1 0   0   0   -Y2 0   Y1  0   0   0   -Y2
    0   0   -Z1 0   Z2  0   0   0   Z1  0   Z2  0
    0 	0   0   -S  0   0   0   0   0   S   0   0
    0   0   -Z2 0   Z4  0   0   0   Z2  0   Z3  0
    0   Y2  0   0   0   Y4  0   -Y2 0   0   0   Y3];


% Transform sections (rotate about x axis)
T = T_section(e);
k1 = T*k0*T';

% Condense into relevant entries for corotational formulation
k2 = [k1(:,1) k1(:,6) k1(:,12) k1(:,5) k1(:,11) k1(:,4)];

% [u1x r1z r2z r1y r2y r1x]
KL = [k2(1,:)
    k2(6,:)
    k2(12,:)
    k2(5,:)
    k2(11,:)
    k2(4,:)];

end


