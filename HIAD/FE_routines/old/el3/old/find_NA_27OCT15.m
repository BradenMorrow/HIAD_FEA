function [eps_cord,f_cord,k_cord,phi_i,phi_j,kappa2,y_bar,iter,d1i,d1j,PV_work,kappa3] = find_NA(D,D0,eps_cord_old,f_cord_old,p,r,alpha,EL,EH,GLH,nuHL,t,EI0,y_bar0,L,cords,interp_meth,el,beta)
% Find the location of zero bending strain

nuLH = nuHL/EH*EL;
C11 = EL/(1 - nuLH*nuHL);
C22 = EH/(1 - nuLH*nuHL);
C12 = nuHL*EL/(1 - nuLH*nuHL);

% C11 - C12^2/C22

% Change in displacement and change in strain
dD = D - D0;
delta_eps = dD(1)/L; % 0; % 

% Extract curvature
EIzz1 = EI0(1);
EIzz2 = EI0(1);
EIyy1 = EI0(2);
EIyy2 = EI0(2);
k = 2.0; % Shear factor for thin walled tube
A = 2*pi*r*t;

% Shape functions
% D = [ul r1z r2z r1y r2y rx]
% Constant EI
EIzz = (EIzz1 + EIzz2)/2;
EIyy = (EIyy1 + EIyy2)/2;

% Ratio of shear and flexural stiffness
phi_y = (12*EIzz*k)/((GLH*A + p*pi*r^2)*L^2);
phi_z = (12*EIyy*k)/((GLH*A + p*pi*r^2)*L^2);

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
% % % kappa = [Npp_zz_i*D(2:3) Npp_yy_i*D(4:5)
% % %     Npp_zz_j*D(2:3) Npp_yy_j*D(4:5)];
% % % 
% % % % Curvature parallel and perpendicular to the NA
% % % % [kappa_i kappa_j]'
% % % kappa3 = [norm(kappa(1,:))
% % %     norm(kappa(2,:))];







%% NA SEARCH
% Initialize
y_bar = [0 0]'; % y_bar0; % 

% Set initial tracking values
iter = 1;
max_iter = 10;
tol0 = 1e-3;
tol1 = 1e-8;
tol2 = 1e-10;

% Initialize axial force on cross section
f = 1;

% Find location of NA
while norm(f) > tol0 && iter <= max_iter
    % ----------
    % Strain in cords, inflation, axial and bending
    [delta_eps_cord,d1i,d1j] = get_eps(ones(size(eps_cord_old))*delta_eps,y_bar,r,phi_i,phi_j,alpha,kappa2);
    eps_cord = delta_eps_cord + eps_cord_old;

    % Extract cord stiffness
    if iter == 1
        k_cord = zeros(size(alpha,1),2);
    end

    % Loop through cords on nodes to obtain stiffness
    % Can this be done in one line with interp1?
    for i = 1:2 % Nodes
        for j = 1:length(alpha) % Cords
            % Extract cord force - strain relationship
            axial = cords(i).cords(j).axial;

            % Calculate cord stiffness
            force = interp1(axial(:,2),axial(:,1),eps_cord(j,i),interp_meth);
            force_up = interp1(axial(:,2),axial(:,1),eps_cord(j,i) + tol2,interp_meth);
            k = (force_up - force)/tol2;
            k_cord(j,i) = k;
         end
    end

    % Change in cord force
    delta_f_cord = k_cord.*delta_eps_cord;

    % Total force in cords
    % f_cord = f_cord_old + delta_f_cord; % Step for total cord force
    f_cord = interp1(axial(:,2),axial(:,1),eps_cord); % Interpolate for total cord force

    % Change in axial force on element cross section must sum to zero
% % %     f = sum(delta_f_cord)' - sum(k_cord*delta_eps)' - 2*pi*r*t*EL*y_bar.*kappa2;
    f = sum(f_cord)' + p*pi*r^2*2*cotd(beta)^2 - 2*pi*r*t*EL*y_bar.*kappa2 - p*pi*r^2;
    % 2*pi*r*t*(p*r/(2*t) - p*pi*r^2*(1 - 2*cot(beta*pi/180)^2) - EL*kappa*y_bar)
    
    % ----------
    % Perturb NA
    % Forward step
    y_bar_plus = y_bar + tol1;

    % Strain in cords, inflation, axial and bending with perturbed NA
    [delta_eps_cord_plus] = get_eps(ones(size(eps_cord_old))*delta_eps,y_bar_plus,r,phi_i,phi_j,alpha,kappa2);
    eps_cord_plus = eps_cord_old + delta_eps_cord_plus;

    % Extract cord stiffness
    if iter == 1
        k_cord_plus = zeros(size(alpha,1),2);
    end

    % Loop through cords on nodes to obtain stiffness
    % Can this be done in one line with interp1?
    for i = 1:2
        for j = 1:length(alpha)
            % Extract cord force - strain relationship
            axial = cords(i).cords(j).axial;

            % Calculate cord stiffness
            force = interp1(axial(:,2),axial(:,1),eps_cord_plus(j,i),interp_meth);
            force_up = interp1(axial(:,2),axial(:,1),eps_cord_plus(j,i) + tol2,interp_meth);
            k = (force_up - force)/tol2;
            k_cord_plus(j,i) = k;
         end
    end

    % Change in cord force with perturbed NA
    delta_f_cord_plus = k_cord_plus.*delta_eps_cord_plus;
    f_cord_plus = interp1(axial(:,2),axial(:,1),eps_cord_plus); % Interpolate for total cord force

    % Total axial force on element cross section with perturbed NA
% % %     f_plus = sum(delta_f_cord_plus)' - sum(k_cord_plus*delta_eps)' - 2*pi*r*t*EL*y_bar_plus.*kappa2;
    f_plus = sum(f_cord_plus)' + p*pi*r^2*2*cotd(beta)^2 - 2*pi*r*t*EL*y_bar_plus.*kappa2 - p*pi*r^2;


    % ----------
    % Move towards better NA solution
    % Derivative
    f_prime = (f_plus - f)/tol1;

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


% -nuHL/EH*2*pi*r*kappa2.*y_bar
% iter
Vwork2

dV1 = -pi*r^2*mean(y_bar)*(D(2) - D(3));
dV2 = pi*r^2*mean(kappa3)*L*mean(y_bar);
dS = 2*pi*r*mean(kappa3)*L*mean(y_bar);

M = p*pi*r^2*mean(abs(kappa3))*L*mean(abs(y_bar));
PV_work = abs(M);

% PV_work = p*pi*r^2*abs(y_bar);

if el == 32
%     disp([dV1 dV2 dS M])
end


% delta_V = p*pi*r^2*mean(y_bar)*(dD(2) - dD(3));
end

