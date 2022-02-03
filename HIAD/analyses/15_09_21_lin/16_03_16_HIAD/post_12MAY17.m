function post_12MAY17(FEM)

Ufac = 25.4;
Pfac = 0.004448;

a  = 1;

FEM_out = FEM;
theta = FEM_out.MODEL.theta_ind(1).ind;
% Post processing
% March 01, 2016

%%
% Get Z direction reaction force
FEM_out.OUT.Fext_inc(:,size(FEM_out.OUT.Uinc,2) + 1:end) = [];


RZ_ind = (3:6:size(FEM_out.OUT.Fext_inc,1))';
Ry = sum(FEM_out.OUT.Fext_inc(RZ_ind - 1,:))';
Rz = sum(FEM_out.OUT.Fext_inc(RZ_ind,:))';
Ryz = (Ry.^2 + Rz.^2).^.5;
Rd = Ryz*cosd(20.739); % Rz; % 

% Calculate total drag load
r1 = 657.5/2; % Outside radius (in)
r0 = 340/2; % Centerbody radius (in)

Atot = pi*r1^2; % Total area
Acb = pi*r0^2; % Centerbody area
Ainf = Atot - Acb; % Inflatable area
Finf = Rd/.8*Atot/Ainf; % Vertical force on inflatable

% Z direction displacement
indU0 = size(theta,1)*6*4 + 3;
indU90 = size(theta,1)*6*4 + 3 + size(theta,1)/4*6;
indU270 = size(theta,1)*6*4 + 3 + size(theta,1)*3/4*6;
Ui0 = FEM_out.OUT.Uinc(indU0,:)';
Ui90 = FEM_out.OUT.Uinc(indU90,:)';
Ui270 = FEM_out.OUT.Uinc(indU270,:)';

U0 = [0; Ui0 - Ui0(1)*0];
U90 = [0; Ui90 - Ui90(1)*0];
U270 = [0; Ui270 - Ui270(1)*0];
F = [0; Finf];
F2 = [0; Rz];

% Plot load vertical displacement
figure(12)
clf
box on
hold on
% plot(U0,F,'g-')

% for i = 1:4
%     F2(end) = [];
%     U90(end) = [];
%     U270(end) = [];
% end

if size(U90,1) == size(F2,1)
    plot(U90(1:end - a)*Ufac,F2(1:end - a)*Pfac,'r-')
    plot(U270(1:end - a)*Ufac,F2(1:end - a)*Pfac,'b-')
end


legend('Beam FE - leeward',...
    'Beam FE - windward',...
    'location','southeast')

xlim([0 700])
ylim([0 1200])

xlabel('Z disp (mm)')
ylabel('Drag load (kN)')


% plot([0 4 5 12 16],[0 .33 .45 1.45 1.95]*100000,'b-','linewidth',2)
% plot([0 4.5 11.5],[0 .6 1.9]*100000,'r-','linewidth',2)
% plot([0 4 5 12 16],[0 .33 .45 1.45 1.95]*100000,'b-','linewidth',2)
% plot([0 5 10 13.5 15 17.5 20],[0 .45 1.1 1.5 1.6 1.75 1.85]*100000,'r-','linewidth',2)


% % % PD = [8.20E+01	0.00E+00	0.00E+00
% % %     7.82E+03	8.68E-01	8.63E-01
% % %     2.95E+04	3.30E+00	3.50E+00
% % %     4.41E+04	4.85E+00	4.83E+00
% % %     5.25E+04	5.56E+00	5.35E+00
% % %     5.82E+04	5.96E+00	5.85E+00
% % %     6.29E+04	6.39E+00	6.26E+00
% % %     6.76E+04	6.85E+00	6.58E+00
% % %     7.59E+04	7.46E+00	7.13E+00
% % %     8.06E+04	7.79E+00	7.46E+00
% % %     9.20E+04	8.71E+00	8.25E+00
% % %     1.15E+05	1.06E+01	9.87E+00
% % %     1.42E+05	1.29E+01	1.18E+01
% % %     1.51E+05	1.38E+01	1.24E+01
% % %     1.56E+05	1.44E+01	1.28E+01
% % %     1.58E+05	1.47E+01	1.29E+01
% % %     1.66E+05	1.58E+01	1.35E+01
% % %     1.75E+05	1.72E+01	1.41E+01
% % %     1.78E+05	1.79E+01	1.44E+01
% % %     1.79E+05	1.83E+01	1.45E+01
% % %     1.82E+05	1.89E+01	1.47E+01
% % %     1.83E+05	1.93E+01	1.48E+01
% % %     1.84E+05	1.96E+01	1.49E+01
% % %     1.85E+05	2.01E+01	1.50E+01
% % %     1.86E+05	2.03E+01	1.51E+01
% % %     1.86E+05	2.04E+01	1.51E+01
% % %     1.86E+05	2.04E+01	1.51E+01];

% % % plot(PD(:,3),PD(:,1),'b-','linewidth',2)
% % % plot(PD(:,2),PD(:,1),'r-','linewidth',2)

% % % legend('Beam FE - windward',...
% % %     'Beam FE - leeward',...
% % %     'location','southeast')

drawnow


%% Torque
G = 4000/Ufac*Pfac*1000;
indT90 = size(theta,1)*4 + size(theta,1)/4;

T = permute(FEM.OUT.fint_el(12,indT90,:),[3 1 2]);
tau = T*15.919/(2*pi*15.919^3);
T2 = permute(FEM.OUT.fint_el(12,indT90,:),[3 1 2]);


figure(100)
% clf
box on
hold on
plot(F2(2:end - a)*Pfac,tau(1:end - a)/Ufac*Pfac*1000/G*100)
% plot(F2(2:end - 1)*Pfac,-T2(1:end - 1),'r-')

xlabel('Vertical reaction (kN)')
ylabel('Shear strain of torus T5 at \theta = 90^o (%)')

ylim([-.5 .5])

%%
% Plot strap forces
dof = 7; % DOF of interest

% All straps
% ind = (size(FEM.MODEL.connect,1) - size(MODEL_strap.connect,1) + 1:size(FEM.MODEL.connect,1))';

% Strap sets
% ind1 = theta_ind.loop1_1aft;
% ind2 = theta_ind.loop1_2aft;
% ind3 = theta_ind.loop1_3aft;
% ind4 = theta_ind.loop1_1fore;
% ind5 = theta_ind.loop1_2fore;
% ind6 = theta_ind.loop1_3fore;
% ind7 = theta_ind.loop2_1aft;
% ind8 = theta_ind.loop2_2aft;
% ind9 = theta_ind.loop2_3aft;
% ind10 = theta_ind.loop2_1fore;
% ind11 = theta_ind.loop2_2fore;
% ind12 = theta_ind.loop2_3fore;
% ind13 = theta_ind.rad_aft;
% ind14 = theta_ind.chev_aft;
% ind15 = theta_ind.rad_fore;
% ind16 = theta_ind.chev_fore;
theta_ind = FEM_out.MODEL.theta_ind;

ii(1).i = [theta_ind(14).ind
    theta_ind(15).ind
    theta_ind(16).ind];
ii(1).ii = [ones(size(theta_ind(14).ind,1),1)*1
    ones(size(theta_ind(15).ind,1),1)*2
    ones(size(theta_ind(16).ind,1),1)*3];

ii(2).i = [theta_ind(17).ind
    theta_ind(18).ind
    theta_ind(19).ind];
ii(2).ii = [ones(size(theta_ind(17).ind,1),1)*1
    ones(size(theta_ind(18).ind,1),1)*2
    ones(size(theta_ind(19).ind,1),1)*3];

ii(3).i = [theta_ind(20).ind
	theta_ind(21).ind
	theta_ind(22).ind];
ii(3).ii = [ones(size(theta_ind(20).ind,1),1)*1
	ones(size(theta_ind(21).ind,1),1)*2
	ones(size(theta_ind(22).ind,1),1)*3];

ii(4).i = [theta_ind(23).ind
	theta_ind(24).ind
	theta_ind(25).ind];
ii(4).ii = [ones(size(theta_ind(23).ind,1),1)*1
	ones(size(theta_ind(24).ind,1),1)*2
	ones(size(theta_ind(25).ind,1),1)*3];

ii(5).i = [theta_ind(26).ind
	theta_ind(28).ind];
ii(5).ii = [ones(size(theta_ind(26).ind,1),1)*1
	ones(size(theta_ind(28).ind,1),1)*2];

ii(6).i = [theta_ind(27).ind
	theta_ind(29).ind];
ii(6).ii = [ones(size(theta_ind(27).ind,1),1)*1
	ones(size(theta_ind(29).ind,1),1)*2];

so(6).straps_out = [];
strap_set = {'Loop straps set 1, aft'
    'Loop straps set 1, fore'
    'Loop straps set 2, aft'
    'Loop straps set 2, fore'
    'Radial straps'
    'Chevron straps'};
pt = [50 50 50 50 100 50]';

for i = 1:6
    ind = ii(i).i;
    straps_out = zeros(size(FEM_out.OUT.fint_el,3)+1,size(ind,1)); %Added 1 to set the rows of straps_out to match the dimensions of F 
    straps_out1 = FEM_out.OUT.fint_el(dof,ind,:);

    for j = 1:size(FEM_out.OUT.fint_el,3)
        straps_out(j,:) = straps_out1(1,:,j);
    end
    
    straps_out = straps_out(1:size(F,1),:);
    so(i).straps_out = straps_out;
end


% Plot strap forces
leg = [0 0 0]';

figure(15)
clf

hold on

for i = 1:6
    subplot(3,2,i)
    box on
    hold on
    plot(F2(1:end - a)*Pfac,(so(i).straps_out((1:end - a),ii(i).ii == 1) + pt(i))*Pfac,'b-')
    plot(F2(1:end - a)*Pfac,(so(i).straps_out((1:end - a),ii(i).ii == 2,:) + pt(i))*Pfac,'r-')
    
    
    
    if sum(ii(i).ii == 3) > 0
        plot(F2(1:end - a)*Pfac,(so(i).straps_out((1:end - a),ii(i).ii == 3,:) + pt(i))*Pfac,'g-')
    end
    
    % text([300000 300000 300000]',so(i).straps_out(ii(i).iend) + pt(i),{'1' '2' '3'}')
    
    xlabel('Total drag load (100,000 lbf)')
    ylabel('Strap load (lbf)')
    title(strap_set{i})
    
    xlim([0 1200])
%     ylim([-50 max(max(so(i).straps_out + pt(i)))*1.1]*Pfac)
    ylim([0 8])
%     xlim([0 1])
%     ylim([-10 150])
    
    if sum(ii(i).ii == 3) > 0
%         leg(1) = plot([0 0],[0 0],'b-');
%         leg(2) = plot([0 0],[0 0],'r-');
%         leg(3) = plot([0 0],[0 0],'g-');
%         legend(leg,'Bottom','Mid','Top','location','northwest')
    else
        leg(1) = plot([0 0],[0 0],'b-');
        leg(2) = plot([0 0],[0 0],'r-');
        % legend(leg(1:2),'Aft','Fore','location','northwest')
    end
end

drawnow

end
