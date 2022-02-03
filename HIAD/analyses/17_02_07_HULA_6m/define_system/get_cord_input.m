% Build cord lookup table
% September 22, 2016

clear
d = load('zylon_axial_table');
d2 = load('zylon_axial_table_23SEP16');

strain = [.018 .0192]';
load = [175 338]';


k_ten = (load(end) - load(end - 1))/(strain(end) - strain(end - 1));
k_com = 1500;
PT = 0;
F0 = load(end - 1);
eps0 = strain(end - 1);

% 4.5 7.04
[f,k] = cord_response_29SEP16(k_ten,k_com,PT,F0,eps0);


eps = linspace(0,.02,100)';
force = ppval(f,eps);
cord = [-300*1000 -1000
    force eps
    ppval(f,1e10) 1e10];
    


%% Plot
figure(1)
clf
box on
hold on
plot(d(:,2),d(:,1),'k-','linewidth',2)
% plot(d(:,2),d(:,1),'g--')



xlim([0 .025])
ylim([0 400])

figure(11)
hold on
plot([eps0 eps0],[0 10000],'b-')
plot(eps0,F0,'bx')

plot(cord(:,2),cord(:,1),'k--')


a = 1;
% % % 
% % % gauge = 16;
% % % strain = (0:.25:1.75)'/gauge;
% % % load = [0 50 200 700 1800 3350 5300 7650]';
% % % 
% % % % k = 114000;
% % % 
% % % 
% % % 
% % % k_ten = (load(end) - load(end - 1))/(strain(end) - strain(end - 1));
% % % k_com = 100;
% % % PT = 200;
% % % F0 = 5300;
% % % eps0 = strain(end - 1);
% % % [f,k] = strap_response_22SEP16(k_ten,k_com,PT,F0,eps0);
% % % % [f,k] = strap_response_22SEP16(k_ten,k_ten,0,k_ten*eps0,eps0);
% % % % [f,k] = strap_response(k_ten,k_com,PT,PT_analysis)
% % % % 4.01 10.41
% % % 
% % % 
% % % %% Plotting
% % % fig = figure(1);
% % % clf
% % % box on
% % % hold on
% % % plot(strain,load,'bx-','linewidth',2)
% % % % plot([0 2],k*[0 2],'g-','linewidth',2)
% % % xlim([0 .11])
% % % ylim([0 9000])
% % % 
% % % xlabel('Strain')
% % % ylabel('Load (lbf)')
% % % 
% % % 
% % % % legend('From test data','Original approximation','location','northwest')
% % % 
% % % set(fig, 'Position', [650 400 990 390])