function [pp] = cable_stiff_13JUL16( d,P,p_r,alias1,smooth_n,lim,fignum)
% cable_stiff_13JUL16
%   

%% Process test data
% Save original data
d0 = d;
P0 = P;

% Zero first entry
d1 = d(1,:);
P1 = P(1,:);
for i = 1:size(d0,1)
    d0(i,:) = d0(i,:) - d1;
    P0(i,:) = P0(i,:) - P1 + 10;
end

% Add ramp to 10 lb preload
d0 = d0 + .1;
d0 = [zeros(1,16); d0];
P0 = [zeros(1,16); P0];

% Removes last p_r of data points from d and P
d(floor(size(d,1) - size(d,1)*p_r):end,:) = [];
P(floor(size(P,1) - size(P,1)*p_r):end,:) = [];

% Alias1 
d2 = zeros(alias1,16);
P2 = zeros(size(d2,1),16);
for j = 1:16
    [du,I] = unique(d(:,j));
    p = P(I,j);
    d2(:,j) = linspace(0,max(du),alias1)';
    P2(:,j) = interp1(du,p,d2(:,j),'linear','extrap');
end

% Smooth data
for j = 1:16
    d2(:,j) = smooth(d2(:,j),smooth_n);
    P2(:,j) = smooth(P2(:,j),smooth_n);
    d2(:,j) = smooth(d2(:,j),smooth_n);
    P2(:,j) = smooth(P2(:,j),smooth_n);
end

% Extrapolate
P3 = zeros(1,16);
d3 = [d2; ones(1,size(d2,2))*lim];
for i = 1:16;
    P3(i) = interp1(d2(:,i),P2(:,i),lim,'linear','extrap');
end
P3 = [P2;P3];

% Zero first entry
d1 = d(1,:);
P1 = P(1,:);
for i = 1:size(d3,1)
    d3(i,:) = d3(i,:) - d1;
    P3(i,:) = P3(i,:) - P1 + 10;
end

% Add ramp to 10 lb preload
d3 = d3 + .1;
d3 = [zeros(1,16); d3];
P3 = [zeros(1,16); P3];

% Get polynomial
I0 = 0;
k0 = 1;
L = ones(16,1);
L(1:8) = 70 - 24;
L(1:16) = 70 - 16.85;
pp(16).d = [];
pp(16).k = [];

x = 0:.01:.7;
figure(fignum)
clf
hold on 
box on
plot(d0,P0,'.-','linewidth',.5);
for i = 1:16
    % Run function
    [pp(i).d,pp(i).k] = get_cable_pp4([P3(:,i) d3(:,i)],I0,k0,L(i));
    % Plot result
    y = ppval(pp(i).d,x);
    plot(x,y,'linewidth',2)
end
end

