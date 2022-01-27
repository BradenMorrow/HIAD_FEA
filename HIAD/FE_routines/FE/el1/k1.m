function [k] = k1(material,geom,L)
%k_lin_beam
%   Calculate the local element stiffness matrix.  3D beam element, Cook et al.
%   (2002)

% Extract variables
E = material(1);
nu = material(2);
G = E/(2*(1 + nu));

A = geom(1);
Izz = geom(2);
Iyy = geom(3);
ky = geom(4);
J = geom(5);

% Calculate entries of stiffness matrix
X = E*A/L;
S = G*J/L;

phi_y = 12*E*Izz*ky/(A*G*L^2);
Y1 = 12*E*Izz/((1 + phi_y)*L^3);
Y2 = 6*E*Izz/((1 + phi_y)*L^2);
Y3 = (4 + phi_y)*E*Izz/((1 + phi_y)*L);
Y4 = (2 - phi_y)*E*Izz/((1 + phi_y)*L);

phi_z = 12*E*Iyy*ky/(A*G*L^2);
Z1 = 12*E*Iyy/((1 + phi_z)*L^3);
Z2 = 6*E*Iyy/((1 + phi_z)*L^2);
Z3 = (4 + phi_z)*E*Iyy/((1 + phi_z)*L);
Z4 = (2 - phi_z)*E*Iyy/((1 + phi_z)*L);

% Assemble matrix
k = [X  0   0   0   0   0   -X  0   0   0   0   0
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

end

