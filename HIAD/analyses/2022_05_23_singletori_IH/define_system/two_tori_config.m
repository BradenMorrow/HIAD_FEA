function [C,r_minor] = two_tori_config(r_major,r_minor,alpha_cone)
% Defines two-tori 

C = zeros(size(r_minor,1),2);

overlap = .8; % Torus overlap

% Location of first torus
C(1,:) = [r_major + r_minor(1) (r_major + r_minor(1))/tand(alpha_cone) + r_minor(1)/sind(alpha_cone)] - [overlap overlap*cosd(alpha_cone)];
% Location of the second torus
Li = r_minor(1) + r_minor(2) - overlap;
C(2,:) = C(1,:) + [Li*cosd(90 - alpha_cone) Li*sind(90 - alpha_cone)];

%% Plot
R = 3.7/2; % HIAD radius
R = R*1000/25.4;
theta = linspace(0,2*pi,100)';
plotting = 1;

SI = 1; % 25.4;

if plotting == 1
    figure(100)
    clf
    box on
    hold on
    axis equal
%     axis off

    for i = 1:size(C,1)
        plot(C(i,1)*SI,C(i,2)*SI,'bx') % Torus centers
        plot((r_minor(i)*cos(theta) + C(i,1))*SI,(r_minor(i)*sin(theta) + C(i,2))*SI,'k-') % Torus cross sections
        
        text((C(i,1) + .5)*SI,(C(i,2) + 2)*SI,strcat('T',num2str(i)))
    end

    plot([0 R*1.25*cosd(90 - alpha_cone)]*SI,[0 R*1.25*sind(90 - alpha_cone)]*SI,'k-') % HIAD fore side

    xlim([0 (C(end,1) + r_minor(end))*1.1]*SI)
    ylim([0 (C(end,2) + r_minor(end - 1))*1.1]*SI)
    
    xlabel('R Location (in)')
    ylabel('Z Location (in)')
end
end



