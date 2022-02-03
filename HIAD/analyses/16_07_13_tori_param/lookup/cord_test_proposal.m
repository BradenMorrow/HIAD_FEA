% Proposed cord loading regime
% July 25, 2016

% Duration and load (loading rate is 10 lbf/s)
P = [0    0
    20    0
    55    550
    55    0
    20    0
    55    550
    55    0
    20    0
    50    500
    50    0
    20    0
    45    450
    45    0
    20    0
    40    400
    40    0
    20    0
    35    350
    35    0
    20    0
    30    300
    30    0
    20    0
    55    550
    55    0
    20    0
    150   1500
    150   0
    20    0];

% Total time
for i = 2:size(P,1)
    P(i) = P(i - 1) + P(i);
end

% Plotting
figure(1)
clf
box on
hold on
plot(P(:,1),P(:,2),'b')

xlabel('Time (s)')
ylabel('Load (lbf)')

xlim([0 max(P(end,1))])
ylim([-50 1550])
