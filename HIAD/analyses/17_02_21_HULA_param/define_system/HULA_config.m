function [C,r] = pressure_tub_config
% Defines the 3.7 meter HIAD pressure tub test cross section

alpha = 70; % Cone angle
R = 6/2; % HIAD radius
R = R*1000/25.4;
Rcb = 1.24/2*1000/25.4; % Radius of centerbody

L = R/sind(alpha) - Rcb/sind(alpha); % Length of TPS

r = [15.2 % Scaled from drawing
    15.25
    15.3
    15.35
    15.4
    15.45
    6.5]/2;

C1 = zeros(size(r,1),2);

overlap = [.2 .05]; % Torus overlap linearly tapers from a to b
overlap_i = linspace(overlap(1),overlap(2),size(r,1))';

% Location of first torus
C1(1,:) = [Rcb + r(1) (Rcb + r(1))/tand(alpha) + r(1)/sind(alpha)] - [overlap_i(1) overlap_i(1)*cosd(alpha)];

% Location of other tori
for i = 2:size(r,1) - 1
    Li = r(i - 1) + r(i) - overlap_i(i);
    C1(i,:) = C1(i - 1,:) + [Li*cosd(90 - alpha) Li*sind(90 - alpha)];
end

% Location of shoulder torus
th = -23; % -30.897;
Li = r(end - 1) + r(end) - overlap_i(end);
alpha0 = 90 - alpha;

% x = C1(end - 1,1);
% y = C1(end - 1,2);
% x1 = x + Li*cosd(th)
% y1 = y + Li*sind(th)
% y11 = tand(alpha0)*x1

% f = @(th) y + Li*sind(th) - tand(alpha0)*(x + Li*cosd(th));
% fminsearch(@(th) f(th),[-20 -40])

% a = Li*sind(th) - Li*cosd(th)*tand(alpha0)
% b = tand(alpha0)*x + r(end)*sind(alpha0)*tand(alpha0) - y + r(end)*cosd(alpha0)

C1(end,:) = C1(end - 1,:) + [Li*cosd(alpha0 + th) Li*sind(alpha0 + th)];

% % Check HIAD radius
% Lout = (C1(end,1) + r(end))*25.4/1000*2;

% Include tieback location
C = [Rcb C1(1,2);
    C1];


%% Plot
plotting = 0;

if plotting == 1
    theta = linspace(0,2*pi,100)';
    SI = 1; % 25.4/1000;
    
    figure(100)
    clf
    box on
    hold on
    axis equal
%     axis off

    for i = 1:size(C1,1)
        plot(C1(i,1)*SI,C1(i,2)*SI,'k.','markersize',1) % Torus centers
        plot(r(i)*SI*cos(theta) + C1(i,1)*SI,r(i)*SI*sin(theta) + C1(i,2)*SI,'k-') % Torus cross sections
    end

    plot([0 R*1.05*cosd(90 - alpha)]*SI,[0 R*1.05*sind(90 - alpha)]*SI,'k-') % HIAD fore side
    plot([Rcb Rcb]*SI,[Rcb*cosd(alpha) (C1(1,2) + r(1))*1.5]*SI,'k-','linewidth',1) % Centerbody location
    
    % Mirror
    for i = 1:size(C1,1)
        plot(-C1(i,1)*SI,C1(i,2)*SI,'k.','markersize',1) % Torus centers
        plot(-r(i)*SI*cos(theta) - C1(i,1)*SI,r(i)*SI*sin(theta) + C1(i,2)*SI,'k-') % Torus cross sections
    end

    plot(-[0 R*1.05*cosd(90 - alpha)]*SI,[0 R*1.05*sind(90 - alpha)]*SI,'k-') % HIAD fore side
    plot(-[Rcb Rcb]*SI,[Rcb*cosd(alpha) (C1(1,2) + r(1))*1.5]*SI,'k-','linewidth',1) % Centerbody location

    
% % %     xlim([0 (C1(end,1) + r(end))*1.1]*SI)
% % %     ylim([0 (C1(end,2) + r(end - 1))*1.1]*SI)
% % %     xlabel('Meters')
% % %     ylabel('Meters')
end
end

