function [d] = cord_model_18MAY15(eps,F,load_point,unload_point,d_LOAD,d_UNLOAD)
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

i_mark = [];
for i = 2:size(d_load,1)
    if d_load(i,2) == d_load(i - 1,2)
        i_mark = i;
    end
end
d_load(i_mark,:) = [];

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

if isempty(d_unload) == 0
    if d_unload(end,1) == d_load(1,1) || d_unload(end,2) == d_load(1,2)
        d_unload(end,:) = [];
    end
end

%% Output
% Construct force-strain lookup table
d = [d_comp
    d_unload
    d_load
    d_load2];

% % % % Construct stiffness-strain lookup table
% % % stiff = (d(2:end,1) - d(1:end - 1,1))./(d(2:end,2) - d(1:end - 1,2));
% % % d1_back = [[stiff(1); stiff] d(:,2)];
% % % d1_forward = [[stiff; stiff(end)] d(:,2)];
% % % 
% % % d1_eps_plus = [interp1(d1_forward(:,2),d1_forward(:,1),eps + 1e-15) eps + 1e-15];
% % % 
% % % d1 = [d1_back(d1_back(:,2) <= eps,:); d1_eps_plus; d1_forward(d1_forward(:,2) > eps,:)];
% % % stiff2 = [d1_back(:,1) d1_forward];



% % % figure(500)
% % % clf
% % % box on
% % % hold on
% % % plot(d(:,2),d(:,1),'bx-')
% % % 
% % % xlim([0 .03])
% % % ylim([-50 3000])

end

