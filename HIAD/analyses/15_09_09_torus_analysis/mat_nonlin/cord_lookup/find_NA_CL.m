function [y_bar,eps_cord,f_cord,k_cord,phi_i,phi_j,kappa2,iter,d1i,d1j,f_shell] = find_NA_CL(D,D0,eps0,eps_cord_old,f_cord_old,f_shell_old,EL,GLH,t,EI0,alpha,r,y_bar0,L,cords,tol,interp_meth,inc)
% Find the location of zero bending strain

% Axial strain
% eps = D(1)/L;
% eps_old = D0(1)/L;
% delta_eps = eps - eps_old;

dD = D - D0;
delta_eps = dD(1)/L;

% % % % Axial strain and force from loading
% % % delta_f = [0 0]'; % [1 1]'*EL*A*delta_eps;
% % % for i = 1:2 % Nodes
% % %     for j = 1:length(alpha) % Cords
% % % %         cord_in = cords(i).cords(j);
% % % %         f0i = cord_model_13MAY15(eps0 + eps,cord_in.eps_rate,cord_in.load_point,cord_in.unload_point,tol);
% % %         axial = cords(i).cords(j).axial;
% % % %         k = (axial(2,1) - axial(1,1))/(axial(2,2) - axial(1,2));
% % %         f1 = interp1(axial(:,2),axial(:,1),eps + eps0,interp_meth);
% % %         f2 = interp1(axial(:,2),axial(:,1),eps + eps0 + tol,interp_meth);
% % %         k = (f2 - f1)/tol;
% % %         delta_fi = k*delta_eps; % interp1(axial(:,2),axial(:,1),eps0 + eps,interp_meth) - interp1(axial(:,2),axial(:,1),eps0,interp_meth);
% % %         delta_f(i) = delta_f(i) + delta_fi;
% % %     end
% % % end
% % % % delta_f = delta_f + EL*A*delta_eps;
% % % f0 = f_old + delta_f;

% Extract curvature
EIzz1 = EI0(1);
EIzz2 = EI0(1);
EIyy1 = EI0(2);
EIyy2 = EI0(2);
G = GLH;
k = 2.0;
A = 2*pi*r*t;

% Shape functions
% D = [ul r1z r2z r1y r2y rx]
% Constant EI
EIzz = (EIzz1 + EIzz2)/2;
EIyy = (EIyy1 + EIyy2)/2;

% Ratio of shear and flexural stiffness
phi_y = (12*EIzz*k)/(G*A*L^2);
phi_z = (12*EIyy*k)/(G*A*L^2);

% Evaluate shape functions at nodes
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
kappa = [Npp_zz_i*dD(2:3) Npp_yy_i*dD(4:5)
    Npp_zz_j*dD(2:3) Npp_yy_j*dD(4:5)];

% Curvature parallel and perpendicular to the NA
% [kappa_i kappa_j]'
kappa2 = [norm(kappa(1,:))
    norm(kappa(2,:))];

% Angle of NA
phi_i = atan2(kappa(1,2),kappa(1,1));
phi_j = atan2(kappa(2,2),kappa(2,1));


% % % % Extract cord stiffness
% % % k_cord = zeros(size(alpha,1),2);
% % % for i = 1:2
% % %     for j = 1:length(alpha)
% % %         axial = cords(i).cords(j).axial;
% % % %         force = interp1(axial(:,2),axial(:,1),eps_cord(j,i),interp_meth);
% % % %         force_up = interp1(axial(:,2),axial(:,1),eps_cord(j,i) + tol,interp_meth);
% % %         force = interp1(axial(:,2),axial(:,1),0,interp_meth);
% % %         force_up = interp1(axial(:,2),axial(:,1),tol,interp_meth);
% % %         k = (force_up - force)/tol;
% % %         k_cord(j,i) = k;
% % %      end
% % % end



%% NA SEARCH
% Initialize
y_bar = [0 0]'; % y_bar0; % 

% Set initial tracking values
iter = 1;
max_iter = 10;

f = 1;

% Find location of NA
while norm(f) > 1e-4 && iter <= max_iter
    % ----------
    % Strain in cords, inflation, axial and bending
%     [~,d1i,d1j] = get_eps(eps0 + eps,y_bar,r,phi_i,phi_j,alpha,kappa2);
    [delta_eps_cord,d1i,d1j] = get_eps(ones(size(eps_cord_old))*delta_eps,y_bar,r,phi_i,phi_j,alpha,kappa2);
%     eps_cord = eps_cord_old + delta_eps;
%     delta_eps_cord = eps_cord - eps_cord_old;
    eps_cord = delta_eps_cord + eps_cord_old;
    
    % Extract cord stiffness
    k_cord = zeros(size(alpha,1),2);
    for i = 1:2
        for j = 1:length(alpha)
            axial = cords(i).cords(j).axial;
    %         force = interp1(axial(:,2),axial(:,1),eps_cord(j,i),interp_meth);
    %         force_up = interp1(axial(:,2),axial(:,1),eps_cord(j,i) + tol,interp_meth);
            force = interp1(axial(:,2),axial(:,1),eps_cord(j,i),interp_meth);
            force_up = interp1(axial(:,2),axial(:,1),eps_cord(j,i) + tol,interp_meth);
            k = (force_up - force)/tol;
            k_cord(j,i) = k;
         end
    end

    
    
    delta_f_cord = k_cord.*delta_eps_cord;
    f_cord = f_cord_old + delta_f_cord;
    
%     f = sum(f_cord)' - f0 + 2*pi*r*t*EL*y_bar.*kappa2; % (eps*[1 1]' - y_bar.*kappa2);
%     f = sum(f_cord)' + 2*pi*r*t*EL*y_bar.*kappa2 + EL*A*eps;
    f = sum(delta_f_cord)' - sum(k_cord*delta_eps)' + 2*pi*r*t*EL*y_bar.*kappa2; % - f_shell_old;

    
    % ----------
    % Perturb NA
    % Forward step
    y_bar_plus = y_bar + tol;

    % Strain in cords, inflation, axial and bending with perturbed NA
    [delta_eps_cord_plus] = get_eps(ones(size(eps_cord_old))*delta_eps,y_bar_plus,r,phi_i,phi_j,alpha,kappa2);
    eps_cord_plus = eps_cord_old + delta_eps_cord_plus;
%     delta_eps_cord_plus = eps_cord_plus - eps_cord_old;
%     eps_cord_plus = delta_eps_cord_plus + eps_cord_old;
    
    % Extract cord stiffness
    k_cord_plus = zeros(size(alpha,1),2);
    for i = 1:2
        for j = 1:length(alpha)
            axial = cords(i).cords(j).axial;
    %         force = interp1(axial(:,2),axial(:,1),eps_cord(j,i),interp_meth);
    %         force_up = interp1(axial(:,2),axial(:,1),eps_cord(j,i) + tol,interp_meth);
            force = interp1(axial(:,2),axial(:,1),eps_cord_plus(j,i),interp_meth);
            force_up = interp1(axial(:,2),axial(:,1),eps_cord_plus(j,i) + tol,interp_meth);
            k = (force_up - force)/tol;
            k_cord_plus(j,i) = k;
         end
    end




    delta_f_cord_plus = k_cord_plus.*delta_eps_cord_plus;
%     f_cord_plus = delta_f_cord_plus + f_cord_old;
    
% % %     for i = 1:2
% % %         for j = 1:length(alpha)
% % % % % %             cord_in = cords(i).cords(j);
% % % % % %             f_cord_plus(j,i) = ...
% % % % % %                 cord_model_13MAY15(eps_cord_plus(j,i),cord_in.eps_rate,cord_in.load_point,cord_in.unload_point,tol);
% % %             axial = cords(i).cords(j).axial;
% % %             delta_f_cord_plus(j,i) = interp1(axial(:,2),axial(:,1),eps_cord_plus(j,i),interp_meth);
% % %         end
% % %     end
    
%     f_plus = sum(f_cord_plus)' - f0 + 2*pi*r*t*EL*y_bar_plus.*kappa2; % (eps*[1 1]' - y_bar_plus.*kappa2);
%     f_plus = sum(f_cord_plus)' + 2*pi*r*t*EL*y_bar_plus.*kappa2 + EL*A*eps;
    f_plus = sum(delta_f_cord_plus)' - sum(k_cord_plus*delta_eps)' + 2*pi*r*t*EL*y_bar_plus.*kappa2; % - f_shell_old;

    
    % ----------
    % Move towards better NA solution
    % Derivative
    f_prime = (f_plus - f)/tol;

    % Update location of NA
    y_bar_old = y_bar;

    y_bar = y_bar_old - f./f_prime;

    y_bar(isinf(y_bar)) = 0;
    y_bar(isnan(y_bar)) = 0;

    % Update tracking variables
    iter = iter + 1;

    if iter == max_iter + 1
        warning('MAX_ITER has been reached - find NA')
    end
end

f_shell = 2*pi*r*t*EL*y_bar.*kappa2;




% figure(10)
% hold on
% plot(eps_cord(:),f_cord(:),'bx')

end

