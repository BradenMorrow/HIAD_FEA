function [KL,P,EI,y_bar,f_cord,eps_cord,PV_work] = get_KL_P(el_in0)
%GET_KL_P
%   Obtain the linearized beam element stiffness matrix and internal
%   forces.

% Extract variables
p = el_in0.p;
r = el_in0.r;
alpha = el_in0.alpha;
beta = el_in0.beta;

cords = el_in0.nodes;

f_cord_old = el_in0.f;
Fc = el_in0.Fc;
eps_cord_old = el_in0.eps;

propsLH = el_in0.propsLH;
EL = propsLH(1);
EH = propsLH(2);
GLH = propsLH(3);
nuHL = propsLH(4);
t = propsLH(5)*3;

y_bar0 = el_in0.y_bar;
EI0 = el_in0.EI;
D = el_in0.D;
L = el_in0.L;
L0 = el_in0.L0;

D0 = el_in0.D0;
P0 = el_in0.P0;

el = el_in0.el;

% Search for line of zero bending strain
interp_meth = 'linear'; % 'spline'; % 'pchip'; % 
% [eps_cord,f_cord,k_cord,phi_i,phi_j,kappa2,y_bar,iter,d1i,d1j,PV_work,kappa3] = ...
%     find_NA(D,D0,eps_cord_old,f_cord_old,p,r,alpha,EL,EH,GLH,nuHL,t,EI0,y_bar0,L,cords,interp_meth,el,beta,P0);
[eps_cord,f_cord,k_cord,phi_i,phi_j,kappa2,y_bar,d1i,d1j] = find_NA(D,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,interp_meth,el,beta,EL,eps_cord_old(1));



% Calculate location of NA for tangent stiffness
y_bar2_ = [sum(k_cord(:,1)*r.*cosd(phi_i*180/pi + alpha))/(sum(k_cord(:,1)) + EL*2*pi*r*t)
    sum(k_cord(:,2)*r.*cosd(phi_j*180/pi + alpha))/(sum(k_cord(:,2)) + EL*2*pi*r*t)];

% d1j

d1i_na = r*cosd(phi_i*180/pi + alpha) - y_bar2_(1);
d1j_na = r*cosd(phi_j*180/pi + alpha) - y_bar2_(2);



% [f_cord k_cord]


% Calculate tangent stiffness
% [KL,EI,d2i,d2j,Bi,Bj] = ...
%     get_KL(k_cord,phi_i,phi_j,p,r,alpha,EL,GLH,t,d1i_na,d1j_na,y_bar2,L);
[KL,EI,d2i,d2j,Bi,Bj] = ...
    get_KL(k_cord,phi_i,phi_j,p,r,alpha,EL,GLH,t,d1i,d1j,y_bar,L);


% KL(1,1) = KL(1,1)*.9;

% Element forces
% P1 = mean(sum(f_cord - f_cord_old)) + D(1)/L*EL*2*pi*r*t - mean(2*pi*r*t*EL*y_bar.*kappa2);

P10 = sum(f_cord)' + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*D(1)/L - p*pi*r^2;
P1 = P10(1);



P6 = GLH*2*pi*r^3*t/L*D(6);

P2 = sum(f_cord(:,1)*r.*cosd(alpha)) - EL*pi*r^3*t*kappa2(1)*cos(phi_i);
P3 = -sum(f_cord(:,2)*r.*cosd(alpha)) + EL*pi*r^3*t*kappa2(2)*cos(phi_j);

P4 = -sum(f_cord(:,1)*r.*sind(alpha)) - EL*pi*r^3*t*kappa2(1)*sin(phi_i);
P5 = sum(f_cord(:,2)*r.*sind(alpha)) + EL*pi*r^3*t*kappa2(2)*sin(phi_j);

P = [P1 P2 P3 P4 P5 P6]';


% % % % Use stiffness matrix to update internal force
% % % dP = KL*(D - D0);
% % % P = P0 + dP;

PV_work = 1;

% f_cord

























Ktest = zeros(6);
D2 = D;
D2(1) = D2(1) + 1e-10;
[eps_cord2,f_cord2,k_cord2,phi_i2,phi_j2,kappa22,y_bar2,d1i2,d1j2] = find_NA(D2,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,interp_meth,el,beta,EL,eps_cord_old(1));
[KL2,EI2,d2i2,d2j2,Bi2,Bj2] = ...
    get_KL(k_cord2,phi_i2,phi_j2,p,r,alpha,EL,GLH,t,d1i2,d1j2,y_bar2,L);

P102 = sum(f_cord2)' + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*D2(1)/L - p*pi*r^2;
P12 = P102(1);
P62 = GLH*2*pi*r^3*t/L*D2(6);

P22 = sum(f_cord2(:,1)*r.*cosd(alpha)) - EL*pi*r^3*t*kappa22(1)*cos(phi_i2);
P32 = -sum(f_cord2(:,2)*r.*cosd(alpha)) + EL*pi*r^3*t*kappa22(2)*cos(phi_j2);

P42 = -sum(f_cord2(:,1)*r.*sind(alpha)) - EL*pi*r^3*t*kappa22(1)*sin(phi_i2);
P52 = sum(f_cord2(:,2)*r.*sind(alpha)) + EL*pi*r^3*t*kappa22(2)*sin(phi_j2);

P2 = [P12 P22 P32 P42 P52 P62]';

dP = P2 - P;
Ktest(:,1) = dP/1e-10;



D2 = D;
D2(2) = D2(2) + 1e-10;
[eps_cord2,f_cord2,k_cord2,phi_i2,phi_j2,kappa22,y_bar2,d1i2,d1j2] = find_NA(D2,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,interp_meth,el,beta,EL,eps_cord_old(1));
[KL2,EI2,d2i2,d2j2,Bi2,Bj2] = ...
    get_KL(k_cord2,phi_i2,phi_j2,p,r,alpha,EL,GLH,t,d1i2,d1j2,y_bar2,L);

P102 = sum(f_cord2)' + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*D2(1)/L - p*pi*r^2;
P12 = P102(1);
P62 = GLH*2*pi*r^3*t/L*D2(6);

P22 = sum(f_cord2(:,1)*r.*cosd(alpha)) - EL*pi*r^3*t*kappa22(1)*cos(phi_i2);
P32 = -sum(f_cord2(:,2)*r.*cosd(alpha)) + EL*pi*r^3*t*kappa22(2)*cos(phi_j2);

P42 = -sum(f_cord2(:,1)*r.*sind(alpha)) - EL*pi*r^3*t*kappa22(1)*sin(phi_i2);
P52 = sum(f_cord2(:,2)*r.*sind(alpha)) + EL*pi*r^3*t*kappa22(2)*sin(phi_j2);

P2 = [P12 P22 P32 P42 P52 P62]';

dP = P2 - P;
Ktest(:,2) = dP/1e-10;


D2 = D;
D2(3) = D2(3) + 1e-10;
[eps_cord2,f_cord2,k_cord2,phi_i2,phi_j2,kappa22,y_bar2,d1i2,d1j2] = find_NA(D2,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,interp_meth,el,beta,EL,eps_cord_old(1));
[KL2,EI2,d2i2,d2j2,Bi2,Bj2] = ...
    get_KL(k_cord2,phi_i2,phi_j2,p,r,alpha,EL,GLH,t,d1i2,d1j2,y_bar2,L);

P102 = sum(f_cord2)' + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*D2(1)/L - p*pi*r^2;
P12 = P102(1);
P62 = GLH*2*pi*r^3*t/L*D2(6);

P22 = sum(f_cord2(:,1)*r.*cosd(alpha)) - EL*pi*r^3*t*kappa22(1)*cos(phi_i2);
P32 = -sum(f_cord2(:,2)*r.*cosd(alpha)) + EL*pi*r^3*t*kappa22(2)*cos(phi_j2);

P42 = -sum(f_cord2(:,1)*r.*sind(alpha)) - EL*pi*r^3*t*kappa22(1)*sin(phi_i2);
P52 = sum(f_cord2(:,2)*r.*sind(alpha)) + EL*pi*r^3*t*kappa22(2)*sin(phi_j2);

P2 = [P12 P22 P32 P42 P52 P62]';

dP = P2 - P;
Ktest(:,3) = dP/1e-10;





D2 = D;
D2(4) = D2(4) + 1e-10;
[eps_cord2,f_cord2,k_cord2,phi_i2,phi_j2,kappa22,y_bar2,d1i2,d1j2] = find_NA(D2,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,interp_meth,el,beta,EL,eps_cord_old(1));
[KL2,EI2,d2i2,d2j2,Bi2,Bj2] = ...
    get_KL(k_cord2,phi_i2,phi_j2,p,r,alpha,EL,GLH,t,d1i2,d1j2,y_bar2,L);

P102 = sum(f_cord2)' + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*D2(1)/L - p*pi*r^2;
P12 = P102(1);
P62 = GLH*2*pi*r^3*t/L*D2(6);

P22 = sum(f_cord2(:,1)*r.*cosd(alpha)) - EL*pi*r^3*t*kappa22(1)*cos(phi_i2);
P32 = -sum(f_cord2(:,2)*r.*cosd(alpha)) + EL*pi*r^3*t*kappa22(2)*cos(phi_j2);

P42 = -sum(f_cord2(:,1)*r.*sind(alpha)) - EL*pi*r^3*t*kappa22(1)*sin(phi_i2);
P52 = sum(f_cord2(:,2)*r.*sind(alpha)) + EL*pi*r^3*t*kappa22(2)*sin(phi_j2);

P2 = [P12 P22 P32 P42 P52 P62]';

dP = P2 - P;
Ktest(:,4) = dP/1e-10;







D2 = D;
D2(5) = D2(5) + 1e-10;
[eps_cord2,f_cord2,k_cord2,phi_i2,phi_j2,kappa22,y_bar2,d1i2,d1j2] = find_NA(D2,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,interp_meth,el,beta,EL,eps_cord_old(1));
[KL2,EI2,d2i2,d2j2,Bi2,Bj2] = ...
    get_KL(k_cord2,phi_i2,phi_j2,p,r,alpha,EL,GLH,t,d1i2,d1j2,y_bar2,L);

P102 = sum(f_cord2)' + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*D2(1)/L - p*pi*r^2;
P12 = P102(1);
P62 = GLH*2*pi*r^3*t/L*D2(6);

P22 = sum(f_cord2(:,1)*r.*cosd(alpha)) - EL*pi*r^3*t*kappa22(1)*cos(phi_i2);
P32 = -sum(f_cord2(:,2)*r.*cosd(alpha)) + EL*pi*r^3*t*kappa22(2)*cos(phi_j2);

P42 = -sum(f_cord2(:,1)*r.*sind(alpha)) - EL*pi*r^3*t*kappa22(1)*sin(phi_i2);
P52 = sum(f_cord2(:,2)*r.*sind(alpha)) + EL*pi*r^3*t*kappa22(2)*sin(phi_j2);

P2 = [P12 P22 P32 P42 P52 P62]';

dP = P2 - P;
Ktest(:,5) = dP/1e-10;










D2 = D;
D2(6) = D2(6) + 1e-10;
[eps_cord2,f_cord2,k_cord2,phi_i2,phi_j2,kappa22,y_bar2,d1i2,d1j2] = find_NA(D2,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,interp_meth,el,beta,EL,eps_cord_old(1));
[KL2,EI2,d2i2,d2j2,Bi2,Bj2] = ...
    get_KL(k_cord2,phi_i2,phi_j2,p,r,alpha,EL,GLH,t,d1i2,d1j2,y_bar2,L);

P102 = sum(f_cord2)' + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*D2(1)/L - p*pi*r^2;
P12 = P102(1);
P62 = GLH*2*pi*r^3*t/L*D2(6);

P22 = sum(f_cord2(:,1)*r.*cosd(alpha)) - EL*pi*r^3*t*kappa22(1)*cos(phi_i2);
P32 = -sum(f_cord2(:,2)*r.*cosd(alpha)) + EL*pi*r^3*t*kappa22(2)*cos(phi_j2);

P42 = -sum(f_cord2(:,1)*r.*sind(alpha)) - EL*pi*r^3*t*kappa22(1)*sin(phi_i2);
P52 = sum(f_cord2(:,2)*r.*sind(alpha)) + EL*pi*r^3*t*kappa22(2)*sin(phi_j2);

P2 = [P12 P22 P32 P42 P52 P62]';

dP = P2 - P;
Ktest(:,6) = dP/1e-10;

KL(1,2) = Ktest(1,2);
KL(1,3) = Ktest(1,3);
KL(1,4) = Ktest(1,4);
KL(1,5) = Ktest(1,5);
KL(2,1) = Ktest(2,1);
KL(3,1) = Ktest(3,1);
KL(4,1) = Ktest(4,1);
KL(5,1) = Ktest(5,1);


% KL = Ktest;





% % % dD = 1e-10;
% % % K21 = sum(k_cord(:,1)*dD*r.*cosd(alpha))/dD;
% % % K31 = -sum(k_cord(:,2)*dD*r.*cosd(alpha))/dD;
% % % K41 = sum(k_cord(:,1)*dD*r.*sind(alpha))/dD;
% % % K51 = -sum(k_cord(:,2)*dD*r.*sind(alpha))/dD;
% % % 
% % % % KL(2,1) = K21;
% % % % KL(3,1) = K31;
% % % % KL(4,1) = K41;
% % % % KL(5,1) = K51;
% % % 
% % % 
% % % % Ratio of shear and flexural stiffness
% % % phi_y = (12*EI(1)*2)/((GLH*2*pi*r*t + p*pi*r^2)*L^2);
% % % phi_z = (12*EI(2)*2)/((GLH*2*pi*r*t + p*pi*r^2)*L^2);
% % % 
% % % % Evaluate shape functions at nodes
% % % x = 0;
% % % Npp_zz_i = [((6*x)/L^2 - (phi_y + 4)/L)/(phi_y + 1)
% % %     ((6*x)/L^2 + (phi_y - 2)/L)/(phi_y + 1)]';
% % % Npp_yy_i = [((6*x)/L^2 - (phi_z + 4)/L)/(phi_z + 1)
% % %     ((6*x)/L^2 + (phi_z - 2)/L)/(phi_z + 1)]';
% % % 
% % % x = L;
% % % Npp_zz_j = [((6*x)/L^2 - (phi_y + 4)/L)/(phi_y + 1)
% % %     ((6*x)/L^2 + (phi_y - 2)/L)/(phi_y + 1)]';
% % % Npp_yy_j = [((6*x)/L^2 - (phi_z + 4)/L)/(phi_z + 1)
% % %     ((6*x)/L^2 + (phi_z - 2)/L)/(phi_z + 1)]';
% % % 
% % % % Curvature
% % % % [kappa_zz1 kappa_yy1
% % % % kappa_zz2 kappa_yy2]
% % % kappa_drotz_i = [Npp_zz_i*[dD 0]'
% % %     Npp_zz_j*[dD 0]'];
% % % kappa_drotz_j = [Npp_zz_i*[0 dD]'
% % %     Npp_zz_j*[0 dD]'];
% % % kappa_droty_i = [Npp_yy_i*[dD 0]'
% % %     Npp_yy_j*[dD 0]'];
% % % kappa_droty_j = [Npp_yy_i*[0 dD]'
% % %     Npp_yy_j*[0 dD]'];
% % % 
% % % K12i = sum(k_cord(:,1)*kappa_drotz_i(1)*r.*cosd(alpha));
% % % K12j = sum(k_cord(:,2)*kappa_drotz_i(2)*r.*cosd(alpha));
% % % K12 = -(K12i + K12j)/(2*dD);
% % % 
% % % K13i = sum(k_cord(:,1)*kappa_drotz_j(1)*r.*cosd(alpha));
% % % K13j = sum(k_cord(:,2)*kappa_drotz_j(2)*r.*cosd(alpha));
% % % K13 = -(K13i + K13j)/(2*dD);
% % % 
% % % K14i = sum(k_cord(:,1)*kappa_droty_i(1)*r.*sind(alpha));
% % % K14j = sum(k_cord(:,2)*kappa_droty_i(2)*r.*sind(alpha));
% % % K14 = (K14i + K14j)/(2*dD);
% % % 
% % % K15i = sum(k_cord(:,1)*kappa_droty_j(1)*r.*sind(alpha));
% % % K15j = sum(k_cord(:,2)*kappa_droty_j(2)*r.*sind(alpha));
% % % K15 = (K15i + K15j)/(2*dD);
% % % 
% % % % KL(1,2) = K12;
% % % % KL(1,3) = K13;
% % % % KL(1,4) = K14;
% % % % KL(1,5) = K15;












% KL(2,1) = Ktest(1,2);
% KL(3,1) = Ktest(1,3);
% KL(1,2) = Ktest(2,1);
% KL(1,3) = Ktest(3,1);

% [Ktest(1,2) Ktest(1,3); Ktest(2,1) Ktest(3,1)]


% KL
% EA = EI(1);


% KL(1,2) = EA*y_bar2_(1);
% KL(1,3) = -EA*y_bar2_(2);
% KL(2,1) = EA*y_bar2_(1);
% KL(3,1) = -EA*y_bar2_(2);
% KL = Ktest;
if el == 1
%     P
    KL
%     [0 K12 K13 K14 K15 0
%         K21 0 0 0 0 0
%         K31 0 0 0 0 0
%         K41 0 0 0 0 0
%         K51 0 0 0 0 0
%         0 0 0 0 0 0]

%     P1
%     fprintf('Pax = %g\n\n',D(1))
%     disp([D P])
%     disp(P(1))
%     plot_NA
end
% % % % plot_NA
% % % if el_in0.i == size(el_in0.connect,1) - 1
% % % %     plot_tension(axial,eps_cord)
% % % %     plot_NA
% % % %     EI
% % % %     disp(y_bar')
% % % %     disp([P1 P])
% % % %     disp([KL(2,2) y_bar(2)])
% % % %     disp([k_cord f_cord])
% % % end

end







