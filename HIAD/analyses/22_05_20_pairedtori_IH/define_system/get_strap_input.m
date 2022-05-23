% Build cord lookup table
% September 22, 2016

gauge = 16;
strain = (0:.25:1.75)'/gauge;
load = [0 50 200 700 1800 3350 5300 7650]';

% k = 114000;

k_ten = (load(end) - load(end - 1))/(strain(end) - strain(end - 1));
k_com = 100;
PT = 200;
F0 = 5300;
eps0 = strain(end - 1);
[f,k] = strap_response(k_ten,k_com,PT,F0,eps0);
% [f,k] = strap_response_22SEP16(k_ten,k_ten,0,k_ten*eps0,eps0);
% [f,k] = strap_response(k_ten,k_com,PT,PT_analysis)
% 4.01 10.41


%% Plotting
fig = figure(1);
clf
box on
hold on
plot(strain,load,'bx-','linewidth',2)
% plot([0 2],k*[0 2],'g-','linewidth',2)
xlim([0 .11])
ylim([0 9000])

xlabel('Strain')
ylabel('Load (lbf)')


% legend('From test data','Original approximation','location','northwest')

set(fig, 'Position', [650 400 990 390])

