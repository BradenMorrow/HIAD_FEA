function plot_cord(FEM)

% Vertical reaction
RZ_ind = (3:6:size(FEM.OUT.Fext_inc,1))';
Rz = sum(FEM.OUT.Fext_inc(RZ_ind,:))';

% Cord force
cord_f = FEM.OUT.cord_f;
cord_f2 = FEM.OUT.cord_f2;
% cord_f(cord_f(:,1) == 0,:) = [];

figure(101)
clf
box on
hold on

for i = 1:7
    plot(Rz,cord_f(:,i),'b-');
    plot(Rz,cord_f2(:,i),'r-');
end

xlabel('Z reaction (lbf)')
ylabel('Cord force (lbf)')



figure(102)
clf
box on
hold on
plot(Rz,FEM.OUT.Uinc(5,:)*180/pi,'b-')
xlabel('Z reaction (lbf)')
ylabel('T1 torsional rotation (deg)')

end