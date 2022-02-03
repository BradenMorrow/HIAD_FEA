function [F_out] = press_dist_nonaxi(theta,F)

%% Obtain Pressure Distribution
% Load input
d = load('p_unscaled_01MAR16');
X = d(:,2);
Y = d(:,3);
Z = d(:,1) + 10 - min(d(:,1));
P = d(:,4);
XYZP = [X Y Z P];

% HIAD geometry
% Centers of tori (x,z)
C = [185.185453 84.342298
	213.724769 94.729760
	242.558759 105.224474
	271.650278 115.812921
	300.963157 126.481936
	322.382105 124.113612];

% Minor radii of tori
r = [31.837/2
    31.837/2
    31.837/2
    31.837/2
    31.837/2
    12.735/2];

% TPS tangents on tori (x,z)
xi = C(:,1) + r*sind(20);
zi = C(:,2) - r*cosd(20);

% Theta vector
theta_p = linspace(0,2*pi,21)';
% theta(end) = [];

% Preallocate pressure matrix
p_tor = zeros(size(theta_p,1),size(C,1));
tol = [3 3 3 3 3 2]';

% Get the pressure distributions on the tori
for i = 1:size(C,1) % Loop through tori
    for j = 1:size(theta_p,1) % Loop through angles
        % Location of point
        xyz = [xi(i)*cos(theta_p(j)) xi(i)*sin(theta_p(j)) zi(i)]';
        
        % Get pressure
        p_tor(j,i) = get_p(XYZP,xyz,tol(i));
    end
end

% Modify for loading without tab
p_tor(6,5:6) = [mean([p_tor(5,5) p_tor(7,5)]) mean([p_tor(5,6) p_tor(7,6)])];


%% Fourier Expansion
% Preallocate
P_out = zeros(size(theta,1),size(C,1));
n = 4; % Approximate loading with n waves

% Obtain nodal pressures
for i = 1:size(C,1) % Loop through tori
    P_out(:,i) = fourier_expansion(theta_p,p_tor(:,i),n,theta);
end

% Normalize
P_out = P_out/max(max(P_out));




%% Tori Forces
% Reorganize force vector
ind = 1:6:size(F,1);
ind = [ind ind + 1 ind + 2 ind + 3 ind + 4 ind + 5]';
F2 = zeros(length(F)/6,6);
F2(:) = F(ind);

% Unit normals, initial force directions
F2 = normr(F2);

% Magnitude and direction of forces
trib = r*2;
tribi = zeros(size(theta,1),6);
for i = 1:size(theta,1)
    tribi(i,:) = trib';
end

F3 = zeros(size(F2));
for i = 1:size(F2,1)
    F3(i,:) = F2(i,:).*P_out(i)*tribi(i);
end

% Transpose and normalize forces
F3 = F3'/max(max(F3));

% Normalized FE forces
F_out = F3(:);



% F3 = F2/max(max(F2));
% F3 = normr(F2);

% % % %% Plotting
% % % % Plot pressure on tori
% % % figure(11)
% % % clf
% % % box on
% % % hold on
% % % 
% % % % Plot interpolations
% % % plot(theta_p*180/pi,p_tor(:,1),'b-')
% % % plot(theta_p*180/pi,p_tor(:,2),'g-')
% % % plot(theta_p*180/pi,p_tor(:,3),'r-')
% % % plot(theta_p*180/pi,p_tor(:,4),'c-')
% % % plot(theta_p*180/pi,p_tor(:,5),'m-')
% % % plot(theta_p*180/pi,p_tor(:,6),'y-')
% % % 
% % % % Plot Fourier expansion
% % % plot(theta*180/pi,P_out(:,1),'k--')
% % % plot(theta*180/pi,P_out(:,2),'k--')
% % % plot(theta*180/pi,P_out(:,3),'k--')
% % % plot(theta*180/pi,P_out(:,4),'k--')
% % % plot(theta*180/pi,P_out(:,5),'k--')
% % % plot(theta*180/pi,P_out(:,6),'k--')
% % % 
% % % xlim([0 360])
% % % xlabel('\theta (deg)')
% % % ylabel('Pressure (psi)')
% % % 
% % % % text(365,p_tor(end,1) + .001*4,'T1')
% % % % text(365,p_tor(end,2) + .0005*4,'T2')
% % % text(365,p_tor(end,1),'T1')
% % % text(365,p_tor(end,2) - .001,'T2')
% % % text(365,p_tor(end,3),'T3')
% % % text(365,p_tor(end,4),'T4')
% % % text(365,p_tor(end,5),'T5')
% % % text(365,p_tor(end,6),'T6')
% % % 
% % % 
% % % 
% % % %%
% % % figure(10)
% % % clf
% % % box off
% % % axis off
% % % axis equal
% % % hold on
% % % 
% % % % xlim([min(X) max(X)])
% % % % ylim([min(Y) max(Y)])
% % % % zlim([min(Z) max(Z)])
% % % 
% % % % plot3(x,y,z,'ko')
% % % ind = Z < 125;
% % % ind1 = Z > 120 & Z < 145 & X > -70 & X < 70 & Y > 0;
% % % scatter3(X(ind),Y(ind),-Z(ind),[],P(ind),'filled')
% % % scatter3(X(ind1),Y(ind1),-Z(ind1),[],P(ind1),'filled')
% % % 
% % % plot3(xi(1)*cos(theta),xi(1)*sin(theta),-zi(1)*ones(size(theta)) + 10,'k-','linewidth',1.5)
% % % plot3(xi(2)*cos(theta),xi(2)*sin(theta),-zi(2)*ones(size(theta)) + 10,'k-','linewidth',1.5)
% % % plot3(xi(3)*cos(theta),xi(3)*sin(theta),-zi(3)*ones(size(theta)) + 10,'k-','linewidth',1.5)
% % % plot3(xi(4)*cos(theta),xi(4)*sin(theta),-zi(4)*ones(size(theta)) + 10,'k-','linewidth',1.5)
% % % plot3(xi(5)*cos(theta),xi(5)*sin(theta),-zi(5)*ones(size(theta)) + 10,'k-','linewidth',1.5)
% % % plot3(xi(6)*cos(theta),xi(6)*sin(theta),-zi(6)*ones(size(theta)) + 10,'k-','linewidth',1.5)
% % % 
% % % colorbar
% % % colormap('jet')
% % % 
% % % view(2)

end
































