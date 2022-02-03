function [load] = define_press(C,r,alpha_cone,Rz,tor)
% Pressure distribution input deck
% User must create a line load structure for each torus.  Derived from
% pressure distribution


% Account for tori that are not loaded
load_tor = zeros(size(tor));
for i = 1:size(load_tor,1)
    load_tor(i) = tor(i).load;
end
r = r(logical(load_tor));
C = C([true; logical(load_tor)],:);


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
    for i = 2:size(C,1);
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


% Account for tori that are not loaded
load0 = zeros(size(load_tor,1),2);
load0(logical(load_tor),:) = load;
load = load0;


end

