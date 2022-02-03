function [F] = define_press2(C,r,alpha_cone,Rz,theta)
% Pressure distribution input deck
% User must create a line load structure for each torus.  Derived from
% pressure distribution


% Plotting
plotting = 0;

% % Total Z direction reaction
% Rz = 375; % 375000; % lbf

if plotting == 1
    theta = linspace(0,2*pi,100);
    figure(10)
    clf
    box on
    hold on
    axis equal
    for i = 2:size(C,1)
        plot(C(i,1) + r(i - 1)*cos(theta),C(i,2) + r(i - 1)*sin(theta),'k-')
    end
end

% Cone angle
alpha = 90 - alpha_cone;

% Unit pressure
p = 1; % External, normal pressure (psi)
load = [-p*sind(alpha)*ones(size(r)) p*cosd(alpha)*ones(size(r))];


% Calculate tributary width of each torus
trib = zeros(size(C,1) - 1,1);
for i = 1:size(trib,1)
    
    x0 = C(i + 1,1) + r(i)*sind(alpha); % Current tangent
    y0 = C(i + 1,2) - r(i)*cosd(alpha);
    
    if i == 1 % For the first torus
        xm = C(i,1) + r(i)*sind(alpha); % Tangent with previous torus
        ym = C(i,2) - r(i)*cosd(alpha);
        xp = C(i + 2,1) + r(i + 1)*sind(alpha); % Tangent with next torus
        yp = C(i + 2,2) - r(i + 1)*cosd(alpha);
        trib_m = sqrt((x0 - xm)^2 + (y0 - ym)^2);
        trib_p = sqrt((xp - x0)^2 + (yp - y0)^2)/2;
    elseif i == size(trib,1) % For the last torus
        xm = C(i,1) + r(i - 1)*sind(alpha); % Tangent with previous torus
        ym = C(i,2) - r(i - 1)*cosd(alpha);
        xp = C(i + 1,1) + r(i)*cosd(alpha) + r(i)*sind(alpha); % Tangent with next torus
        yp = C(i + 1,2) + r(i)*sind(alpha) - r(i)*cosd(alpha);
        trib_m = sqrt((x0 - xm)^2 + (y0 - ym)^2)/2;
        trib_p = sqrt((xp - x0)^2 + (yp - y0)^2);
    else % For all other tori
        xm = C(i,1) + r(i - 1)*sind(alpha); % Tangent with previous torus
        ym = C(i,2) - r(i - 1)*cosd(alpha);
        xp = (C(i + 2,1) + r(i + 1)*sind(alpha)); % Tangent with next torus
        yp = (C(i + 2,2) - r(i + 1)*cosd(alpha));
        trib_m = sqrt((x0 - xm)^2 + (y0 - ym)^2)/2;
        trib_p = sqrt((xp - x0)^2 + (yp - y0)^2)/2;
    end
    
    trib(i) = trib_m + trib_p;

    % Product of pressure and tributary width gives magnitude of line load
    % on torus
    load(i,:) = load(i,:)*trib(i);

    
    
    % Plotting
    if plotting == 1
        plot(xm,ym,'bo')
        plot(x0,y0,'ro')
        plot(xp,yp,'go')

        plot([C(i + 1,1) C(i + 1,1) + load(i,1)/Rz],[C(i + 1,2) C(i + 1,2) + load(i,2)/Rz],'r-')
    end
end

% Scale total load
lambda = Rz/sum(load(:,2)*2*pi.*C(2:end,1));
load = load*lambda;


%% LOADING
% % % Must modify code here in order to use a pressure distribution
% % %  other than a constant pressure load.  For example, pressure
% % %  distribution on a torus could be a Fourier summation or include 
% % %  point loads
C(1,:) = [];
F = zeros(size(theta,1)*6,6);
for i = 1:size(C,1)
    F(:,i) = press_dist2(load(i,:),theta,C(i,1)); % Linear symetrical pressure distribution
end
F = F(:);

lambda = Rz/sum(F(3:6:size(F,1)));








