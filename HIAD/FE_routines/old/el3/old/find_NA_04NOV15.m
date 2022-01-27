function [eps_cord,f_cord,k_cord,phi_i,phi_j,kappa2,y_bar,d1i,d1j] = find_NA(D,eps_cord_old,p,r,alpha,GLH,t,EI0,L,cords,interp_meth,el,beta,EL,eps0)
% Find the location of zero bending strain

% Change in displacement and change in strain
eps_ax = D(1)/L; % 0; % 

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
kappa = [Npp_zz_i*D(2:3) Npp_yy_i*D(4:5)
    Npp_zz_j*D(2:3) Npp_yy_j*D(4:5)];

% Curvature parallel and perpendicular to the NA
% [kappa_i kappa_j]'
kappa2 = [norm(kappa(1,:))
    norm(kappa(2,:))];

% Angle of NA
phi_i = atan2(kappa(1,2),kappa(1,1));
phi_j = atan2(kappa(2,2),kappa(2,1));

%% NA SEARCH
% Initialize
y_bar = [0 0]'; % y_bar0; % 

% Set initial tracking values
tol = 1e-4;

% Strain in cords, inflation, axial and bending
[eps_cord,d1i,d1j] = get_eps(eps_cord_old + eps_ax,y_bar,r,phi_i,phi_j,alpha,kappa2);

k_cord = zeros(size(alpha,1),2);
f_cord = zeros(size(alpha,1),2);
% Loop through cords on nodes to obtain stiffness
% Can this be done in one line with interp1?
for i = 1:2 % Nodes
    for j = 1:length(alpha) % Cords
        % Extract cord force - strain relationship
        axial = cords(i).cords(j).axial;

        % Calculate cord stiffness
        force = interp1(axial(:,2),axial(:,1),eps_cord(j,i),interp_meth);
        f_cord(j,i) = force;
        
        
        force_up = interp1(axial(:,2),axial(:,1),eps_cord(j,i) + tol,interp_meth);
        k = (force_up - force)/tol;
        k_cord(j,i) = k;
    end
end

% Total force in cords
% f_cord = interp1(axial(:,2),axial(:,1),eps_cord); % Interpolate for total cord force

% phi_i = 0;
% phi_j = 0;

if el == 32
%     plot_NA
    plot_strain
%     kappa2
end
end

