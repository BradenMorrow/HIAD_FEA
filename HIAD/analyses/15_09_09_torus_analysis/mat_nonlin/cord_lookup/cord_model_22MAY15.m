function [d] = cord_model_22MAY15(eps,F,load_point,unload_point,d_LOAD,d_UNLOAD,eps_rate)
%CORD_MODEL_06MAY15
%   Cord hysteresis model

% d_LOAD = load('d_load.txt');
% d_UNLOAD = load('d_unload.txt');

%% Build cord lookup table
%% Compression portion
d_comp = [-30000 -100];


%% Above all unloading points
d_orig = d_LOAD(d_LOAD(:,2) > max([unload_point(:,2); eps]),:);


%% Loading portion
% Sort loading points, unloading points and current location
pivots = [unload_point; load_point];
pivots = [pivots; [F eps]];
[~,I] = sort(pivots(:,2));
pivots = pivots(I,:);


% Remove zero or negative entries (if in compression)
pivots(1:2,:) = [];

while sum(pivots(2:end,1) - pivots(1:end - 1,1) < 0) > 0
    pivots([pivots(2:end,1) - pivots(1:end - 1,1) < 0; false],:) = [];
end

% Only use portion of loading path above current location
d_load = pivots(pivots(:,2) >= eps,:);


%% Unloading portion
% Load and scale unloading curve
% Include current location
unload_point1 = [unload_point
    F eps];

% Below first loading point
d_unload = [0 0];
for i = 1:size(load_point,1)
    % Scale unload curve up if necessary
    if d_UNLOAD(end,1) > unload_point1(i + 1,1)
        d_UNLOAD0 = d_UNLOAD;
    else
        % Scale unloading curve up if needed
        d_UNLOAD0 = [d_UNLOAD(:,1)./d_UNLOAD(end,1)*unload_point1(i + 1,1) d_UNLOAD(:,2)./d_UNLOAD(end,2)*unload_point1(i + 1,2)];
    end
    
    % Take force and strain above last loading point
    f2 = d_UNLOAD0(d_UNLOAD0(:,1) >= load_point(i,1),1);
    eps2 = d_UNLOAD0(d_UNLOAD0(:,1) >= load_point(i,1),2);
    
    % Shift curve to zero
    f2 = f2 - f2(1);
    eps2 = eps2 - eps2(1);
    
    % Normalize curve
    f2 = f2/f2(end);
    eps2 = eps2/eps2(end);
    
    % Scale curve between loading and unloading points
    f2 = f2*(unload_point1(i + 1,1) - load_point(i,1));
    eps2 = eps2*(unload_point1(i + 1,2) - load_point(i,2));
    
    % Shift curve to unloading point
    f2 = f2 + (unload_point1(i + 1,1) - f2(end));
    eps2 = eps2 + unload_point1(i + 1,2) - eps2(end);
    
    % Add curve to total unloading curve, remove previous portion of curve
    % that is overlapping with current portion of curve
    d_unload = [d_unload(d_unload(:,2) < eps2(1),:); f2 eps2];
end

% Only utilize the portion of the curve between current strain and zero
d_unload = d_unload(d_unload(:,2) < eps & d_unload(:,1) < F,:);
d_unload(d_unload(:,2) < 0,:) = [];

% Normalize curve and scale curve
if ~isempty(d_unload) && size(d_unload,1) > 1
    d_unload(:,1) = d_unload(:,1)/d_unload(end,1)*F;
    d_unload(:,2) = d_unload(:,2)/d_unload(end,2)*eps;
end

% Only utilize the portion of the curve below the loading curve
d_unload((d_unload(:,2) >= d_load(1,2)),:) = [];


%% Output
% Construct force-strain lookup table
d0 = [d_comp
    d_unload
    d_load
    d_orig];

while sum(d0(2:end,1) - d0(1:end - 1,1) < 0) > 0
    d0([d0(2:end,1) - d0(1:end - 1,1) < 0; false],:) = [];
end



f0 = interp1(d0(:,2),d0(:,1),eps);
if eps_rate >= 0
    f1 = interp1(d0(:,2),d0(:,1),eps + 1e-6);
    k = (f1 - f0)/1e-6;
else
    f1 = interp1(d0(:,2),d0(:,1),eps - 1e-6);
    k = (f0 - f1)/1e-6;
end

if f0 < 0 && eps > 0
%     k = F/eps;
    k = 300;
    eps = 0;
end
d = [k*(-100 - eps) + f0, -100
    k*(100 - eps) + f0, 100];

figure(500)
clf
box on
hold on
plot(d0(:,2),d0(:,1),'bx-')
plot(d(:,2),d(:,1),'r-')
plot(eps,f0,'go')

xlim([0 .03])
ylim([-50 3000])

for i = 2:size(unload_point,1)
    plot(unload_point(i,2),unload_point(i,1),'cs','markersize',5)
end
for i = 2:size(load_point,1)
    plot(load_point(i,2),load_point(i,1),'ms','markersize',5)
end


if f0 < 0 && eps > 0
    a = 1;
end

if isnan(d(1))
    a = 1;
end

end

