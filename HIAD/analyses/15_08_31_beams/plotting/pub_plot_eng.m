% Generate plot for twisting analysis of straight tube for publication
% August 21, 2015
% Andy Young

dir0 = 'C:\Users\andrew.young\Desktop\Repo\1115_NASA\HIAD_FE';



%% TEST
% Load test data
cd C:\Users\andrew.young\Desktop\NASA\data\test_data_19JUN14
cd .\beam1_60
figure(10)
clf
plot_test_1_60_2
cd ..

cd .\beam2_71
figure(11)
clf
plot_test_2_71
cd(dir0)

% % % % Extract and process variables of interest
% % % u_t = d8(:,5);
% % % u2_t = -d8(:,10);
% % % f_t = d8(:,12);
% % % 
% % % % Convert to SI
% % % u_t = u_t*25.4; % Inches to mm
% % % u2_t = u2_t*25.4; % Inches to mm
% % % f_t = f_t*4.448222/1000; % Lbf to kN


%% ANALYSIS - SHELL
% Load analysis output
load('output_13AUG14_2.mat')
% load('output_20AUG15.mat')

job = {'HETS1_60_0deg_p5';'HETS1_60_60deg_p5';'HETS1_60_0deg_p10';'HETS1_60_60deg_p10';'HETS1_60_0deg_p15';'HETS1_60_60deg_p15';'HETS1_60_0deg_p20';'HETS1_60_60deg_p20';'HETS2_71_0deg_p5';'HETS2_71_60deg_p5';'HETS2_71_0deg_p10';'HETS2_71_60deg_p10';'HETS2_71_0deg_p15';'HETS2_71_60deg_p15';'HETS2_71_0deg_p20';'HETS2_71_60deg_p20'};
fig_i = [10 10 10 10 10 10 10 10 11 11 11 11 11 11 11 11]';
sub_i = [1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2]';
count = 1;
for i = 1:16
    
    out = eval(sprintf('output.%s',job{i}));
    
    u = out(:,3);
    f = out(:,1);

% % %     % Convert to SI
% % %     u = u*25.4; % Inches to mm
% % %     f = f*4.448222/1000; % Lbf to kN

    % plot
    figure(fig_i(count))
    subplot(2,1,sub_i(count))
    plot(u,f,'c--','linewidth',2)
    
    count = count + 1;
end



%% ANALYSIS - BEAM
% Load analysis output
% load('.\analysis\20AUG15_beams\output_20AUG15.mat')
% load('C:\Users\andrew.young\Desktop\FE_code\flex_06NOV15\analysis\15_08_31_beams\output_18NOV15_2el_V.mat')
% load('C:\Users\andrew.young\Desktop\FE_code\flex_06NOV15\analysis\15_08_31_beams\results_18NOV15\output_18NOV15_2el_V.mat')
load('.\analyses\15_08_31_beams\results_13JAN16\output_13JAN16_Eeff.mat')

fig_i = [10 10 10 10 10 10 10 10 11 11 11 11 11 11 11 11]';
sub_i = [1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2]';
count = 1;
for i = [17:24 41:48]
    FEM = out(i).FEM_out;

    % Extract and process variables of interest
    ind = size(FEM.OUT.Uinc,1) - 4;
    u = -FEM.OUT.Uinc(ind,:)';
    f = FEM.OUT.Finc(2,:)'*2;

    u(u == 0) = [];
    f(f == 0) = [];

    u = [0; u];
    f = [0; f];

% % %     % Convert to SI
% % %     u = u*25.4; % Inches to mm
% % %     f = f*4.448222/1000; % Lbf to kN

    % plot
    figure(fig_i(count))
    subplot(2,1,sub_i(count))
    plot(u,f,'r-.','linewidth',1.5)
    
    count = count + 1;
end



%% FORMAT
figure(10)
subplot(2,1,1)

leg(1) = plot([-1 -1],[-2 -2],'b-','linewidth',2);
leg(2) = plot([-1 -1],[-2 -2],'c--','linewidth',2);
leg(3) = plot([-1 -1],[-2 -2],'r-.','linewidth',1.5);
legend(leg,'Test','Shell FE model','Beam FE model','location',[.31 .76 .1 .1]); % 'northwest'); % 
legend(gca,'boxoff')

xlim([-.2 5])
ylim([0 700])

a = 60;
b = 80;
c = 5.2;
text(c,a + b*0,'5 psi')
text(c,a + b*1,'10 psi')
text(c,a + b*2,'15 psi')
text(c,a + b*3,'20 psi')
subplot(2,1,2)

xlim([-.2 5])
ylim([0 700])

a = 100;
b = 100;
text(c,a + b*0,'5 psi')
text(c,a + b*1,'10 psi')
text(c,a + b*2,'15 psi')
text(c,a + b*3,'20 psi')

% Change the text in the plot to the specified size and font
set(findall(gcf,'type','text'),'FontSize',11,'FontName','cambria','fontangle','italic')
set(findall(gcf,'type','axes'),'FontSize',11,'FontName','cambria','fontangle','italic')

set(gcf,'units','inches','Position',[3 3 4.5 4.5]);
% Set size and position of figure
subplot(2,1,1)
set(gca,'Position',[0.13 0.6 0.69 0.284022]);

subplot(2,1,2)
% set(gca,'Position',[0.11 0.11 0.69 0.332991]);
set(gca,'Position',[0.13 0.15 0.69 0.284022]);




figure(11)
subplot(2,1,1)

leg(1) = plot([-1 -1],[-2 -2],'b-','linewidth',2);
leg(2) = plot([-1 -1],[-2 -2],'c--','linewidth',2);
leg(3) = plot([-1 -1],[-2 -2],'r-.','linewidth',1.5);
legend(leg,'Test','Shell FE model','Beam FE model','location',[.31 .76 .1 .1]); % 'northwest'); % 
legend(gca,'boxoff')

xlim([-.2 5])
ylim([0 700])

a = 90;
b = 100;
text(c,a + b*0,'5 psi')
text(c,a + b*1,'10 psi')
text(c,a + b*2,'15 psi')
text(c,a + b*3,'20 psi')

subplot(2,1,2)

xlim([-.2 5])
ylim([0 700])

a = 190;
b = 150;
text(c,a + b*0,'5 psi')
text(c,a + b*1,'10 psi')
text(c,a + b*2,'15 psi')
text(c,a + b*3,'20 psi')

% Change the text in the plot to the specified size and font
set(findall(gcf,'type','text'),'FontSize',11,'FontName','cambria','fontangle','italic')
set(findall(gcf,'type','axes'),'FontSize',11,'FontName','cambria','fontangle','italic')

set(gcf,'units','inches','Position',[8 3 4.5 4.5]);
% Set size and position of figure
subplot(2,1,1)
set(gca,'Position',[0.13 0.6 0.69 0.284022]);

subplot(2,1,2)
% set(gca,'Position',[0.11 0.11 0.69 0.332991]);
set(gca,'Position',[0.13 0.15 0.69 0.284022]);


% print('test1','-dmeta')



















