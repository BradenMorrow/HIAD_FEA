% Process the zylon cord for use in FE model
% February 10, 2016

% Load original lookup table
d = load('zylon_axial_table');

% Fit linear region
P = polyfit(d(end - 10:end,2),d(end - 10:end,1),1);

% Interpolate
f1 = interp1(d(2:end,2),d(2:end,1),linspace(0,.035,50)');
d2 = [-3e10 -1e10
    f1 linspace(0,.035,50)'
    f1(end) + P(1)*1e10 .035 + 1e10];

figure(10)
clf
box on
hold on
% plot(d(:,2),d(:,1),'bx-')
plot(d2(:,2),d2(:,1),'b-')

xlim([-.005 .05])
ylim([-100 8000])

xlabel('Strain')
ylabel('Load (lbf)')
title('Cord force-strain relationship')





