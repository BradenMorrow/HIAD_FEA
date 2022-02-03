% Generate plot for twisting analysis of straight tube for publication
% August 21, 2015
% Andy Young

%%
dir0 = 'C:\Users\ayoung13\Desktop\Repo\1115_NASA\HIAD_FE';

%% TEST
% % % % Load test data
% % % cd C:\Users\andrew.young\Desktop\NASA\data\test_data_19JUN14
% % % cd .\beam2_71
% % % d8 = load('beam2_71_p20_2up_run3_10Hz.dat');
% % % cd(dir0)
% % % 
% % % % Extract and process variables of interest
% % % u_t = d8(:,5);
% % % u2_t = -d8(:,10);
% % % f_t = d8(:,12);


load_data = 1;
if load_data == 1;
    A = csvread('HETS2_71_p20_60deg_disp.csv',3,0);
    B = xlsread('HETS2_71_p20_60deg','Project 1115','E2:E95119');
end
% Aramis
ind_A = (795:920)';
u2_0 = A(:,7)/25.4;
u2_1 = u2_0 - u2_0(1);
u2_2 = interp1(1:length(u2_1),u2_1,linspace(0,length(u2_1),1000))';

u1_0A = A(:,1)/25.4;
u1_1A = u1_0A - u1_0A(1);
u1_2A = interp1(1:length(u1_1A),u1_1A,linspace(0,length(u1_1A),1000))';

% DAQ
ind_DAQ = (795:920)';
u1_0 = B;
u1_1 = u1_0 - u1_0(1);
u1_2 = interp1(1:length(u1_1),u1_1,linspace(0,length(u1_1),1000))';

P_0 = xlsread('HETS2_71_p20_60deg','Project 1115','L2:L95119');
P_1 = interp1(1:length(P_0),P_0,linspace(0,length(P_0),1000))';



% Convert to SI
u_t = u1_2(ind_DAQ);
u2_t = -u2_2(ind_A);
f_t = P_1(ind_DAQ);

u_t = u_t*25.4 - 6.5; % Inches to mm
u2_t = u2_t*25.4 + 1.25; % Inches to mm
f_t = f_t*4.448222/1000; % Lbf to kN



%% ANALYSIS
% Load analysis output
load('.\analysis\04SEP15_beam_twist\output_twist_1mm_04SEP15_2.mat')
FEM = out1(48);

% Extract and process variables of interest
ind = ceil(size(FEM.OUT.Uinc,1)/6/2);
u = -FEM.OUT.Uinc(ind*6 - 4,:)';
u2 = FEM.OUT.Uinc(ind*6 - 3,:)';
f = FEM.OUT.Finc(end - 10,:)'*2;

u(u == 0) = [];
u2(u2 == 0) = [];
f(f == 0) = [];

u = [0; u];
u2 = [0; u2];
f = [0; f];

% Convert to SI
u = u*25.4; % Inches to mm
u2 = u2*25.4; % Inches to mm
f = f*4.448222/1000; % Lbf to kN

%% PLOT
figure(10)
clf
box on
hold on

% Test
plot(u_t,f_t,'b-','linewidth',2)
plot(u2_t,f_t,'b:','linewidth',2)

% Analysis
plot(u,f,'r-.','linewidth',2)
plot(u2,f,'r--','linewidth',2)

xlabel(sprintf('Deflection (mm)'))
ylabel('Load (kN)')
legend('In-plane deflection, test','Out-of-plane deflection, test', ...
    'In-plane deflection, beam FE model','Out-of-plane deflection, beam FE model', ...
    'location','southoutside')
legend(gca,'boxoff')

xlim([-5 120])
ylim([0 3.5])

% Change the text in the plot to the specified size and font
set(findall(gcf,'type','text'),'FontSize',11,'FontName','cambria','fontangle','italic')
set(findall(gcf,'type','axes'),'FontSize',11,'FontName','cambria','fontangle','italic')

% Set size and position of figure
% set(gca,'units','inches','Position',[0 0 3.5 1]); 
set(gcf,'units','inches','Position',[5 5 3.5 2.5]);

% print('test1','-dmeta')






