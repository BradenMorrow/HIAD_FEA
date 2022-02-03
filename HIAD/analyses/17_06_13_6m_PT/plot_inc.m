function [k] = plot_inc(FEM)
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

plot(Uzp,Rz,'bo-')
plot(Uzm,Rz,'ro-')


k = (Rz(end) - Rz(end - 1))/(Uzp(end) - Uzp(end - 1));

end

