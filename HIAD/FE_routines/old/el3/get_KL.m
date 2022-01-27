function [KL,EI] = get_KL(k_cord,p,r,alpha,EL,GLH,t,L)
%GET_KL
%   Obtain the linear beam element tangent stiffness matrix

% Perpendicular distance from z axis to cords
d1i = r*cosd(alpha);
d1j = r*cosd(alpha);

% Perpendicular distance from y axis to cords
d2i = r*sind(alpha);
d2j = r*sind(alpha);

% Axial and shear stiffness
EA1 = sum(k_cord(:,1)) + EL*2*pi*r*t;
EA2 = sum(k_cord(:,2)) + EL*2*pi*r*t;
EA = (EA1 + EA2)/2;

% Bending stiffness about zz and yy axes
EIzzi = sum(k_cord(:,1).*d1i.^2) + EL*pi*r^3*t;
EIyyi = sum(k_cord(:,1).*d2i.^2) + EL*pi*r^3*t;

EIzzj = sum(k_cord(:,2).*d1j.^2) + EL*pi*r^3*t;
EIyyj = sum(k_cord(:,2).*d2j.^2) + EL*pi*r^3*t;

EIzyi = sum(k_cord(:,1).*d1i.*d2i);
EIzyj = sum(k_cord(:,2).*d1j.*d2j);

% Find principal axes and principal stiffness terms
EIzz = (EIzzi + EIzzj)/2;
EIyy = (EIyyi + EIyyj)/2;
EIzy = (EIzyi + EIzyj)/2;
EI_NA = [EIzz EIzy
    EIzy EIyy];

[e,EI_princ] = eig(EI_NA);

% Linearized tangent stiffness matrix
% [ul r1z r2z r1y r2y rx]'
tan_stiff = [EA EI_princ(1,1) EI_princ(2,2) GLH]';
KL = k3(tan_stiff,L,e,r,t,p);

% Pass out tangent stiffness for next itteration
EI = [(EIzzi + EIzzj)/2 (EIyyi + EIyyj)/2 EA];

end

