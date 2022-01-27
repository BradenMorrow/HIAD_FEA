function [Kel,Fint_i,fint_i,rot,DELTA_rot,DEBUG] = element_4(element_in)
%ELEMENT_4
%   3D corotational beam formulation, see Crisfield (1990), A consistent
%   co-rotational formulation for non-linear, three dimensional,
%   beam-elements
%   See also de Souza dissertation (2000), Force-based finite element for
%   large displacement inelastic analysis of frames
%   Generally follows de Souza


% Extract variables
nodes = element_in.node_ij;
orient = element_in.orient_ij;
U = element_in.U_ij;
DELTA_U = element_in.DELTA_U_ij;
delta_U = element_in.delta_U_ij;
% U0 = element_in.U0_ij;
material = element_in.material;
geom = element_in.geom;


% Components of length and length
% Initial
L10 = nodes(2,1) - nodes(1,1);
L20 = nodes(2,2) - nodes(1,2);
L30 = nodes(2,3) - nodes(1,3);
L0 = sqrt(L10^2 + L20^2 + L30^2);

% Current
L1 = (nodes(2,1) + U(2,1)) - (nodes(1,1) + U(1,1));
L2 = (nodes(2,2) + U(2,2)) - (nodes(1,2) + U(1,2));
L3 = (nodes(2,3) + U(2,3)) - (nodes(1,3) + U(1,3));
L = sqrt(L1^2 + L2^2 + L3^2);

% To orientation nodes
% Initial
Lo10 = orient(1:2,1) - nodes(1:2,1);
Lo20 = orient(1:2,2) - nodes(1:2,2);
Lo30 = orient(1:2,3) - nodes(1:2,3);

% Obtain the initial nodal triads
% Unit vectors at i node
e10 = [L10 L20 L30]';
e10 = e10/norm(e10);

e30 = cross(e10,[Lo10(1) Lo20(1) Lo30(1)]');
e30 = e30/norm(e30);

e20 = cross(e30,e10);
e20 = e20/norm(e20);

E0 = [e10 e20 e30];

% Section 5.3.2a - de Souza
e0 = get_quat_R(E0);

qi_old = get_quat_PHI(U(1,4:6)');
qj_old = get_quat_PHI(U(2,4:6)');

delta_qi = get_quat_PHI(delta_U(1,4:6)');
delta_qj = get_quat_PHI(delta_U(2,4:6)');

% STEP 2
qI = quat_prod(delta_qi,qi_old); % Equation 5.46
qJ = quat_prod(delta_qj,qj_old);

% Calculate nodal rotation for incorporation into displacement vector
rotI = get_PHI_quat(qI);
rotJ = get_PHI_quat(qJ);
rot = [rotI'; rotJ'];

%%%%%%%%%%%%%%%
% If U = zeros, rotI and rotJ = zeros, nI and nJ = e0 ==> OK
% However, NI and NJ should equal E0, not the case.
% % % nI = quat_prod(qI,e0); % Equation 5.48
% % % nJ = quat_prod(qJ,e0);
% % % 
% % % NI = get_R_quat(nI);
% % % NJ = get_R_quat(nJ);
% % % 
% % % % STEP 3
% % % gammaI = get_PHI_quat(nI);
% % % gammaJ = get_PHI_quat(nJ);
% % % 
% % % % STEP 4
% % % R_bar = get_R_PHI((gammaI + gammaJ)/2);


% June 25, 2015
NI = get_R_PHI(rot(1,:)')*E0;
NJ = get_R_PHI(rot(2,:)')*E0;


% % % % STEP 3
% % % gammaI = get_PHI_quat(nI);
% % % gammaJ = get_PHI_quat(nJ);

% STEP 4
R_bar = (NI + NJ)/2;



R_bar = normc(R_bar);



% % Also need step change in rotations for arc-length solver (DELTA_U)
DELTA_qi_old = get_quat_PHI(DELTA_U(1,4:6)');
DELTA_qj_old = get_quat_PHI(DELTA_U(2,4:6)');

DELTA_qi = quat_prod(delta_qi,DELTA_qi_old);
DELTA_qj = quat_prod(delta_qj,DELTA_qj_old);

DELTA_rotI = get_PHI_quat(DELTA_qi);
DELTA_rotJ = get_PHI_quat(DELTA_qj);
DELTA_rot = [DELTA_rotI'; DELTA_rotJ'];


% RI = get_R_quat(qI);
% RJ = get_R_quat(qJ);
% RI0 = get_R_PHI(U0(1,4:6)');
% RJ0 = get_R_PHI(U0(2,4:6)');
% 
% DELTA_RI = RI*(RI0\eye(3));
% DELTA_RJ = RJ*(RJ0\eye(3));
% 
% DELTA_rotI = get_PHI_R(DELTA_RI);
% DELTA_rotJ = get_PHI_R(DELTA_RJ);
% DELTA_rot = [DELTA_rotI'; DELTA_rotJ'];



% Compute e1, e2 and e3 to form E
e1 = [L1 L2 L3]';
e1 = e1/norm(e1);

e2 = R_bar(:,2) - R_bar(:,2)'*e1/2*(R_bar(:,1) + e1);
% e2 = R_bar(:,2) - R_bar(:,2)'*e1/(1 + R_bar(:,1)'*e1)*(R_bar(:,1) + e1);
e2 = e2/norm(e2);

e3 = R_bar(:,3) - R_bar(:,3)'*e1/2*(R_bar(:,1) + e1);
% e3 = R_bar(:,3) - R_bar(:,3)'*e1/(1 + R_bar(:,1)'*e1)*(R_bar(:,1) + e1);
e3 = e3/norm(e3);

E = [e1 e2 e3];

% Compute basic rotations
phiI1 = asin((e3'*NI(:,2) - e2'*NI(:,3))/2);
phiI2 = asin((e1'*NI(:,3) - e3'*NI(:,1))/2);
phiI3 = asin((e2'*NI(:,1) - e1'*NI(:,2))/2);
phiJ1 = asin((e3'*NJ(:,2) - e2'*NJ(:,3))/2);
phiJ2 = asin((e1'*NJ(:,3) - e3'*NJ(:,1))/2);
phiJ3 = asin((e2'*NJ(:,1) - e1'*NJ(:,2))/2);

% Basic displacements and rotations
% D = [ul r1z r2z r1y r2y rx]'
D = zeros(6,1);
D(1) = (L^2 - L0^2)/(L + L0);
D(2) = phiI3;
D(3) = phiJ3;
D(4) = phiI2;
D(5) = phiJ2;
D(6) = phiJ1 - phiI1;

% Transformation matrix
A = 1/L*(eye(3) - e1*e1');

% Get L matrices
L_r2 = get_L(R_bar(:,2),e1,L,R_bar(:,1));
L_r3 = get_L(R_bar(:,3),e1,L,R_bar(:,1));

% Get h vectors
S_nI1 = get_S(NI(:,1));
S_nI2 = get_S(NI(:,2));
S_nI3 = get_S(NI(:,3));
S_nJ1 = get_S(NJ(:,1));
S_nJ2 = get_S(NJ(:,2));
S_nJ3 = get_S(NJ(:,3));

hI1 = [0 0 0 (S_nI2*e3 - S_nI3*e2)' 0 0 0 0 0 0]';
hI2 = [(A*NI(:,3))' (S_nI1*e3 - S_nI3*e1)' -(A*NI(:,3))' 0 0 0]';
hI3 = [(A*NI(:,2))' (S_nI1*e2 - S_nI2*e1)' -(A*NI(:,2))' 0 0 0]';
hJ1 = [0 0 0 0 0 0 0 0 0 (S_nJ2*e3 - S_nJ3*e2)']';
hJ2 = [(A*NJ(:,3))' 0 0 0 -(A*NJ(:,3))' (S_nJ1*e3 - S_nJ3*e1)']';
hJ3 = [(A*NJ(:,2))' 0 0 0 -(A*NJ(:,2))' (S_nJ1*e2 - S_nJ2*e1)']';

% Get t vectors and T matrix
t1 = [-e1' 0 0 0 e1' 0 0 0];
t2 = 1/(2*cos(phiI3))*(L_r2*NI(:,1) + hI3)';
t3 = 1/(2*cos(phiJ3))*(L_r2*NJ(:,1) + hJ3)';
t4 = 1/(2*cos(phiI2))*(-L_r3*NI(:,1) - hI2)';
t5 = 1/(2*cos(phiJ2))*(-L_r3*NJ(:,1) - hJ2)';
t6J = 1/(2*cos(phiJ1))*(L_r3*NJ(:,2) - L_r2*NJ(:,3) + hJ1)';
t6I = 1/(2*cos(phiI1))*(L_r3*NI(:,2) - L_r2*NI(:,3) + hI1)';
t6 = t6J - t6I;

T = [t1; t2; t3; t4; t5; t6];

% % % % Extract variables
% % % E = material(2);
% % % Area = geom(1);
% % % Izz = geom(2);
% % % Iyy = geom(3);
% % % G = E/(2*(1 + material(3)));
% % % J = geom(5);
% % % ky = geom(4);

% Calculate internal forces
% D = [ul r1z r2z r1y r2y rx]'
% P = [axial M1z M2z M1y M2y Tx]'
% % % P1 = E*Area*D(1)/L0;
% % % P2 = 2*E*Izz/L0*(2*D(2) + D(3));
% % % P3 = 2*E*Izz/L0*(D(2) + 2*D(3));
% % % P4 = 2*E*Iyy/L0*(2*D(4) + D(5));
% % % P5 = 2*E*Iyy/L0*(D(4) + 2*D(5));
% % % P6 = G*J*D(6)/L0;
% % % P = [P1 P2 P3 P4 P5 P6]';
% % % DEBUG.P = P;

% % % P1 = E*Area*D(1)/L;
% % % P2 = 2*E*Izz/L*(2*D(2) + D(3));
% % % P3 = 2*E*Izz/L*(D(2) + 2*D(3));
% % % P4 = 2*E*Iyy/L*(2*D(4) + D(5));
% % % P5 = 2*E*Iyy/L*(D(4) + 2*D(5));
% % % P6 = G*J*D(6)/L;
% % % P = [P1 P2 P3 P4 P5 P6]';
% % % DEBUG.P = P;

KL = K_lin(material,geom,L);
P = KL*D;
DEBUG.P = P;

% Internal forces in local coordinate system
fint_i = [-P(1)       % Vx1
    (P(3) + P(2))/L   % Vy1
    -(P(5) + P(4))/L  % Vz1
    -P(6)             % Mx1
    P(4)              % My1
    P(2)              % Mz1
    P(1)              % Vx2
    -(P(3) + P(2))/L  % Vy2
    (P(5) + P(4))/L   % Vz2
    P(6)              % Mx2
    P(5)              % My2
    P(3)];            % Mz2

% Scaled internal forces
m2 = P(2)/(2*cos(phiI3));
m3 = P(3)/(2*cos(phiJ3));
m4 = P(4)/(2*cos(phiI2));
m5 = P(5)/(2*cos(phiJ2));
m6I = P(6)/(2*cos(phiI1));
m6J = P(6)/(2*cos(phiJ1));

% Geometric stiffness matrix, KG
% KA
KA = P(1)*[A zeros(3) -A zeros(3)
    zeros(3) zeros(3) zeros(3) zeros(3)
    -A zeros(3) A zeros(3)
    zeros(3) zeros(3) zeros(3) zeros(3)];

% KB
KB = P(2)*(t2'*t2)*tan(phiI3) + P(3)*(t3'*t3)*tan(phiJ3) + P(4)*(t4'*t4)*tan(phiI2) + ...
    P(5)*(t5'*t5)*tan(phiJ2) + P(6)*((-t6I'*t6I)*tan(phiI1) + (t6J'*t6J)*tan(phiJ1)); % P(6)I?

G1 = get_G(R_bar(:,2),NI(:,1),e1,L,R_bar(:,1));
G2 = get_G(R_bar(:,2),NJ(:,1),e1,L,R_bar(:,1));
G3 = get_G(R_bar(:,3),NI(:,1),e1,L,R_bar(:,1));
G4 = get_G(R_bar(:,3),NJ(:,1),e1,L,R_bar(:,1));
G5 = get_G(R_bar(:,3),NJ(:,2),e1,L,R_bar(:,1));
G6 = get_G(R_bar(:,2),NJ(:,3),e1,L,R_bar(:,1));
G7 = get_G(R_bar(:,3),NI(:,2),e1,L,R_bar(:,1));
G8 = get_G(R_bar(:,2),NI(:,3),e1,L,R_bar(:,1));

% KC
KC = m2*G1 + m3*G2 - m4*G3 - m5*G4 + m6I*(G5 - G6) - m6J*(G7 - G8);

% KD
KD2 = -L_r2*(m2*S_nI1 + m6I*S_nI3) + L_r3*(m4*S_nI1 + m6I*S_nI2);
KD4 = -L_r2*(m3*S_nJ1 - m6J*S_nJ3) + L_r3*(m5*S_nJ1 - m6J*S_nJ2);
KD = [zeros(12,3) KD2 zeros(12,3) KD4];

% KE
KE = KD';

% KF
M_nI2 = get_M(NI(:,2),e1,L);
M_nJ2 = get_M(NJ(:,2),e1,L);
M_nI3 = get_M(NI(:,3),e1,L);
M_nJ3 = get_M(NJ(:,3),e1,L);

S_e2 = get_S(e2);
S_e1 = get_S(e1);
S_e3 = get_S(e3);

KF11 = -m2*M_nI2 - m3*M_nJ2 + m4*M_nI3 + m5*M_nJ3;
KF12 = -m2*A*S_nI2 + m4*A*S_nI3;
KF14 = -m3*A*S_nJ2 + m5*A*S_nJ3;
KF22 = m2*(S_e2*S_nI1 - S_e1*S_nI2) - m4*(S_e3*S_nI1 - S_e1*S_nI3) - ...
    m6I*(S_e3*S_nI2 - S_e2*S_nI3);
KF44 = m3*(S_e2*S_nJ1 - S_e1*S_nJ2) - m5*(S_e3*S_nJ1 - S_e1*S_nJ3) + ...
    m6J*(S_e3*S_nJ2 - S_e2*S_nJ3);

KF = [KF11 KF12 -KF11 KF14
    KF12' KF22 -KF12' zeros(3)
    -KF11 -KF12 KF11 -KF14
    KF14' zeros(3) -KF14' KF44];

% KG - geometric stiffness matrix
KG = KA + KB + KC + KD + KE + KF;

% KL - linear portion of stiffness matrix
% KL = K_lin(material,geom,L);

% Element global tangent stiffness matrix
Kel = T'*KL*T + KG;

% Element global internal force vector
% Fint_i = T'*KL*D;
Fint_i = T'*P;

% [Fint_i Fint_i0]

if element_in.disp_flag == 1
%     disp(fint_i)
end

end

































