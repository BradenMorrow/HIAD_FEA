function [f,k] = cord_model_13MAY15(eps,eps_rate,load_point,unload_point,tol)
%CORD_MODEL_06MAY15
%   Cord hysteresis model

d1 = load('d_load.txt');
d2 = load('d_unload.txt');

%% If cord is in compression
if eps <= 0
    d = [0 0];
    p_lin = 300;
    eps_end = -.1;
end

%% If cord is loading on original loading path
if eps > 0 && eps_rate >= 0 && eps >= load_point(end,2) && eps >= max(unload_point(:,2))
    d = d1;
    p_lin = polyfit(d(end - 10:end,2),d(end - 10:end,1),1); % Linear above maximum load
    eps_end = .1;
end

%% If cord is unloading, between unloading and loading points
% Scale unloading curve
if eps > 0 && eps_rate <= 0 && eps >= load_point(end,2)
    % Above last loading point
    f2 = d2(d2(:,1) >= load_point(end,1),1);
    f2 = f2/f2(end);
    f2 = f2*(unload_point(end,1) - load_point(end,1));
%     f2 = f2 + load_point(end,1) - f2(1);
    f2 = f2 + (unload_point(end,1) - f2(end));
    
    eps2 = d2(d2(:,1) >= load_point(end,1),2);
    eps2 = eps2 - eps2(1); 
    eps2 = eps2/eps2(end);
    eps2 = eps2*(unload_point(end,2) - load_point(end,2));
    eps2 = eps2 + load_point(end,2) - eps2(1);
    
    d = [f2 eps2];
    
    p_lin = polyfit(d(end - 10:end,2),d(end - 10:end,1),1); % Linear above maximum load
    eps_end = .1;
end

%% If cord is unloading, between unloading and loading points
% Scale unloading curve
if eps > 0 && eps_rate <= 0 && eps < load_point(end,2)
    % Load and scale unloading curve
    % Below last loading point
    f2 = d2(d2(:,1) < load_point(end,1),1);
    f2 = f2/f2(end);
    f2 = f2*load_point(end,1);
    
    eps2 = d2(d2(:,1) < load_point(end,1),2);
    eps2 = eps2/eps2(end);
    eps2 = eps2*load_point(end,2);
    
    d = [f2 eps2];
    
    p_lin = polyfit(d(end - 10:end,2),d(end - 10:end,1),1); % Linear above maximum load
    eps_end = .1;
end
    

%% If cord is loading after cycling
if eps > 0 && eps_rate > 0 && sum(eps > load_point(:,2)) && sum(eps < unload_point(:,2))
    % Below loading point
    d_one = d2(d2(:,1) <= load_point(end,1),:);
    if d_one(end,2) ~= 0
        d_one = [d_one(:,1)*load_point(end,1)/d_one(end,1) d_one(:,2)*load_point(end,2)/d_one(end,2)];
    end
    
    % Above loading point, below unloading point
    d_two = zeros(size(unload_point,1) - 1,2);
%     d_two(1,:) = load_point(end,:);
    for i = 1:size(unload_point,1) - 1
        d_two(i,:) = unload_point(end - (i - 1),:);
    end
            
    
%     d_two = [load_point(end,:)
%         unload_point(end,:)];
%     d_two(1,:) = [];

%     % Above unloading point
%     d_three = d1(d1(:,2) > unload_point(end,2),:);
%     d_three = [d_three(:,1) d_three(:,2) + unload_point(end,2)];
    
    d = [d_one
        d_two];
%         d_three];
    
    p_lin = polyfit(d1(end - 10:end,2),d1(end - 10:end,1),1); % Linear above maximum load
    eps_end = .1;
end

%% Linear after peak load
try
    F_end = p_lin(1)*eps_end;
catch
    a = 1;
end

d = [[d(:,1); F_end + d(end,1)] [d(:,2); eps_end + d(end,2)]];

f = interp1(d(:,2),d(:,1),eps);
f1 = interp1(d(:,2),d(:,1),eps + tol);
k = (f1 - f)/tol;

end











