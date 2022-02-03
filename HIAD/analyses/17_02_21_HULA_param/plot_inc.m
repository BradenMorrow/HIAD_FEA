function [k,F_soft] = plot_inc(FEM)
% HIAD analysis plotting function

% Z direction reaction
RZ_ind = (3:6:size(FEM.OUT.Fext_inc,1))';
Rz = sum(FEM.OUT.Fext_inc(RZ_ind,:))';

% +Y and -Y vertical displacement of T5
theta = FEM.MODEL.theta;
ind0 = round(interp1(theta,(1:size(theta,1))',[pi/2 3*pi/2]'));
ind = size(theta,1)*6*5 + (ind0 - 1)*6 + 3;
Uzy = FEM.OUT.Uinc(ind,:);
Uzyp = Uzy(1,:)';
Uzym = Uzy(2,:)';

% +X and -X vertical displacement of T5
theta = FEM.MODEL.theta;
ind0 = round(interp1(theta,(1:size(theta,1))',[0 pi]'));
ind = size(theta,1)*6*5 + (ind0 - 1)*6 + 1;
Uzx = FEM.OUT.Uinc(ind,:);
Uzxp = Uzx(1,:)';
Uzxm = Uzx(2,:)';


plotting0 = 1;
if plotting0 == 1
    
    ufac = 25.4;
    ffac = 0.004448;
    
    figure(FEM.PLOT.fig + 1)
%     clf
    box on
    hold on

    plot(Uzym*ufac,Rz*ffac,'k.-')
    plot(Uzyp*ufac,Rz*ffac,'k.-')
%     plot(Uzxm,Rz,'r.-')
%     plot(Uzxp,Rz,'r.-')

    % xlim([0 12])
    % ylim([0 50000])
    xlabel('T6 Vertical Displacement (in)')
    ylabel('Applied Load, Z Component (lbf)')
end

% Initial slope
k_0 = (Rz(2) - Rz(1))/(Uzyp(2) - Uzyp(1));

% Slope at end of loading
k_end = (Rz(end) - Rz(end - 1))/(Uzyp(end) - Uzyp(end - 1));

k = [k_0 k_end];




% Softening load
% Secant between first and last points
% % % L1 = [0 0
% % %     Uzp(end) Rz(end)];
x1 = 0;
y1 = 0;
x2 = Uzyp(end);
y2 = Rz(end);

% % % plot([0 Uzp(end)]*.75,k(1)*[0 Uzp(end)]*.75,'c--')
% % % plot([0 Uzp(end)],k(2)*([0 Uzp(end)] - [Uzp(end) Uzp(end)]) + Rz(end),'c--')
% % % % % % plot(L1(:,1),L1(:,2),'m--')

% Distance between secant and points
d = zeros(size(Rz,1),1);
for i = 1:size(Rz,1)
    x0 = Uzyp(i);
    y0 = Rz(i);
    d(i) = abs((y2 - y1)*x0 - (x2 - x1)*y0 + x2*y1 - y2*x1)/sqrt((y2 - y1)^2 + (x2 - x1)^2);
end

% Maximum distance
[~,I] = max(d);

% Secant between first and high point
L2 = [0 0
    Uzyp(I),Rz(I)];

% Intersection between end tangent and secant between first and high point
a0 = L2(2,2)/L2(2,1);
c0 = 0;
b0 = k(2);
d0 = Rz(end) - k(2)*Uzyp(end);
y_i = a0*(d0 - c0)/(a0 - b0) + c0;


plotting1 = 0;
if plotting1 == 1
    L1 = [0 0
        Uzyp(end) Rz(end)];
    x_i = (d0 - c0)/(a0 - b0);
    plot([0 Uzyp(end)]*.75,k(1)*[0 Uzyp(end)]*.75,'c--')
    plot([0 Uzyp(end)],k(2)*([0 Uzyp(end)] - [Uzyp(end) Uzyp(end)]) + Rz(end),'c--')
    plot(L1(:,1),L1(:,2),'m--')
    plot(L2(:,1)*2,L2(:,2)*2,'m--')
    plot(x_i,y_i,'bx')
    plot(Uzyp(I),Rz(I),'rx')
end

F_soft = y_i;
end
















