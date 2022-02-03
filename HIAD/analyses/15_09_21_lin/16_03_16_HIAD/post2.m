function post2(FEM)

FEM_out = FEM;
theta = FEM_out.MODEL.theta_ind(1).ind;
% Post processing
% March 01, 2016

%%
% Get Z direction reactio force
RZ_ind = (3:6:size(FEM_out.OUT.Fext_inc,1))';
Ry = sum(FEM_out.OUT.Fext_inc(RZ_ind - 1,:))';
Rz = sum(FEM_out.OUT.Fext_inc(RZ_ind,:))';
Ryz = (Ry.^2 + Rz.^2).^.5;
Rd = Ryz*cosd(20.739);

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

% Plot load vertical displacement
figure(12)
clf
box on
hold on
% plot(U0,F,'g-')

if size(U90,1) == size(F,1)
    plot(U90,F,'ro-')
    plot(U270,F,'bo-')
end

xlim([0 25])
ylim([0 200000])

xlabel('Z disp (in)')
ylabel('Drag load (lbf)')

drawnow

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
    straps_out = zeros(size(FEM_out.OUT.fint_el,3),size(ind,1));
    straps_out1 = FEM_out.OUT.fint_el(dof,ind,:);

    for j = 1:size(FEM_out.OUT.fint_el,3)
        straps_out(j,:) = straps_out1(1,:,j);
    end
    
    straps_out = straps_out(1:size(F,1),:);
    so(i).straps_out = straps_out;
end


% Plot strap forces
leg = [0 0 0]';

figure(13)
clf

hold on

for i = 1:6
    subplot(3,2,i)
    box on
    hold on
    plot(F/100000,(so(i).straps_out(:,ii(i).ii == 1) + pt(i)),'bo-')
    plot(F/100000,(so(i).straps_out(:,ii(i).ii == 2,:) + pt(i)),'ro-')
    
    
    
    if sum(ii(i).ii == 3) > 0
        plot(F/100000,(so(i).straps_out(:,ii(i).ii == 3,:) + pt(i)),'go-')
    end
    
    % text([300000 300000 300000]',so(i).straps_out(ii(i).iend) + pt(i),{'1' '2' '3'}')
    
    xlabel('Total drag load (100,000 lbf)')
    ylabel('Strap load (lbf)')
    title(strap_set{i})
    
%     xlim([0 3.6])
%     ylim([-50 max(max(so(i).straps_out + pt(i)))*1.1])
    xlim([0 1])
    ylim([-10 150])
    
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
