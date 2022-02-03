function [d,d1] = cord_model_14MAY15(eps,F,load_point,unload_point,d_LOAD,d_UNLOAD)
%CORD_MODEL_06MAY15
%   Cord hysteresis model

% d_LOAD = load('d_load.txt');
% d_UNLOAD = load('d_unload.txt');

%% Build cord lookup table
%% Compression portion
d_comp = [-30000 -100];


%% Loading portion
% Above current loading point, below unloading points
d_load = zeros(size(unload_point,1),2);
d_load(1,:) = [F eps];
ind = 2;
for i = size(unload_point,1):-1:2
    d_load(ind,:) = unload_point(i,:);
    ind = ind + 1;
end
if size(d_load,1) > 1 && d_load(end,2) == d_load(end - 1,2)
    d_load(end,:) = [];
end

% Above all unloading points
d_load2 = d_LOAD(d_LOAD(:,2) > max([unload_point(:,2); eps]),:);


%% Unloading portion
% Load and scale unloading curve
pivots1 = size(load_point,1);
% pivots2 = size(unload_point,1);
% if eps > 0 % pivots2 == pivots1
    unload_point = [unload_point
        F eps];
% end

% Below first loading point
d_unload = [0 0];
for i = 1:pivots1
    % Above last loading point
    f2 = d_UNLOAD(d_UNLOAD(:,1) >= load_point(i,1),1);
    f2 = f2 - f2(1);
    f2 = f2/f2(end);
    try
        f2 = f2*(unload_point(i + 1,1) - load_point(i,1));
        f2 = f2 + (unload_point(i + 1,1) - f2(end));
    catch
        a = 1;
    end
    
    
    eps2 = d_UNLOAD(d_UNLOAD(:,1) >= load_point(i,1),2);
    eps2 = eps2 - eps2(1); 
    eps2 = eps2/eps2(end);
    eps2 = eps2*(unload_point(i + 1,2) - load_point(i,2));
    eps2 = eps2 + unload_point(i + 1,2) - eps2(end);
    
    d_unload = [d_unload(d_unload(:,2) < eps2(1),:); f2 eps2];
end

d_unload = d_unload(d_unload(:,2) < eps,:);
d_unload(d_unload(:,2) < 0,:) = [];

try
    if d_unload(end,1) == d_load(1,1) || d_unload(end,2) == d_load(1,2)
        d_unload(end,:) = [];
    end
catch
    a = 1;
    d_unload = [0 0];
end

%% Output
% Construct force-strain lookup table
d = [d_comp
    d_unload
    d_load
    d_load2];

% Construct stiffness-strain lookup table
stiff = (d(2:end,1) - d(1:end - 1,1))./(d(2:end,2) - d(1:end - 1,2));
d1 = [[stiff(1); stiff] d(:,2)];

if d(49,1) == d(50,1)
    a = 1;
end

% % % f = interp1(d(:,2),d(:,1),eps);
% % % f1 = interp1(d(:,2),d(:,1),eps + tol);
% % % k = (f1 - f)/tol;

% figure(500)
% clf
% box on
% hold on
% plot(d(:,2),d(:,1),'bx-')
% 
% xlim([0 .03])
%     ylim([-50 3000])

end

