% Plot cords
% February 9, 2017

% Cord compare
d = load('zylon_axial_table_update_06OCT16'); % Cord response [load strain] [lbf in/in]
% d(:,2) = d(:,2)/2;

d2 = [-300., -1.0
    0.0, 0.000000
    15.1, 0.000259
    118.2, 0.001851
    239.2, 0.003450
    378.6, 0.005070
    528.2, 0.006632
    697.7, 0.008248
    878.2, 0.009839
    1069.1, 0.011412
    1273.6, 0.013001
    1488.6, 0.014588
    1716.5, 0.016197
    1951.3, 0.017791
    2198.1, 0.019411
    2448.3, 0.021006
    2704.8, 0.022602
    2966.7, 0.024200
    3232.0, 0.025792
    3500.0, 0.027381
    3770.0, 0.028967
    4041.5, 0.030555
    4314.1, 0.032145
    4849.6, 0.035281
    5109.7, 0.036821];

figure(100)
clf
box on
hold on

plot(d(:,2),d(:,1),'b-')
plot(d2(:,2),d2(:,1),'k--')

xlim([0 .03])

% Strap compare


rad = [-300., -1.0
    0.0, 0.000000
    100.0, 0.000546
    3000.0, 0.016367];


chev = [-3000.0, -0.008185
    -100.0, -0.000273
    0.0, 0.000000
    100.0, 0.000273
    3000.0, 0.008185];


loop = [-300., -1.0
    0.0, 0.000000
    100.0, 0.000546
    3000.0, 0.016371
    30000, 0.16371];

% S = 1; % Strap number
% straps(S).con = [0 1]; % Torus connectivities (0 for node)
% % straps(S).node1 = [C(1,1) C(1,1)*tand(alpha) + 2*r(1)/cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% straps(S).bound1 = 1; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
% straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
% straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
PT = 50; % Level of strap pretension
% PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension

% k_ten = 1.8315e+05*2; % 150400; % Tension stiffness of straps (lbf/strain)
% k_com = 1.8315e+05*2; % 100; % Compression stiffness of straps (lbf/strain)
k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % 1.8315e+05*2; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % 36.63; % Load level to begin linear tension stiffness
eps0 = .05; % 0.09375; % .0001; % Strain level to begin linear tension stiffness

[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,PT,F0,eps0);
x = linspace(-.05,.15,1000)';


figure(101)
clf
box on
hold on
plot(rad(:,2),rad(:,1),'b-')
plot(chev(:,2),chev(:,1),'r--')
plot(loop(:,2),loop(:,1),'g--')
plot(x,ppval(axial,x),'c-')

xlim([min(x) max(x)])

legend('rad','chev','loop','location','northwest')





