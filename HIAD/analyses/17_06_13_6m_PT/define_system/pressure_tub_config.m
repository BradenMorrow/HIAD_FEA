function [C,r] = pressure_tub_config
% Defines the 3.7 meter HIAD pressure tub test cross section

alpha = 60; % Cone angle
R = 6/2; % HIAD radius
R = R*1000/25.4;
Rcb = 32.095; % Radius of centerbody

L = R/sind(alpha) - Rcb/sind(alpha); % Length of TPS

r = [13.6
    13.6
    13.6
    13.6
    13.6
    13.6
    13.6
    8]/2;

C1 = zeros(size(r,1),2);

overlap = [1.2 .455]; % Torus overlap linearly tapers from a to b
overlap_i = linspace(overlap(1),overlap(2),size(r,1))';


% Location of first torus
C1(1,:) = [Rcb + r(1) (Rcb + r(1))/tand(alpha) + r(1)/sind(alpha)] - [overlap_i(1) overlap_i(1)*cosd(alpha)];


% Location of other tori
for i = 2:size(r,1) - 1
    Li = r(i - 1) + r(i) - overlap_i(i);
    C1(i,:) = C1(i - 1,:) + [Li*cosd(90 - alpha) Li*sind(90 - alpha)];
end


% Location of shoulder torus
th = -16;
Li = r(end - 1) + r(end) - overlap_i(end);
alpha0 = 90 - alpha;

C1(end,:) = C1(end - 1,:) + [Li*cosd(alpha0 + th) Li*sind(alpha0 + th)];


% Location of tri-torus
Rt = C1(5,1);
Zt = C1(5,2) + r(5)*2 - .3;
C1 = [C1(1:5,:)
    Rt Zt
    C1(6:end,:)];
r = [r(1:5)
    13.6/2
    r(6:end)];

% % Check HIAD radius
% Lout = (C1(end,1) + r(end))*25.4/1000*2;

% Include tieback location
C = [Rcb C1(1,2);
    C1];


%% Plot
theta = linspace(0,2*pi,100)';
plotting = 1;

SI = 1; % 25.4; % 

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

    plot([0 R*1.25*cosd(90 - alpha)]*SI,[0 R*1.25*sind(90 - alpha)]*SI,'r-') % HIAD fore side
    plot([Rcb Rcb]*SI,[Rcb*cosd(alpha) (C1(1,2) + r(1))*1.5]*SI,'k--') % Centerbody location
    text((Rcb + 1)*SI,(C1(1,2) + r(1))*1.5*SI,'Center-body')
    
    plot([R R]*SI,[50 80]*SI,'k--')
    text((R - 19)*SI,(C1(1,2) + r(1))*1.5*SI,'Aeroshell edge')

    xlim([0 (C1(end,1) + r(end))*1.1]*SI)
    ylim([0 (C1(end,2) + r(end - 1))*1.1]*SI)
    
    if SI == 1
        xlabel('R Location (in)')
        ylabel('Z Location (in)')
    else
        xlabel('R Location (mm)')
        ylabel('Z Location (mm)')
    end
end
end

