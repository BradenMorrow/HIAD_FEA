% Symbolic calculation of element length
% October 06, 2015
% Andy Young

% % % % % % clear
% % % % % % syms phi_y phi_z x L theta_zi theta_zj theta_yi theta_yj a b A
% % % % % % 
% % % % % % Nz = transpose([1/(1 + phi_y)*(3*(x/L)^2 - (4 + phi_y)*(x/L) + (1 + phi_y))
% % % % % %     1/(1 + phi_y)*(3*(x/L)^2 - (2 - phi_y)*(x/L))]);
% % % % % % Ny = transpose([1/(1 + phi_z)*(3*(x/L)^2 - (4 + phi_z)*(x/L) + (1 + phi_z))
% % % % % %     1/(1 + phi_z)*(3*(x/L)^2 - (2 - phi_z)*(x/L))]);
% % % % % % 
% % % % % % theta_zij = [theta_zi
% % % % % %     theta_zj];
% % % % % % theta_yij = [theta_yi
% % % % % %     theta_yj];
% % % % % % 
% % % % % % theta_z = Nz*theta_zij;
% % % % % % theta_y = Ny*theta_yij;
% % % % % % 
% % % % % % f = simple((theta_z^2 + theta_y^2)^A);
% % % % % % 
% % % % % % dS = int(f,x,0,L);



% % % clear
% % % syms phi_y phi_z x L theta_zi theta_zj theta_yi theta_yj y_bar
% % % 
% % % Nz = transpose([1/(1 + phi_y)*(3*(x/L)^2 - (4 + phi_y)*(x/L) + (1 + phi_y))
% % %     1/(1 + phi_y)*(3*(x/L)^2 - (2 - phi_y)*(x/L))]);
% % % Ny = transpose([1/(1 + phi_z)*(3*(x/L)^2 - (4 + phi_z)*(x/L) + (1 + phi_z))
% % %     1/(1 + phi_z)*(3*(x/L)^2 - (2 - phi_z)*(x/L))]);
% % % 
% % % Nzp = diff(Nz,x);
% % % Nyp = diff(Ny,x);
% % % 
% % % theta_zij = [theta_zi
% % %     theta_zj];
% % % theta_yij = [theta_yi
% % %     theta_yj];
% % % 
% % % kappa_z = Nzp*theta_zij;
% % % kappa_y = Nyp*theta_yij;
% % % 
% % % f = kappa_z*y_bar;
% % % 
% % % dS = int(f,x,0,L);





%%
clear
syms r y y_bar K L a b

f = (2*r^2 - 2*y^2)^(1/2)*K*L*(y + y_bar);
delta_V = int(f,y);

delta_V = delta_V;


y = -r;
A = eval(delta_V);

y = r;
B = eval(delta_V);

DV1 = B - A;



%%
% % % r = 1;
% % % y_bar = 1;
% % % K = 1;
% % % L = 1;
% % % 
% % % y = y_bar - r;
% % % A = eval(delta_V);
% % % 
% % % y = y_bar + r;
% % % B = eval(delta_V);
% % % 
% % % DV2 = B - A;














%%
clear
syms r y y_bar K L a b

delta_V = 1/3*K*L*(sqrt(r^2 - y^2)*(y*(3*y_bar + 2*y) - 2*r^2) + 3*r^2*y_bar*atan(y/sqrt(r^2 - y^2)));

y = -r;
A = eval(delta_V);

y = r;
B = eval(delta_V);

DV2 = B - A;



















