function [F_cable] = proc_tor_load_test_T5C1_23JUN15
% Pre-process the torus load-cell data from test
% T5C-1 Torus
% June 23, 2015
% Andy Young

% Load data
read_data = 1;
if read_data == 1
    d = csvread('130815_141249_20_T5C1_20PSI_COMP3.csv',6,12);
    d(:,65:end) = [];
end

% Strap indices, start with bottom of strap 1, CCW around torus to obtain
% bottom of straps, Top of strap 1, CCW around torus again to obtain top of
% straps
ind = [(1:32)' (33:64)']';
ind = ind(:);
d_strap = d(:,ind);
t = linspace(0,1,size(d,1))';
d_strap(t < .37 | t > .58,:) = [];
t(t < .37 | t > .58) = [];
% t = linspace(0,1,length(t))';

% Smooth data
for i = 1:size(d_strap,2)
    d_strap(:,i) = smooth(d_strap(:,i),150);
end

% Fit line
P = zeros(size(d_strap,2),2);
t2 = (0:.01:.25)';
Pi = zeros(length(t2),size(d_strap,2));
for i = 1:length(P);
    P(i,:) = polyfit(t,d_strap(:,i),1);
    Pi(:,i) = P(i,1)*t2; % + P(i,2);
end


theta = [84.3700000000000;73.1200000000000;61.8700000000000;50.6200000000000;39.3700000000000;28.1200000000000;16.8700000000000;5.61999999999999;354.370000000000;343.120000000000;331.870000000000;320.620000000000;309.370000000000;298.120000000000;286.870000000000;275.620000000000;264.370000000000;253.120000000000;241.870000000000;230.620000000000;219.370000000000;208.120000000000;196.870000000000;185.620000000000;174.370000000000;163.120000000000;151.870000000000;140.620000000000;129.370000000000;118.120000000000;106.870000000000;95.6200000000000]*pi/180;
theta_ind = [1:32; 1:32];
theta_ind = theta_ind(:);

% X and Y components of cable forces
fx = zeros(length(P),1);
fy = zeros(length(P),1);
for i = 1:length(P)
    fx(i) = -P(i,1)*cos(theta(theta_ind(i)));
    fy(i) = -P(i,1)*sin(theta(theta_ind(i)));
end


% Modify forces to obtain equilibrium
sx = zeros(16,1);
sy = zeros(16,1);
P_track = zeros(16,4);
count = 1;
for i = 1:2:32
    % Sum of x and y components of force for paired cables, (e.g., top and
    % bottom cables, theta = 0 and 180 degrees)
    sx(count) = fx(i) + fx(i + 1) + fx(i + 32) + fx(i + 33);
    sy(count) = fy(i) + fy(i + 1) + fy(i + 32) + fy(i + 33);
    
    % Force in each set of cables
    P_track(count,:) = [P(i,1) P(i + 1,1) P(i + 32,1) P(i + 33,1)];
    count = count + 1;
end




%%%%%%%%%%%%%%%%
% P_track(5,2) = P_track(5,1);
% P_track(16,3) = P_track(16,4);












% Adjusting cable forces
% Find the mean of four opposing cables
P_mean = mean(P_track,2);
% Find the mean of top and bottom cables on each side
P_mean1 = mean(P_track(:,1:2),2);
P_mean2 = mean(P_track(:,3:4),2);

% Find difference between total mean and mean of top and bottom
P_diff1 = P_mean - P_mean1;
P_diff2 = P_mean - P_mean2;

% Offset each cable force by difference in means
P_track2 = [P_track(:,1) + P_diff1 P_track(:,2) + P_diff1 P_track(:,3) + P_diff2 P_track(:,4) + P_diff2];

P2 = zeros(size(P,1),1);

count = 1;
for i = 1:2:32
    P2([i, i + 1, i + 32, i + 33]) = P_track2(count,:)';
    count = count + 1;
end

% X and Y components of cable forces
fx2 = zeros(length(P2),1);
fy2 = zeros(length(P2),1);
for i = 1:length(P)
    fx2(i) = -P2(i,1)*cos(theta(theta_ind(i)));
    fy2(i) = -P2(i,1)*sin(theta(theta_ind(i)));
end


% Cable force for FE model
f_cable = [fx2 fy2 zeros(64,4)]';

f_cable2 = f_cable/sum((sum(f_cable.^2).^.5));
F_cable = f_cable2(:);



%%
% Plotting
plotting = 1;
if plotting == 1
    figure(11)
    clf
    box on
    hold on

    leg1 = plot(t2,Pi,'b');
    L(2) = leg1(1);
    leg2 = plot(t - .355,d_strap,'g');
    L(1) = leg2(1);
    leg3 = plot([0 .25],[P2*0 P2*.25],'r--');
    L(3) = leg3(1);

    xlabel('''Time''')
    ylabel('Cable force (lbf)')
    legend(L,'Linear portion of measured cable force',...
        'Linear fit',...
        'Adjusted cable force','location','northwest')


    figure(12)
    clf
    box on
    hold on
    plot(fx)
    plot(fy,'r')

    figure(13)
    clf
    subplot(2,1,1)
    box on
    hold on
    bar(sx)
    xlim([0 17])

    subplot(2,1,2)
    box on
    hold on
    bar(sy,'r')
    xlim([0 17])



    P_bar = P_track(:,:);
    P_bar2 = P_track2(:,:);

    figure(14)
    clf
    box on
    hold on
    bar([P_bar zeros(size(P_bar,1),1) P_bar2],1,'grouped')
    % bar(P_bar,P_bar2) %,1,'grouped')

    xlim([.5 length(P_bar) + .5])

    xlabel('Cable group')
    ylabel('Cable force (lbf)')
    % legend(sprintf('Measured cable\nforces'),' ',' ',' ',sprintf('Adjusted cable\nforces'),' ',' ',' ','','location','northeastoutside')
    
    
    figure(15)
    clf
    box on
    hold on
    bar(P_bar,1,'grouped')
    % bar(P_bar,P_bar2) %,1,'grouped')

    xlim([.5 length(P_bar) + .5])

    xlabel('Cable group')
    ylabel('Cable force (lbf)')
    
    
    %%
    ind = (780:1275)';
    
    figure(16)
    clf
    box on
    hold on
    plot(d,'b')
    plot(d(ind,:),'g')
end






end



