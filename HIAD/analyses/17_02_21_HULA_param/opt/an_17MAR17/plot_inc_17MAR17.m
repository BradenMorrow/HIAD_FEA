function [k,FU] = plot_inc_17MAR17(FEM)
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
    figure(FEM.PLOT.fig + 1)
%     clf
    box on
    hold on

    plot(Uzym,Rz,'b.-')
    plot(Uzyp,Rz,'b.-')
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

% Maximum load and displacement
FU = [Rz Uzym];


end
















