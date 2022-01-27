function [KL,P,EI,PV_work] = get_KL_P(el_in0)
%GET_KL_P
%   Obtain the linearized beam element stiffness matrix and internal
%   forces.

% Extract variables
p = el_in0.p;
r = el_in0.r;
alpha = el_in0.alpha;
beta = el_in0.beta;

cords = el_in0.nodes;

eps_cord_old = el_in0.eps;

propsLH = el_in0.propsLH;
EL = propsLH(1);
GLH = propsLH(3);
t = propsLH(5)*3;

EI0 = el_in0.EI;
D = el_in0.D;
L = el_in0.L;

el = el_in0.el;

% Obtain element state
[eps_cord,f_cord,k_cord,kappa] = find_NA(D,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,el);

% Calculate tangent stiffness
[KL,EI] = get_KL(k_cord,p,r,alpha,EL,GLH,t,L);

% Calculate element forces
% Axial
P10 = sum(f_cord)' + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*D(1)/L - p*pi*r^2;
P1 = P10(2);

% Torsional
P6 = GLH*2*pi*r^3*t/L*D(6);

% Mzi
P2 = sum(f_cord(:,1)*r.*cosd(alpha)) - EL*pi*r^3*t*kappa(1,1);

% Mzj
P3 = -sum(f_cord(:,2)*r.*cosd(alpha)) + EL*pi*r^3*t*kappa(2,1);

% Myi
P4 = -sum(f_cord(:,1)*r.*sind(alpha)) - EL*pi*r^3*t*kappa(1,2);

% Myj
P5 = sum(f_cord(:,2)*r.*sind(alpha)) + EL*pi*r^3*t*kappa(2,2);

% [Pax Mzi Mzj Myi Myj Tx];
P = [P1 P2 P3 P4 P5 P6]';

% Curvature, kappa = 
% [kappa_zz1 kappa_yy1
% kappa_zz2 kappa_yy2]

% Place-holder, work due to volume change
PV_work = 1;


% % % % Calculate numerical derivatives for extensional-bending coupling terms
% % % K_couple = zeros(6);
% % % dD = 1e-10;
% % % 
% % % for i = 1:5
% % %     D1 = D; % Reset displacement vector
% % %     D1(i) = D1(i) + dD; % Perturb displacement vector
% % %     
% % %     % Calculate new element state
% % %     [~,f_cord1,~,kappa1] = find_NA(D1,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,el);
% % %     
% % %     % Calculate new element forces
% % %     P102 = sum(f_cord1)' + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*D1(1)/L - p*pi*r^2;
% % %     P1_1 = P102(1); % Pax
% % % 
% % %     P2_1 = sum(f_cord1(:,1)*r.*cosd(alpha)) - EL*pi*r^3*t*kappa1(1,1); % Mzi
% % %     P3_1 = -sum(f_cord1(:,2)*r.*cosd(alpha)) + EL*pi*r^3*t*kappa1(2,1); % Mzj
% % % 
% % %     P4_1 = -sum(f_cord1(:,1)*r.*sind(alpha)) - EL*pi*r^3*t*kappa1(1,2); % Myi
% % %     P5_1 = sum(f_cord1(:,2)*r.*sind(alpha)) + EL*pi*r^3*t*kappa1(2,2); % Myj
% % % 
% % %     P_1 = [P1_1 P2_1 P3_1 P4_1 P5_1 0]';
% % % 
% % %     % Change in element forces
% % %     dP = P_1 - P;
% % %     
% % %     % dP/dD
% % %     K_couple(:,i) = dP/dD;
% % % end
% % % 
% % % 
% % % % Add coupling terms to element stiffness matrix
% % % KL(1,2) = K_couple(1,2);
% % % KL(1,3) = K_couple(1,3);
% % % KL(1,4) = K_couple(1,4);
% % % KL(1,5) = K_couple(1,5);
% % % KL(2,1) = K_couple(2,1);
% % % KL(3,1) = K_couple(3,1);
% % % KL(4,1) = K_couple(4,1);
% % % KL(5,1) = K_couple(5,1);



% Analytically calculate coupling terms
dD = 1e-10;

% Change in nodal moments due to change in extension
K21 = sum(k_cord(:,1)*dD*r.*cosd(alpha))/(dD*L);
K31 = -sum(k_cord(:,2)*dD*r.*cosd(alpha))/(dD*L);
K41 = -sum(k_cord(:,1)*dD*r.*sind(alpha))/(dD*L);
K51 = sum(k_cord(:,2)*dD*r.*sind(alpha))/(dD*L);

KL(2,1) = K21;
KL(3,1) = K31;
KL(4,1) = K41;
KL(5,1) = K51;

% Change in extension due to change in nodal rotation
% Ratio of shear and flexural stiffness
phi_y = (12*EI(1)*2)/((GLH*2*pi*r*t + p*pi*r^2)*L^2);
phi_z = (12*EI(2)*2)/((GLH*2*pi*r*t + p*pi*r^2)*L^2);

% Evaluate shape functions at nodes for curvature
x = 0;
Npp_zz_i = [((6*x)/L^2 - (phi_y + 4)/L)/(phi_y + 1)
    ((6*x)/L^2 + (phi_y - 2)/L)/(phi_y + 1)]';
Npp_yy_i = [((6*x)/L^2 - (phi_z + 4)/L)/(phi_z + 1)
    ((6*x)/L^2 + (phi_z - 2)/L)/(phi_z + 1)]';

x = L;
Npp_zz_j = [((6*x)/L^2 - (phi_y + 4)/L)/(phi_y + 1)
    ((6*x)/L^2 + (phi_y - 2)/L)/(phi_y + 1)]';
Npp_yy_j = [((6*x)/L^2 - (phi_z + 4)/L)/(phi_z + 1)
    ((6*x)/L^2 + (phi_z - 2)/L)/(phi_z + 1)]';

% Curvature
% [kappa_zz1 kappa_yy1
% kappa_zz2 kappa_yy2]
kappa_drotz_i = [Npp_zz_i*[dD 0]'
    Npp_zz_j*[dD 0]'];
kappa_drotz_j = [Npp_zz_i*[0 dD]'
    Npp_zz_j*[0 dD]'];
kappa_droty_i = [Npp_yy_i*[dD 0]'
    Npp_yy_j*[dD 0]'];
kappa_droty_j = [Npp_yy_i*[0 dD]'
    Npp_yy_j*[0 dD]'];

% dP/drot_zi
K12i = sum(k_cord(:,1)*kappa_drotz_i(1)*r.*cosd(alpha));
K12j = sum(k_cord(:,2)*kappa_drotz_i(2)*r.*cosd(alpha));
K12 = -(K12i + K12j)/(2*dD);

% dP/drot_zj
K13i = sum(k_cord(:,1)*kappa_drotz_j(1)*r.*cosd(alpha));
K13j = sum(k_cord(:,2)*kappa_drotz_j(2)*r.*cosd(alpha));
K13 = -(K13i + K13j)/(2*dD);

% dP/drot_yi
K14i = sum(k_cord(:,1)*kappa_droty_i(1)*r.*sind(alpha));
K14j = sum(k_cord(:,2)*kappa_droty_i(2)*r.*sind(alpha));
K14 = (K14i + K14j)/(2*dD);

% dP/drot_yj
K15i = sum(k_cord(:,1)*kappa_droty_j(1)*r.*sind(alpha));
K15j = sum(k_cord(:,2)*kappa_droty_j(2)*r.*sind(alpha));
K15 = (K15i + K15j)/(2*dD);

KL(1,2) = K12;
KL(1,3) = K13;
KL(1,4) = K14;
KL(1,5) = K15;


% K_couple
% [0 K12 K13 K14 K15 0
%         K21 0 0 0 0 0
%         K31 0 0 0 0 0
%         K41 0 0 0 0 0
%         K51 0 0 0 0 0
%         0 0 0 0 0 0]
% [K_couple(1,2:5)
%     K12 K13 K14 K15
%     K_couple(2:5,1)'
%     K21 K31 K41 K51]


% For testing
if el == 1
%     P
%     P10
%     KL
end




% % % [       0, - a - b,   c + d, 0, -c, -a,       0,   a + b, - c - d, 0, -d, -b]
% % % [ - e - f,       0,       0, 0,  0,  0,   e + f,       0,       0, 0,  0,  0]
% % % [   g + h,       0,       0, 0,  0,  0, - g - h,       0,       0, 0,  0,  0]
% % % [       0,       0,       0, 0,  0,  0,       0,       0,       0, 0,  0,  0]
% % % [      -g,       0,       0, 0,  0,  0,       g,       0,       0, 0,  0,  0]
% % % [      -e,       0,       0, 0,  0,  0,       e,       0,       0, 0,  0,  0]
% % % [       0,   a + b, - c - d, 0,  c,  a,       0, - a - b,   c + d, 0,  d,  b]
% % % [   e + f,       0,       0, 0,  0,  0, - e - f,       0,       0, 0,  0,  0]
% % % [ - g - h,       0,       0, 0,  0,  0,   g + h,       0,       0, 0,  0,  0]
% % % [       0,       0,       0, 0,  0,  0,       0,       0,       0, 0,  0,  0]
% % % [      -h,       0,       0, 0,  0,  0,       h,       0,       0, 0,  0,  0]
% % % [      -f,       0,       0, 0,  0,  0,       f,       0,       0, 0,  0,  0]
% % % 
% % % 
% % % KL = sym(zeros(6));
% % % syms a b c d e f g h
% % % KL(1,2) = a; % 1;
% % % KL(1,3) = b; % 2;
% % % KL(1,4) = c; % 3;
% % % KL(1,5) = d; % 4;
% % % KL(2,1) = e; % 5;
% % % KL(3,1) = f; % 6;
% % % KL(4,1) = g; % 7;
% % % KL(5,1) = h; % 8;

end







