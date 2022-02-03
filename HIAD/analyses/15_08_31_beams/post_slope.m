% Look at the post wrinkling slope of beam model and test
% 60 degree beam, 20 psi, 2 cords up
% September 23, 2015
% Andy Young


%% Model
% load('C:\Users\andrew.young\Desktop\FE_code\obj_21SEP15\analysis\15_08_31_beams\FEM_out_60deg_2_20psi_2up.mat')
% load('C:\Users\andrew.young\Desktop\FE_code\obj_21SEP15\analysis\15_08_31_beams\FEM_out_60deg_1_20psi_2up.mat')
load('C:\Users\andrew.young\Desktop\FE_code\C_modeling_paper_18SEP15\analysis\analysis_old\31AUG15_beams\plotting\output_04SEP15.mat')
FEM_out = out1(48);
ind1 = 80;

% Load and displacement
u = [0; -FEM_out.OUT.Uinc(end - 4,:)'];
f = [0; FEM_out.OUT.Finc(6 - 4,:)'*2];

% Post-wrinkling load and displacement
u_post = u(ind1:end);
f_post = f(ind1:end);

% Fit line
P_mod = polyfit(u_post,f_post,1);
x = [0 6];


%% TEST
cd 'C:\Users\andrew.young\Desktop\NASA\data\test_data_19JUN14\beam2_60'
d = load('beam2_60_p20_2up_run3_10Hz.dat'); % _20_60

% cd 'C:\Users\andrew.young\Desktop\NASA\data\test_data_19JUN14\beam1_60'
% d = load('beam1_60_p20_2up_run3_10Hz.dat'); % _20_60

% cd 'C:\Users\andrew.young\Desktop\NASA\data\test_data_19JUN14
% d = load('beam2_71_p20_2up_run3_10Hz.dat'); % _20_60
ind2 = 650;



cd 'C:\Users\andrew.young\Desktop\FE_code\obj_21SEP15'

% Load and displacement
u_test = d(:,5);
f_test = d(:,12);

% Post-wrinkling load and displacement
u_test_post = u_test(ind2:1:end);
f_test_post = f_test(ind2:1:end);

% Fit line
P_test = polyfit(u_test_post,f_test_post,1);


%% SHELL MODEL
spec = 'HETS2_71_60deg_p20';

cd(sprintf('I:\\NASA\\updated_model_12AUG14\\%s',spec))
open(sprintf('%s.fig',spec))
D=get(gca,'Children'); %get the handle of the line object
XData=get(D,'XData'); %get the x data
YData=get(D,'YData'); %get the y data
d=[XData' YData']; %join the x and y data on one array nx2



ind3 = 8:13;



cd 'C:\Users\andrew.young\Desktop\FE_code\obj_21SEP15'

% Load and displacement
u_shell = XData{1}';
f_shell = YData{1}';

% Post-wrinkling load and displacement
u_shell_post = u_shell(ind3);
f_shell_post = f_shell(ind3);

% Fit line
P_shell = polyfit(u_shell_post,f_shell_post,1);


%% PLOT
figure(10)
clf
box on
hold on
xlabel('Displacement (in)')
ylabel('Load (lbf)')
title('2 cords up')
xlim([0 6])
ylim([0 700])

% Model
plot(u,f,'co-','markersize',3,'linewidth',1)
plot(u_post,f_post,'rx','markersize',5,'linewidth',2)
plot(x,polyval(P_mod,x),'k')

% Test
plot(u_test,f_test,'b-','linewidth',2)
plot(u_test_post,f_test_post,'rx','markersize',5,'linewidth',2)
plot(x,polyval(P_test,x),'k')

% Shell
plot(u_shell,f_shell,'gx-','linewidth',2)
plot(u_shell_post,f_shell_post,'rx','markersize',5,'linewidth',2)
plot(x,polyval(P_shell,x),'k')

% Annotate
text(4,250,sprintf('k_{model} = %g lb/in',P_mod(1)))
text(.1,600,sprintf('k_{test} = %g lb/in',P_test(1)))
text(4,100,sprintf('k_{shell} = %g lb/in',P_shell(1)))




%%
% [beam test shell]
k60_1 = [3.30491	5.13799 5.8426		% 60	deg,	5	psi,	1	up	17
    3.57787	7.1651  8.0926              % 60	deg,	10	psi,	1	up	19
    3.78869	8.96211 9.8851              % 60	deg,	15	psi,	1	up	21
    4.29465	10.7336 11.595];            % 60	deg,	20	psi,	1	up	23
    
k60_2 = [6.53224	10.5987 10.819      % 60	deg,	5	psi,	2	up	18
    6.95073	14.8576 15.11               % 60	deg,	10	psi,	2	up	20
    7.48756	18.758  17.899              % 60	deg,	15	psi,	2	up	22
    8.60817	21.9168 21.98];             % 60	deg,	20	psi,	2	up	24
    
k71_1 = [3.81474	4.29975 6.6651      % 71	deg,	5	psi,	1	up	41
    3.78662	6.00842 7.3684              % 71	deg,	10	psi,	1	up	43
    2.61352	6.82961 7.1798              % 71	deg,	15	psi,	1	up	45
    2.43439	7.4426  7.4132];            % 71	deg,	20	psi,	1	up	47

k71_2 = [7.47037	4.67229 11.302		% 71	deg,	5	psi,	2	up	42
    7.58469	9.13573 13.816              % 71	deg,	10	psi,	2	up	44
    5.30637	11.7344 12.773              % 71	deg,	15	psi,	2	up	46
    5.01279	17.4533 14.416];            % 71	deg,	20	psi,	2	up	48

pressure = [5 10 15 20]';


figure(11)
clf
subplot(2,1,1)
box on
hold on
plot(pressure,k60_1(:,2),'rv-')
plot(pressure,k60_1(:,3),'gd-')
plot(pressure,k60_1(:,1),'bs-')
xlim([0 25])
ylim([0 25])
title('\beta = 60, 1 cord up')
xlabel('Pressure (psi)')
ylabel('Post-wrinkling stiffness (lb/in)')
legend('Test','Shell Model','Beam Model','location','northwest')

subplot(2,1,2)
box on
hold on
plot(pressure,k60_2(:,2),'rv-')
plot(pressure,k60_2(:,3),'gd-')
plot(pressure,k60_2(:,1),'bs-')
xlim([0 25])
ylim([0 25])
title('\beta = 60, 2 cords up')
xlabel('Pressure (psi)')
ylabel('Post-wrinkling stiffness (lb/in)')
% legend('Model','Test','location','northwest')

figure(13)
clf

subplot(2,1,1)
box on
hold on
plot(pressure,k71_1(:,2),'rv-')
plot(pressure,k71_1(:,3),'gd-')
plot(pressure,k71_1(:,1),'bs-')
xlim([0 25])
ylim([0 25])
title('\beta = 71, 1 cord up')
xlabel('Pressure (psi)')
ylabel('Post-wrinkling stiffness (lb/in)')
legend('Test','Shell Model','Beam Model','location','northwest')

subplot(2,1,2)
box on
hold on
plot(pressure,k71_2(:,2),'rv-')
plot(pressure,k71_2(:,3),'gd-')
plot(pressure,k71_2(:,1),'bs-')
xlim([0 25])
ylim([0 25])
title('\beta = 71, 2 cords up')
xlabel('Pressure (psi)')
ylabel('Post-wrinkling stiffness (lb/in)')
% legend('Model','Test','location','northwest')








