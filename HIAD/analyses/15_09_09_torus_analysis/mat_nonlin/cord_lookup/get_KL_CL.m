function [KL,EI,EA,d2i,d2j,Bi,Bj] = get_KL_CL(k_cord,phi_i,phi_j,alpha,r,EL,t,GLH,d1i,d1j,y_bar,L,L0)

%% TANGENT STIFFNESS
% Strain in cords due to curvature
% % % % Derivative of force - strain curve is stiffness
% % % if lookup == 1
% % %     k_cord = ppval(axial_1,eps_cord);
% % % elseif lookup == 2
% % %     k_cord = interp1(axial1(:,2),axial1(:,1),eps_cord,interp_meth);
% % % end

% Perpendicular distance from cords to line perpendicular to NA through A
d2i = r*sind(phi_i*180/pi + alpha);
d2j = r*sind(phi_j*180/pi + alpha);

% Location of centroid
Bi = sum(k_cord(:,1).*d2i)/(sum(k_cord(:,1)) + EL*2*pi*r*t);
Bj = sum(k_cord(:,2).*d2j)/(sum(k_cord(:,2)) + EL*2*pi*r*t);

% Axial and shear stiffness
EA1 = sum(k_cord(:,1)) + EL*2*pi*r*t;
EA2 = sum(k_cord(:,2)) + EL*2*pi*r*t;
EA = (EA1 + EA2)/2;

% Bending stiffness, (about NA)
EI11i = sum(k_cord(:,1).*d1i.^2) + EL*(pi*r^3*t + 2*pi*r*t*y_bar(1)^2);
EI22i = sum(k_cord(:,1).*(d2i - Bi).^2) + EL*(pi*r^3*t + 2*pi*r*t*Bi^2);

EI11j = sum(k_cord(:,2).*d1j.^2) + EL*(pi*r^3*t + 2*pi*r*t*y_bar(2)^2);
EI22j = sum(k_cord(:,2).*(d2j - Bj).^2) + EL*(pi*r^3*t + 2*pi*r*t*Bj^2);

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

try
    [e,EI_princ] = eig(EI_NA);
catch err
    disp(err.message)
end


% Linearized tangent stiffness matrix
% [ul r1z r2z r1y r2y rx]'
tan_stiff = [EA EI_princ(1,1) EI_princ(2,2) GLH]';
KL = K_nonlin_shear(tan_stiff,L,L0,e,r,t);

% Pass out tangent stiffness for next itteration
EI = [(EIzzi + EIzzj)/2 (EIyyi + EIyyj)/2 EA];


% disp([EI_princ e])
end

