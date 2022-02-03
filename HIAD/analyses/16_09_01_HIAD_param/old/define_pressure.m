function [load] = define_pressure(tor)
% Pressure distribution input deck
% User must create a line load structure for each torus.  Derived from
% pressure distribution

r = [tor.r]';

% Unit pressure
p = 1; % External, normal pressure (psi)

% Total Z direction reaction
Rz = 375000; % lbf 
load = zeros(size(r,1),2);

%% Calculate tributary width of each torus
C0 = [tor(:).C]';
C = [C0(1:2:end) C0(2:2:end)];
C(~[tor(:).load]) = []; % Remove non loaded torus
r(~[tor(:).load]) = []; % Remove non loaded torus
trib = zeros(size(C,1) - 1,2); % Preallocate

for i = 1:size(r,1)
    
    
    if i == 1 % For the first torus
        Tright = sirkl_tan([C(i,:) C(i+1,:)],[r(i) r(i+1)], 0); % Right side of the torus external tangents
        thetaR = atan((Tright(2,2)-Tright(1,2))/(Tright(2,1)-Tright(1,1))); % Find the right side angle
        tor_Ldist = r(i); % Left half distance of the torus
        tor_Rdist = r(i)*pdist(Tright, 'euclidean')/(r(i)+r(i+1)); % Right half distance
        trib(i,1) = tor_Ldist + tor_Rdist; % Set tributary width
        trib(i,2) = thetaR; % Set tributary angle
    elseif i == size(r,1)-1 % For the second to last torus (The shoulder torus overlaps more than other tori
        Tleft = sirkl_tan([C(i-1,:) C(i,:)],[r(i-1) r(i)],0); % Left side of the torus external tangents
        Tright = sirkl_tan([C(i,:) C(i+1,:)],[r(i) r(i+1)],0); % Right side of the torus external tangents
        thetaL = atan((Tleft(2,2)-Tleft(1,2))/(Tleft(2,1)-Tleft(1,1))); % Left side angle
        thetaR = atan((Tright(2,2)-Tright(1,2))/(Tright(2,1)-Tright(1,1))); % Right side anagle
        thetaAvg = (thetaL+thetaR)/2; % Average angle used for determining pressure direction on torus
        torus_extra = pdist([Tleft(2,:);Tright(1,:)], 'euclidean'); % Space between left and right external tangent point
        tor_Ldist = r(i)*pdist(Tleft,'euclidean')/(r(i)+r(i-1)); % Left half distance
        tor_Rdist = pdist(Tright,'euclidean')-r(i+1); % Right half distance
        trib(i,1) = tor_Ldist + tor_Rdist + torus_extra; % Tributary width
        trib(i,2) = thetaAvg; % Tributary angle
    elseif i == size(r,1) % Shoulder torus
        Tleft = sirkl_tan([C(i-1,:) C(i,:)],[r(i-1) r(i)],0); % Left side external tangents
        thetaL = atan((Tleft(2,2)-Tleft(1,2))/(Tleft(2,1)-Tleft(1,1))); % Left angle
        trib(i,1) = 2*r(i); % Tributary width
        trib(i,2) = thetaL; % Tributary angle
    else % For all other tori
        Tleft = sirkl_tan([C(i-1,:) C(i,:)],[r(i-1) r(i)],0); % Left side external tangents
        Tright = sirkl_tan([C(i,:) C(i+1,:)],[r(i) r(i+1)],0); % Right side external tangents
        thetaL = atan((Tleft(2,2)-Tleft(1,2))/(Tleft(2,1)-Tleft(1,1))); % Left angle
        thetaR = atan((Tright(2,2)-Tright(1,2))/(Tright(2,1)-Tright(1,1))); % Right anagle
        thetaAvg = (thetaL+thetaR)/2; % Average angle used for determining pressure direction on torus
        torus_extra = pdist([Tleft(2,:);Tright(1,:)], 'euclidean'); % Space between external tangent point
        tor_Ldist = r(i)*pdist(Tleft,'euclidean')/(r(i)+r(i-1)); % Left half of the torus distance (external tangents scaled by radii)
        tor_Rdist = r(i)*pdist(Tright, 'euclidean')/(r(i)+r(i+1)); % Right half of the torus distance (external tangents scaled by radii)
        trib(i,1) = tor_Ldist + tor_Rdist + torus_extra; % Tributary width
        trib(i,2) = thetaAvg; % Tributary angle
    end
  
    
end


%% Apply loading
area = zeros(size(r,1),1); % Preallocate
for i = 1:size(r,1)
    rp = C(i,:)+trib(i,1)*[cos(trib(i,2)) sin(trib(i,2))]/2; % Right point of each torus
    lp = C(i,:)-trib(i,1)*[cos(trib(i,2)) sin(trib(i,2))]/2; % Left point of each torus
    m = (rp(1)-lp(1))/(rp(2)-lp(2)); % Slope of of each tributary width
    b = rp(1)-m*rp(2); % Intercept
    fun = @(y) pi*(m*y+b)*sqrt(1+m^2)*2; % Function to integrate to find surface area
    area(i) = integral(fun,lp(2),rp(2)); % Total area the pressure is applied to on each torus
end
ftor =  p*area;% Normal force on each torus
Fz = sum(ftor./cos(trib(:,2))); % Total normal z force
w = p*trib(:,1); % Unit line loading
load([tor(:).load],1) = w*(Rz/Fz); % Scaled line loading
load(:,2) = trib(:,2)*180/pi; % Tributary angle degrees


figure(15)
hold on
for i = 1:size(load,1)
    plot([C(i,1) C(i,1) + load(i,1)],[C(i,2) C(i,2) + load(i,2)],'r-')
end

end





