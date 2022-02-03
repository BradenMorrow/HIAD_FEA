function [k,Y_soft] = plot_inc(FEM)
% HIAD analysis plotting function

% Z direction reaction
RZ_ind = (3:6:size(FEM.OUT.Fext_inc,1))';
Rz = sum(FEM.OUT.Fext_inc(RZ_ind,:))';

% +Y and -Y vertical displacement of T5
theta = FEM.MODEL.theta;
ind0 = round(interp1(theta,(1:size(theta,1))',[pi/2 3*pi/2]'));
ind = size(theta,1)*6*4 + (ind0 - 1)*6 + 3;
Uz = FEM.OUT.Uinc(ind,:);
Uzp = Uz(1,:)';
Uzm = Uz(2,:)';


figure(FEM.PLOT.fig + 1)
clf
box on
hold on

plot(Uzm,Rz,'r.-')
plot(Uzp,Rz,'b.-')

% xlim([0 12])
% ylim([0 50000])
xlabel('T6 Vertical Displacement (in)')
ylabel('Applied Load, Z Component (lbf)')


% Initial slope
k_0 = (Rz(2) - Rz(1))/(Uzp(2) - Uzp(1));

% Slope at end of loading
k_end = (Rz(end) - Rz(end - 1))/(Uzp(end) - Uzp(end - 1));

k = [k_0 k_end];





% Secant between first and last points
L1 = [0 0
    Uzp(end) Rz(end)];
x1 = 0;
y1 = 0;
x2 = Uzp(end);
y2 = Rz(end);

plot([0 Uzp(end)]*.75,k(1)*[0 Uzp(end)]*.75,'c--')
plot([0 Uzp(end)],k(2)*([0 Uzp(end)] - [Uzp(end) Uzp(end)]) + Rz(end),'c--')
% plot(L1(:,1),L1(:,2),'m--')

% Distance between secant and points
d = zeros(size(Rz,1),1);
for i = 1:size(Rz,1)
    x0 = Uzp(i);
    y0 = Rz(i);
    d(i) = abs((y2 - y1)*x0 - (x2 - x1)*y0 + x2*y1 - y2*x1)/sqrt((y2 - y1)^2 + (x2 - x1)^2);
end

% Maximum distance
[~,I] = max(d);

% Secant between first and high point
L2 = [0 0
    Uzp(I),Rz(I)];

plot(L2(:,1)*2,L2(:,2)*2,'m--')

% Intersection between end tangent and secant between first and high point
a = L2(2,2)/L2(2,1);
c = 0;
b = k(2);
d = Rz(end) - k(2)*Uzp(end);
x_i = (d - c)/(a - b);
y_i = a*(d - c)/(a - b) + c;

plot(x_i,y_i,'bx')


Y_soft = y_i;
end
















