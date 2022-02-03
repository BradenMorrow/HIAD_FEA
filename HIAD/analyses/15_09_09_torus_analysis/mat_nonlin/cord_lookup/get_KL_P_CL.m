function [KL,P,y_bar,f_cord,EI,eps_cord,f_shell,DEBUG] = get_KL_P_CL(element_in)
% GET_KL_P
%   Obtain the linearized beam element stiffness matrix and internal
%   forces.

% Extract variables
r = element_in.r;
alpha = element_in.alpha;
% axial = element_in.axial;
% axial1 = element_in.axial1;
% axial_0 = element_in.axial_0;
% axial_1 = element_in.axial_1;
cords = element_in.cords;

f_cord_old = element_in.f_cord_old;
eps_cord_old = element_in.eps_cord_old;
f_shell_old = element_in.f_shell_old;

eps0 = element_in.eps0;

propsLH = element_in.propsLH;
y_bar0 = element_in.y_bar0;
EI0 = element_in.EI0;
D = element_in.coro.D;
L = element_in.coro.L;
L0 = element_in.coro.L0;

D0 = element_in.D;
P0 = element_in.P;

% % % %% STRAIN AND CURVATURE
% % % lookup = 2; % 1 - spline; 2 - interp
interp_meth = 'linear'; % 'spline'; % 'pchip'; % 

%%
EL = propsLH(1);
GLH = propsLH(3);
t = propsLH(5)*3;

tol = 1e-6;

% Search for line of zero bending strain
[y_bar,eps_cord,f_cord,k_cord,phi_i,phi_j,~,iter,~,~,f_shell] = ...
    find_NA_CL(D,D0,eps0,eps_cord_old,f_cord_old,f_shell_old,EL,GLH,t,EI0,alpha,r,y_bar0,L,cords,tol,interp_meth,element_in.i);

% Calculate location of NA for tangent stiffness
y_bar2 = [sum(k_cord(:,1)*r.*cosd(phi_i*180/pi + alpha))/(sum(k_cord(:,1)) + EL*2*pi*r*t)
    sum(k_cord(:,2)*r.*cosd(phi_j*180/pi + alpha))/(sum(k_cord(:,2)) + EL*2*pi*r*t)];

d1i_na = r*cosd(phi_i*180/pi + alpha) - y_bar2(1);
d1j_na = r*cosd(phi_j*180/pi + alpha) - y_bar2(2);

% if isnan(y_bar2(1)) || isnan(y_bar2(2))
%     a = 1
% end

% Calculate the element stiffness matrix
if isnan(D(1))
    a = 1;
end

[KL,EI,EA,~,~,Bi,Bj] = ...
    get_KL_CL(k_cord,phi_i,phi_j,alpha,r,EL,t,GLH,d1i_na,d1j_na,y_bar2,L,L0);

%% INTERNAL FORCES
% % % % Calculate internal forces using cord forces
% % % % D = [ul r1z r2z r1y r2y rx]'
% % % % P = [axial M1z M2z M1y M2y Tx]'
% % % P = zeros(6,1);
% % % 
% % % % Axial and shear forces
% % % f_ext = sum(f_cord)' - length(alpha)*Fc;
% % % Pi_cord = f_ext(1) + EL*eps*2*pi*r*t; % sum(f_cord(:,1) - Fc) + EL*eps*2*pi*r*t; %sum(f_cord(:,1) - interp1(axial(:,2),axial(:,1),eps0,interp_meth)) + EL*eps*2*pi*r*t;
% % % Pj_cord = f_ext(2) + EL*eps*2*pi*r*t; % sum(f_cord(:,2) - Fc) + EL*eps*2*pi*r*t; %sum(f_cord(:,2) - interp1(axial(:,2),axial(:,1),eps0,interp_meth)) + EL*eps*2*pi*r*t;
% % % 
% % % % Moments about NA
% % % M11i = sum(f_cord(:,1).*(d1i + y_bar(1))) - kappa2(1)*EL*(pi*r^3*t + 2*pi*r*t*y_bar(1)^2);
% % % M22i = -sum(f_cord(:,1).*(d2i));
% % % 
% % % M11j = -sum(f_cord(:,2).*(d1j + y_bar(2))) + kappa2(2)*EL*(pi*r^3*t + 2*pi*r*t*y_bar(2)^2);
% % % M22j = sum(f_cord(:,2).*(d2j));
% % % 
% % % % Collect element forces
% % % P(1) = (Pi_cord + Pj_cord)/2;
% % % P(2) = M11i*cos(phi_i) - M22i*sin(phi_i);
% % % P(3) = M11j*cos(phi_j) - M22j*sin(phi_j);
% % % P(4) = (M11i*sin(phi_i) + M22i*cos(phi_i));
% % % P(5) = (M11j*sin(phi_j) + M22j*cos(phi_j));
% % % P(6) = GJ*D(6)/L;

% Use stiffness matrix to update internal force
dP = KL*(D - D0);
P = P0 + dP;

%% FOR DEBUGING
DEBUG.iter = iter;
DEBUG.EA = EA;
DEBUG.eps = eps_cord;
DEBUG.P = P;
DEBUG.D = D;
DEBUG.force = f_cord;
DEBUG.phi = [phi_i phi_j]';


% plot_NA
if element_in.i == size(element_in.connect,1) - 1
%     plot_tension(axial,eps_cord)
% %     plot_NA
%     EI
%     disp(y_bar')
%     disp([P1 P])
%     disp([KL(2,2) y_bar(2)])
%     disp([k_cord f_cord])
end

end







