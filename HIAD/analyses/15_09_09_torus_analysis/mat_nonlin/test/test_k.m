% Test the K_nonlin_shear function
% Andy Young
% November 17, 2014

% Linear elastic tube
L = 1;
r = 1;
t = .01;
E = 1e10;
A = 2*pi*r*t;
I = pi*r^2*t;
J = 2*I;

EA = E*A;
EIzzi = E*I;
EIzzj = E*I;
EIyyi = E*I;
EIyyj = E*I;
G = 1e10; % E/(2*(1 + .3));
tan_stiff = [EA EIzzi EIzzj EIyyi EIyyj G]';

material =  [1 E (E/(2*G) - 1)]; % [type E nu]
geom = [A I I 2.0 J]; % [A Izz Iyy ky J]
connect = [1 2];
nodes = [0 0 0; 1 0 0];

[kEB] = element_3(material,geom,connect,nodes);
[kS1] = element_2(material,geom,connect,nodes);
[~,kS2] = K_nonlin_shear(tan_stiff,L,r,t);

compare = [kS1(6,6) kEB(6,6) kS2(6,6)]';

kEB_bound = [eye(6) zeros(6); zeros(6) kEB(7:12,7:12)];
kS1_bound = [eye(6) zeros(6); zeros(6) kS1(7:12,7:12)];
kS2_bound = [eye(6) zeros(6); zeros(6) kS2(7:12,7:12)];


f = [0 0 0 0 0 0 0 -1 0 0 0 0]';

uEB = kEB_bound\f;
uS1 = kS1_bound\f;
uS2 = kS2_bound\f;

delta_V = -L/(A*G);

compare = [-L^3/(3*E*I) -(L^3/(3*E*I) + 2*L/(A*G)) uEB(8) uS1(8) uS2(8)]'













