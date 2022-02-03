function [KL] = K_nonlin(tan_stiff,L)
%BEAM_STIFF_3D
%   Calculate the element stiffness matrix.  3D beam element, Cook et al.
%   (2002), condensed for corotational forumlation, Crisfield (1997) and
%   de Souza (2000)

% Extract variables
EA = tan_stiff(1);
EIzz1 = tan_stiff(2);
EIzz2 = tan_stiff(3);
EIyy1 = tan_stiff(4);
EIyy2 = tan_stiff(5);
GJ = tan_stiff(6);

% Constant axial and shear stiffness over element length
X = EA; %/L;
S = GJ; %/L;

% Assemble matrix
% [u1x u1y u1z r1x r1y r1z u2x u2y u2z r2x r2y r2z]
k = [X                       0                        0 0                        0                        0 -X                       0                        0 0                        0                        0
    0  (6*EIzz1 + 6*EIzz2)/L^3                        0 0                        0  (4*EIzz1 + 2*EIzz2)/L^2 0 -(6*EIzz1 + 6*EIzz2)/L^3                        0 0                        0  (2*EIzz1 + 4*EIzz2)/L^2
    0                        0  (6*EIyy1 + 6*EIyy2)/L^3 0  (4*EIyy1 + 2*EIyy2)/L^2                        0 0                        0 -(6*EIyy1 + 6*EIyy2)/L^3 0  (2*EIyy1 + 4*EIyy2)/L^2                        0
    0                        0                        0 S                        0                        0 0                        0                        0 -S                       0                        0
    0                        0  (4*EIyy1 + 2*EIyy2)/L^2 0      (3*EIyy1 + EIyy2)/L                        0 0                        0 -(4*EIyy1 + 2*EIyy2)/L^2 0        (EIyy1 + EIyy2)/L                        0
    0  (4*EIzz1 + 2*EIzz2)/L^2                        0 0                        0      (3*EIzz1 + EIzz2)/L 0 -(4*EIzz1 + 2*EIzz2)/L^2                        0 0                        0        (EIzz1 + EIzz2)/L
    -X                       0                        0 0                        0                        0 X                        0                        0 0                        0                        0
    0 -(6*EIzz1 + 6*EIzz2)/L^3                        0 0                        0 -(4*EIzz1 + 2*EIzz2)/L^2 0  (6*EIzz1 + 6*EIzz2)/L^3                        0 0                        0 -(2*EIzz1 + 4*EIzz2)/L^2
    0                        0 -(6*EIyy1 + 6*EIyy2)/L^3 0 -(4*EIyy1 + 2*EIyy2)/L^2                        0 0                        0  (6*EIyy1 + 6*EIyy2)/L^3 0 -(2*EIyy1 + 4*EIyy2)/L^2                        0
    0                        0                        0 -S                       0                        0 0                        0                        0 S                        0                        0
    0                        0  (2*EIyy1 + 4*EIyy2)/L^2 0        (EIyy1 + EIyy2)/L                        0 0                        0 -(2*EIyy1 + 4*EIyy2)/L^2 0      (EIyy1 + 3*EIyy2)/L                        0
    0  (2*EIzz1 + 4*EIzz2)/L^2                        0 0                        0        (EIzz1 + EIzz2)/L 0 -(2*EIzz1 + 4*EIzz2)/L^2                        0 0                        0      (EIzz1 + 3*EIzz2)/L];

% Condense into relevant entries for corotational formulation
k1 = [k(:,1) k(:,6) k(:,12) k(:,5) k(:,11) k(:,4)];

% [u1x r1z r2z r1y r2y r1x]
KL = [k1(1,:)
    k1(6,:)
    k1(12,:)
    k1(5,:)
    k1(11,:)
    k1(4,:)];

end

