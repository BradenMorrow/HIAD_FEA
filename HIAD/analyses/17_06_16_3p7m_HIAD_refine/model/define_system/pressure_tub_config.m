function [C,r] = pressure_tub_config
% Defines the 3.7 meter HIAD pressure tub test cross section

alpha = 70; % Cone angle
R = 3.7/2; % HIAD radius
R = R*1000/25.4;
Rcb = 8; % Radius of centerbody

L = R/sind(alpha) - Rcb/sind(alpha); % Length of TPS

r = [9.9 % Scaled from drawing
    9.9
    9.9
    9.9
    9.9
    9.9
    9.9
    3.5]/2;

C1 = zeros(size(r,1),2);

overlap = [.8 .3]; % Torus overlap linearly tapers from a to b
overlap_i = linspace(overlap(1),overlap(2),size(r,1))';

% Location of first torus
C1(1,:) = [Rcb + r(1) (Rcb + r(1))/tand(alpha) + r(1)/sind(alpha)] - [overlap_i(1) overlap_i(1)*cosd(alpha)];

% Location of other tori
for i = 2:size(r,1) - 1
    Li = r(i - 1) + r(i) - overlap_i(i);
    C1(i,:) = C1(i - 1,:) + [Li*cosd(90 - alpha) Li*sind(90 - alpha)];
end

% Location of shoulder torus
th = -30.897;
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
theta = linspace(0,2*pi,100)';
plotting = 1;

SI = 25.4;

if plotting == 1
    figure(100)
    clf
    box on
    hold on
    axis equal
%     axis off

    for i = 1:size(C1,1)
        plot(C1(i,1)*SI,C1(i,2)*SI,'bx') % Torus centers
        plot((r(i)*cos(theta) + C1(i,1))*SI,(r(i)*sin(theta) + C1(i,2))*SI,'k-') % Torus cross sections
        
        text((C1(i,1) + .5)*SI,(C1(i,2) + 2)*SI,strcat('T',num2str(i)))
    end

    plot([0 R*1.25*cosd(90 - alpha)]*SI,[0 R*1.25*sind(90 - alpha)]*SI,'k-') % HIAD fore side
    plot([Rcb Rcb]*SI,[Rcb*cosd(alpha) (C1(1,2) + r(1))*1.5]*SI,'k--') % Centerbody location
    text((Rcb + 1)*SI,(C1(1,2) + r(1))*1.5*SI,'Center-body')
    
    xlim([0 (C1(end,1) + r(end))*1.1]*SI)
    ylim([0 (C1(end,2) + r(end - 1))*1.1]*SI)
    
    xlabel('R Location (mm)')
    ylabel('Z Location (mm)')
end
end

