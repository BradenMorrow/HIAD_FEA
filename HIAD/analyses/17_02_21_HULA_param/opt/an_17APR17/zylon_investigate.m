% Investigate zylon property extrapolation
% March 22, 2017



p = [.5 5 10 15 20 25]';
beta = [55 60 65 71 75];
EL55 = [58	74	77	83	88	88*1.05]';
EL60 = [70	82	84	87	95	95*1.05]';
EL65 = [79	84	83	79	82	82*1.05]';
EL71 = [77	80	80	76	84	84*1.05]';
EL75 = [77	80	80	76	84	84*1.05]'*.9;
GLH55 = [1030	7478	10415	11409	12008	12008*1.05]';
GLH60 = [593	3133	4401	5319	6214	6214*1.05]';
GLH65 = [546	2074	3390	4331	4937	4937*1.05]';
GLH71 = [374	1279	1825	2397	2670	2670*1.05]';
GLH75 = [374	1279	1825	2397	2670	2670*1.05]'*.7;



%%
figure(1)
clf
box on
hold on

plot(p,EL55,'bx-')
plot(p,EL60,'gx-')
plot(p,EL65,'rx-')
plot(p,EL71,'cx-')
plot(p,EL75,'mx-')


%%
GLHmax = 12008;
GLH0 = interp1(p,GLH71,12)/GLHmax;
GLH1 = 4000;
fac = 1/GLHmax/GLH0*GLH1;

p0 = 25;
beta0 = 55;
GLH = GLH_interp(p0,beta0);

beta_table = [GLH55 GLH60 GLH65 GLH71 GLH75]*fac;

figure(2)
clf
box on
hold on

% % % plot(p,GLH55*fac,'bx-')
% % % plot(p,GLH60*fac,'gx-')
% % % plot(p,GLH65*fac,'rx-')
% % % plot(p,GLH71*fac,'cx-')
% % % plot(p,GLH75*fac,'yx-')
plot(p,beta_table(:,1),'bx-')
plot(p,beta_table(:,2),'gx-')
plot(p,beta_table(:,3),'rx-')
plot(p,beta_table(:,4),'cx-')
plot(p,beta_table(:,5),'yx-')
plot(p0,GLH,'ko')

title('G_{LH}(p)')
xlabel('Inflation pressure (psi)')
ylabel('Shear modulus, G_{LH} (lbf/in)')






%%
figure(3)
clf
box on
hold on
plot(beta,beta_table(1,:),'bx-')
plot(beta,beta_table(2,:),'gx-')
plot(beta,beta_table(3,:),'rx-')
plot(beta,beta_table(4,:),'cx-')
plot(beta,beta_table(5,:),'mx-')
plot(beta,beta_table(6,:),'yx-')
plot(beta0,GLH,'ko')

title('G_{LH}(\beta)')
xlabel('Braid angle, \beta (deg)')
ylabel('Shear modulus, G_{LH} (lbf/in)')




