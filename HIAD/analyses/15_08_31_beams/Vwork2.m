
% Elastic properties
EBlad = 54.8; % Bladder
EL_br = EL*.1 - EBlad; % Braid only

% configuration of element
P = p*pi*r^2; % Pressure resultant
% EIt = 281249.553736452;
eps0 = 0.0044127 + D(1)/L; % Initial strain due to inflation and axial deformation
% % % y_bar = 6.88640675464048; % Location of NA for wrinkled section
% % % kappa3 = 0.0041124; % Curvature for wrinkled section

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
kappa3 = [norm(kappa(1,:))
    norm(kappa(2,:))];

% Find location of zero shell strain
y = abs(y_bar) - eps0./kappa3; % Distance from centroid to location of zero strain
theta = real(asin(y/r)); % Angle from horizontal to point of zero strain

% Centroids of braided shell and bladder in tension
y_bar1 = 0; % Centroid of braided shell
if abs(y) < r
    y_bar2 = r*sin(pi/2 - theta)./(pi/2 - theta); % Centroid of bladder in tension
else
    y_bar2 = 0;
end

% Composite centroid of braided shell and bladder in tension
y_bar_shell = (EL_br*2*pi*r*y_bar1 + EBlad*2*(pi/2 - theta)*r.*y_bar2)./...
    (EL_br*2*pi*r + EBlad*2*(pi/2 - theta)*r);



tolerance = 1e-10;

kappa3_plus = [norm(kappa(1,:))
    norm(kappa(2,:))] + tolerance;

% Find location of zero shell strain
y_plus = abs(y_bar) - eps0./kappa3_plus; % Distance from centroid to location of zero strain
theta_plus = real(asin(y_plus/r)); % Angle from horizontal to point of zero strain

% Centroids of braided shell and bladder in tension
y_bar1 = 0; % Centroid of braided shell
if abs(y_plus) < r
    y_bar2_plus = r*sin(pi/2 - theta_plus)./(pi/2 - theta_plus); % Centroid of bladder in tension
else
    y_bar2_plus = 0;
end

% Composite centroid of braided shell and bladder in tension
y_bar_shell_plus = (EL_br*2*pi*r*y_bar1 + EBlad*2*(pi/2 - theta_plus)*r.*y_bar2_plus)./...
    (EL_br*2*pi*r + EBlad*2*(pi/2 - theta_plus)*r);

dy_dk = (y_bar_shell_plus - y_bar_shell)/tolerance;

PV_work = P*dy_dk; % P*[y_bar_shell dy_dk];

% Find the translation of the pressure resultant

if PV_work(1) ~= 0
    a = 1;
end
























% % % ELong = 997.821957804708; % *3*0.0333333333333333;
% % % EHoop = 8300.34166620375; % *3*0.0333333333333333;
% % % nuHL = 2.81709211913857;
% % % nuLH = nuHL/EHoop*ELong;
% % % 
% % % C11 = ELong/(1 - nuLH*nuHL);
% % % C22 = EHoop/(1 - nuLH*nuHL);
% % % C12 = nuHL*ELong/(1 - nuLH*nuHL);
% % % 
% % % C = C11 - C12/C22
