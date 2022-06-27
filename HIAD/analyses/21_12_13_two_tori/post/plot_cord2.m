function plot_cord2(FEM,Ffac,fig)

% Vertical reaction
RZ_ind = (3:6:size(FEM.OUT.Fext_inc,1))';
Rz = sum(FEM.OUT.Fext_inc(RZ_ind,:))';

% Cord force
cord_f = FEM.OUT.cord_f;
cord_f2 = FEM.OUT.cord_f2;
cord_f(cord_f(:,1) == 0,:) = [];
cord_f2(cord_f2(:,1) == 0,:) = [];

% Interpolate for strain
d = load('zylon_axial_table_update_06OCT16'); % Cord response [load strain] [lbf in/in]
cord_eps = interp1(d(:,1),d(:,2),cord_f);
cord_eps2 = interp1(d(:,1),d(:,2),cord_f2);


% Cord force
figure(fig + 3)
clf
box on
hold on

for i = 1:size(cord_f,2)
    plot(Rz*Ffac,cord_f(:,i)*Ffac,'b-');
    plot(Rz*Ffac,cord_f2(:,i)*Ffac,'r-');
end

xlabel('Z reaction (kN)')
ylabel('Cord force (kN)')

N = 0;

% Cord strain
figure(fig)
clf
box on
hold on

for i = 2 % 1:size(cord_f,2)
    plot(Rz(1:end - N)*Ffac,(cord_eps(1:end - N,i) - cord_eps(1,i))*1e6,'k--');
    plot(Rz(1:end - N)*Ffac,(cord_eps2(1:end - N,i) - cord_eps2(1,i))*1e6,'k--');
end

xlabel('Z reaction (kN)')
ylabel('Microstrain')


% Cord strain
figure(fig + 1)
clf
box on
hold on

for i = 2 % 1:size(cord_f,2)
    plot(Rz(1:end - N)*Ffac,(cord_eps(1:end - N,i) - cord_eps(1,i))*1e6,'k--');
    plot(Rz(1:end - N)*Ffac,(cord_eps2(1:end - N,i) - cord_eps2(1,i))*1e6,'k--');
end

xlabel('Z reaction (kN)')
ylabel('Microstrain')



% % % figure(102)
% % % clf
% % % box on
% % % hold on
% % % plot(Rz,FEM.OUT.Uinc(5,:)*180/pi,'b-')
% % % xlabel('Z reaction (lbf)')
% % % ylabel('T1 torsional rotation (deg)')

end