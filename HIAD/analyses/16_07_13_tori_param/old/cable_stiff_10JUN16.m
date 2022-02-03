% Cable stiffness directly from test
% June 10, 2016

%% Load test data
load_cable_stiffness
d0 = d;
P0 = P;

%% Process test data
% Zero first entry
d1 = d(1,:);
P1 = P(1,:);
for i = 1:size(d,1)
    d(i,:) = d(i,:) - d1;
    P(i,:) = P(i,:) - P1 + 10;
end

% Smooth data
smooth_n = 30;
for j = 1:16
    d(:,j) = smooth(d(:,j),smooth_n);
    P(:,j) = smooth(P(:,j),smooth_n);
end

% Eliminate last entries
end_i = 5;
d(end - end_i:end,:) = [];
P(end - end_i:end,:) = [];

% Add ramp to 10 lb preload
d = d + .1;
d = [zeros(1,16); d];
P = [zeros(1,16); P];

% Check for monotonic increasing values
d_check = d(2:end,:) - d(1:end - 1,:) < 0;
P_check = P(1:end - 1,:) - P(2:end,:) > 0;

% Alias1
d2 = linspace(0,.7,1000)';
P2 = zeros(size(d2,1),16);
for j = 1:16
    P2(:,j) = interp1(d(:,j),P(:,j),d2,'linear','extrap');
end

% Smooth aliased data
smooth_n2 = 100;
for j = 1:16
    P2(:,j) = smooth(P2(:,j),smooth_n2);
end

% Alias2
d3 = linspace(0,.7,50)';
P3 = zeros(size(d3,1),16);
for j = 1:16
    P3(:,j) = interp1(d2,P2(:,j),d3,'linear','extrap');
end


I0 = 0;
k0 = 1;
L = ones(16,1);
% % % L(1:8) = 70 - 24;
% % % L(1:16) = 70 - 16.85;
pp(16).d = [];
pp(16).k = [];

for i = 1:16
    [pp(i).d,pp(i).k] = get_cable_pp3([P3(:,i) d3],I0,k0,L(i));
end



% % % % Save output
% % % save('cable_stiff','pp')

%% Plotting
figure(1)
clf
box on
hold on
xlim([0 .7])
for j = 1:16
    plot(d(:,j),P(:,j),'-','linewidth',5)
end


figure(2)
clf
box on
hold on
xlim([0 .7])
for j = 1:16
    plot(d2,P2(:,j),'x-')
end


figure(3)
clf
box on
hold on
xlim([0 .7])
for j = 1:16
    plot(d0(:,j) + .1,P0(:,j),'o-','linewidth',1)
    plot(d3,P3(:,j),'-','linewidth',2)
end


figure(15)
hold on
plot(d3,P3(:,1),'b-')


