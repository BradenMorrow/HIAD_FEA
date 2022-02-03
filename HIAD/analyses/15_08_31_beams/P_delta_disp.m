% Calculate the displacement due to P-delta effect
% October 01, 2015
% Andy Young

load('FEM_out_01OCT15.mat')

x = FEM_out.MODEL.nodes(:,1); % X location of nodes
x(1) = [];
U = FEM_out.OUT.U; % Displacement
theta = U(12); % Rotation of free end
P = 20*pi*6.7225^2*100; % Pressure resulatant

U2 = zeros(length(U)/6,6); % Reorganize U
for j = 1:6
    U2(:,j) = U(j:6:length(U));
end
U2(1,:) = [];
U2(:,2) = U2(:,2) - U2(1,2);

M = -P*cos(theta)*U2(:,2); % Moment due to pressure resultant

EI = zeros(31,1); % Stiffness of each element
ref = 2;
for i = 1:32 - 1
    EI(i) = FEM_out.EL(i + 1).el_in0.EI(1);
end

EIi = interp1(linspace(0,1,31),EI,linspace(0,1,32))'; % Stiffness of each node

kappa = M./EIi; % Curvature due to axial load
int_kappa = (kappa(2:end) + kappa(1:end - 1))/2.*(x(2:end) - x(1:end - 1));
int_kappa = [0; int_kappa];
int_int_kappa = (int_kappa(2:end) + int_kappa(1:end - 1))/2.*(x(2:end) - x(1:end - 1));

Uy = sum(int_int_kappa);

disp(Uy)





figure(11)
clf
box on
hold on
plot(x,kappa,'bx-')

xlabel('x (in)')
ylabel('\kappa (in^{-1})')
xlim([0 64.5])













