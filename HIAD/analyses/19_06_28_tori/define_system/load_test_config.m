function [C,r] = load_test_config(d_alpha)
% Defines the 3.7 meter HIAD pressure tub test cross section

% % % alpha = 70 + d_alpha; % Cone angle
% % % R = 3.7/2; % HIAD radius
% % % R = R*1000/25.4;
% % % Rcb = 53.3; % Radius of centerbody

% L = R/sind(alpha) - Rcb/sind(alpha); % Length of TPS

r = [6.7
    6.7];

R = [74.4
    70.4];

C = [R(1) -r(1)*.93
    R(2) r(2)*.93];

% % % C1 = zeros(size(r,1),2);
% % % 
% % % overlap = [.8 .3]; % Torus overlap linearly tapers from a to b
% % % overlap_i = linspace(overlap(1),overlap(2),size(r,1))';
% % % 
% % % % Location of first torus
% % % C1(1,:) = [Rcb + r(1) (Rcb + r(1))/tand(alpha - d_alpha) + r(1)/sind(alpha - d_alpha)] - [overlap_i(1) overlap_i(1)*cosd(alpha - d_alpha)];
% % % 
% % % % Location of other tori
% % % for i = 2:size(r,1) - 1
% % %     Li = r(i - 1) + r(i) - overlap_i(i);
% % %     C1(i,:) = C1(i - 1,:) + [Li*cosd(90 - alpha) Li*sind(90 - alpha)];
% % % end

% % % % Location of shoulder torus
% % % th = -30.897;
% % % Li = r(end - 1) + r(end) - overlap_i(end);
% % % alpha0 = 90 - alpha;
% % % 
% % % % x = C1(end - 1,1);
% % % % y = C1(end - 1,2);
% % % % x1 = x + Li*cosd(th)
% % % % y1 = y + Li*sind(th)
% % % % y11 = tand(alpha0)*x1
% % % 
% % % % f = @(th) y + Li*sind(th) - tand(alpha0)*(x + Li*cosd(th));
% % % % fminsearch(@(th) f(th),[-20 -40])
% % % 
% % % % a = Li*sind(th) - Li*cosd(th)*tand(alpha0)
% % % % b = tand(alpha0)*x + r(end)*sind(alpha0)*tand(alpha0) - y + r(end)*cosd(alpha0)
% % % 
% % % C1(end,:) = C1(end - 1,:) + [Li*cosd(alpha0 + th) Li*sind(alpha0 + th)];
% % % 
% % % % % Check HIAD radius
% % % % Lout = (C1(end,1) + r(end))*25.4/1000*2;

% % % % Include tieback location
% % % C = [C1];


%% Plot
theta = linspace(0,2*pi,100)';
plotting = 1;

SI = 1; % 25.4;

if plotting == 1
    figure(100)
    clf
    box on
    hold on
    axis equal

    
    
    
    
    for i = 1:size(C,1)
        plot(C(i,1),C(i,2),'bx') % Torus centers
        plot((r(i)*cos(theta) + C(i,1))*SI,(r(i)*sin(theta) + C(i,2))*SI,'k-') % Torus cross sections
        
        text((C(i,1) + .5),(C(i,2) + 2),strcat('T',num2str(i)))
    end

    
    xlim([0 (C(end,1) + r(end))*1.1])
    ylim([(C(end,2) + r(end - 1))*-1.1 (C(end,2) + r(end - 1))*1.1])
    
    xlabel('R Location (in)')
    ylabel('Z Location (in)')
end
end

