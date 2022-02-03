function [load] = define_pressure(C,r,alpha_cone)
% Pressure distribution input deck
% User must create a line load structure for each torus.  Derived from
% pressure distribution


alpha = 90 - alpha_cone;

% Unit pressure
p = 1; % External, normal pressure (psi)

% Total Z direction reaction
Rz = 375000; % lbf

% Calculate tributary width of each torus
trib = zeros(size(C,1) - 1,1);
for i = 1:size(trib,1)
    
    
    x0 = C(i + 1,1) + r(i)*sind(alpha);
    y0 = C(i + 1,2) - r(i)*cosd(alpha);
    
    if i == 1 % For the first torus
        xm = C(i,1) + r(i)*sind(alpha);
        ym = C(i,2) - r(i)*cosd(alpha);
        xp = C(i + 2,1) + r(i + 1)*sind(alpha);
        yp = C(i + 2,2) - r(i + 1)*cosd(alpha);
    elseif i == size(trib,1) % For the last torus
        xm = C(i,1) + r(i - 1)*sind(alpha);
        ym = C(i,2) - r(i - 1)*cosd(alpha);
        xp = C(i + 2,1) + r(i + 1)*sind(alpha);
        yp = C(i + 2,2) - r(i + 1)*cosd(alpha);
    else % For all other tori
        xm = C(i,1) + r(i - 1)*sind(alpha);
        ym = C(i,2) - r(i - 1)*cosd(alpha);
        xp = (C(i + 2,1) + r(i)*sind(alpha)) + r(i)*cosd(alpha);
        yp = (C(i + 2,2) - r(i)*cosd(alpha)) + r(i)*sind(alpha);
    end
    
    trib(i) = sqrt((C(torID,1) - C(torID - 1,1))^2 + (C(torID,2) - C(torID - 1,2))^2)/2 + sqrt((C(torID + 1,1) - C(torID,1))^2 + (C(torID + 1,2) - C(torID,2))^2)/2;





end

