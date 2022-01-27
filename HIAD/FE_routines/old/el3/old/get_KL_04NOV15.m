function [KL,EI,d2i,d2j,Bi,Bj] = get_KL(k_cord,phi_i,phi_j,p,r,alpha,EL,GLH,t,d1i,d1j,y_bar,L)
%GET_KL
%   Obtain the linear beam element tangent stiffness matrix

% Perpendicular distance from cords to line perpendicular to NA through A
d2i = r*sind(phi_i*180/pi + alpha);
d2j = r*sind(phi_j*180/pi + alpha);

% Location of centroid
Bi = sum(k_cord(:,1).*d2i)/(sum(k_cord(:,1)) + EL*2*pi*r*t);
Bj = sum(k_cord(:,2).*d2j)/(sum(k_cord(:,2)) + EL*2*pi*r*t);

% Axial and shear stiffness
EA1 = sum(k_cord(:,1)) + EL*2*pi*r*t;
EA2 = sum(k_cord(:,2)) + EL*2*pi*r*t;
EA = (EA1 + EA2)/2; % 5.6652e+05; % 

% Bending stiffness, (about NA)
EI11i = sum(k_cord(:,1).*d1i.^2) + EL*(pi*r^3*t + 2*pi*r*t*y_bar(1)^2); % + mean(abs(PV_work));
EI22i = sum(k_cord(:,1).*(d2i - Bi).^2) + EL*(pi*r^3*t + 2*pi*r*t*Bi^2); % + mean(abs(PV_work));

EI11j = sum(k_cord(:,2).*d1j.^2) + EL*(pi*r^3*t + 2*pi*r*t*y_bar(2)^2); % + mean(abs(PV_work));
EI22j = sum(k_cord(:,2).*(d2j - Bj).^2) + EL*(pi*r^3*t + 2*pi*r*t*Bj^2); % + mean(abs(PV_work));

EI12i = sum(k_cord(:,1).*d1i.*(d2i - Bi)) + EL*2*pi*r*t*-y_bar(1)*-Bi;
EI12j = sum(k_cord(:,2).*d1j.*(d2j - Bj)) + EL*2*pi*r*t*-y_bar(2)*-Bj;

% Bending stiffness about zz and yy axes
EIzzi = (EI11i + EI22i)/2 + (EI11i - EI22i)/2*cos(-2*phi_i) - EI12i*sin(-2*phi_i);
EIyyi = (EI11i + EI22i)/2 - (EI11i - EI22i)/2*cos(-2*phi_i) + EI12i*sin(-2*phi_i);
EIzyi = (EI11i - EI22i)/2*sin(-2*phi_i) + EI12i*cos(-2*phi_i);

EIzzj = (EI11j + EI22j)/2 + (EI11j - EI22j)/2*cos(-2*phi_j) - EI12j*sin(-2*phi_j);
EIyyj = (EI11j + EI22j)/2 - (EI11j - EI22j)/2*cos(-2*phi_j) + EI12j*sin(-2*phi_j);
EIzyj = (EI11j - EI22j)/2*sin(-2*phi_j) + EI12j*cos(-2*phi_j);

% Find principal axes and principal stiffnesses
EIzz = (EIzzi + EIzzj)/2;
EIyy = (EIyyi + EIyyj)/2;
EIzy = (EIzyi + EIzyj)/2;
EI_NA = [EIzz EIzy
    EIzy EIyy];

[e,EI_princ] = eig(EI_NA);


% [EA1 EA2 EA]
% Linearized tangent stiffness matrix
% [ul r1z r2z r1y r2y rx]'
tan_stiff = [EA EI_princ(1,1) EI_princ(2,2) GLH]';
tan_stiff(2:3) = tan_stiff(2:3);
KL = k3(tan_stiff,L,e,r,t,p);

% Pass out tangent stiffness for next itteration
EI = [(EIzzi + EIzzj)/2 (EIyyi + EIyyj)/2 EA];

end

