%%
% Elastic properties
ELong = 99.782; % Composite
EBlad = 54.8; % Bladder
ELong_br = ELong - EBlad; % Braid only

% configuration of element
r = 6.7225; % Radius
p = 20; % Pressure
P = p*pi*r^2; % Pressure resultant
EIt = 281249.553736452;

eps0 = 0.0044127; % Initial strain due to inflation
y_bar = 6.88640675464048; % Location of NA for wrinkled section
kappa = 0.0041124; % Curvature for wrinkled section


% Find location of zero shell strain
y = y_bar - eps0/kappa; % Distance from centroid to location of zero strain
theta = asin(y/r); % Angle from horizontal to point of zero strain

% Centroids of braided shell and bladder in tension
y_bar1 = 0; % Centroid of braided shell
y_bar2 = r*sin(pi/2 - theta)/(pi/2 - theta); % Centroid of bladder in tension

% Composite centroid of braided shell and bladder in tension
y_bar_shell = (ELong_br*2*pi*r*y_bar1 + EBlad*2*(pi/2 - theta)*r*y_bar2)/...
    (ELong_br*2*pi*r + EBlad*2*(pi/2 - theta)*r);

% Find the translation of the pressure resultant
y_bar_shell_prime = (1.08729054436952 - 1.08717291025363)/1e-6

P*kappa/y_bar_shell












%%
ELong = 997.821957804708; % *3*0.0333333333333333;
EHoop = 8300.34166620375; % *3*0.0333333333333333;
nuHL = 2.81709211913857;
nuLH = nuHL/EHoop*ELong;

C11 = ELong/(1 - nuLH*nuHL);
C22 = EHoop/(1 - nuLH*nuHL);
C12 = nuHL*ELong/(1 - nuLH*nuHL);

C = C11 - C12/C22
