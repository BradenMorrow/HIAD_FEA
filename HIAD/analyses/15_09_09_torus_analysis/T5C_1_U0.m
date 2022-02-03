% Preprocess nodes for FE model input
% T5C-1 torus

%% Input
% T5C-1, stage 1
CG = [0      -80.328     -0.01125     -0.25277
    11.25      -78.781      -15.671     -0.18098
     22.5       -74.08      -30.685     -0.14109
    33.75      -66.492      -44.428    -0.053566
       45      -56.387      -56.386     0.070497
    56.25      -44.173      -66.106       0.1595
     67.5      -30.346       -73.26      0.20912
    78.75      -15.445      -77.644      0.21087
       90    0.0022319      -78.989      0.20266
   101.25       15.428      -77.556      0.18814
    112.5       30.249      -73.022      0.14499
   123.75       43.935      -65.757     0.076699
      135       56.028      -56.028    -0.007115
   146.25       66.118      -44.178    -0.063254
    157.5        73.81      -30.574     -0.14779
   168.75        78.81      -15.675     -0.14721
      180       80.405   1.0537e-06     -0.12447
   191.25       78.726        15.66     -0.14759
    202.5       73.894       30.609      -0.1752
   213.75       66.336       44.324     -0.15432
      225       56.316       56.318     -0.07911
   236.25       44.186        66.13     0.015159
    247.5       30.405       73.408      0.10838
   258.75       15.475       77.803      0.21727
      270  -0.00099049       78.829      0.30304
   281.25      -15.417       77.503      0.32833
    292.5      -30.228       72.984      0.28206
   303.75      -43.927       65.744      0.21273
      315      -56.038       56.036     0.093176
   326.25       -66.11       44.175    -0.074294
    337.5      -73.784       30.565     -0.26139
   348.75      -78.668       15.647     -0.33045
      360      -80.328     -0.01125     -0.25277];

CG(:,1) = CG(:,1) - 180;
CG(:,1) = CG(:,1) + 90;

%% Fourier expansion
numpts = 100; % Number of spline points
n_wave = 4; % Number of waves
nn = 1 + n; % Number of nodes

th = linspace(CG(1,1),CG(end,1),numpts)'; % Interpolation theta
% tt = interp1((th - th(1))/th(end),th,linspace(0,1,nn))' - 180; % Nodal theta

% Radius
r0 = sqrt(CG(:,2).^2 + CG(:,3).^2); % From input
r_spline = spline(CG(:,1),r0); % Create spline
r_int = ppval(r_spline,th); % Interpolate
[R0] = fourier(th*pi/180,r_int,n_wave,theta); % Fourier expansion

% Out of plane
z0 = CG(:,4); % From input
z_spline = spline(CG(:,1),z0); % Create spline
z_int = ppval(z_spline,th); % Interpolate
[Z] = fourier(th*pi/180,z_int,n_wave,theta); % Fourier expansion

%% Sort and transform points
% % Remove repeated end entry
% tt(end) = [];
% tt(1) = 0;
% R(end) = [];
% Z(end) = [];
% 
% % Sort, positive x axis is zero degrees
% I = tt < -1e-5;
% tt = [tt(~I); tt(I) + 360];
% tt_rad = tt*pi/180;
% 
% R = [R(~I); R(I)];
% Z = [Z(~I); Z(I)];

% Transform to cartesian coordinates
X = R0.*cos(theta);
Y = R0.*sin(theta);

U0_tor2 = [X - R*cos(theta) Y - R*sin(theta) Z zeros(size(X,1),3)]';
U0_tor = U0_tor2(:);





% U0_tor = U0_tor/1000;





