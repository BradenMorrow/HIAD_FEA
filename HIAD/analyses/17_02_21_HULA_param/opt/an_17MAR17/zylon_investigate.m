% Investigate zylon property extrapolation
% March 22, 2017



p = [.5 5 10 15 20]';
beta = [55 60 65 71];
EL55 = [58	74	77	83	88]';
EL60 = [70	82	84	87	95]';
EL65 = [79	84	83	79	82]';
EL71 = [77	80	80	76	84]';
GLH55 = [1030	7478	10415	11409	12008]';
GLH60 = [593	3133	4401	5319	6214]';
GLH65 = [546	2074	3390	4331	4937]';
GLH71 = [374	1279	1825	2397	2670]';




figure(1)
clf
box on
hold on

plot(p,EL55,'bx-')
plot(p,EL60,'gx-')
plot(p,EL65,'rx-')
plot(p,EL71,'cx-')



GLHmax = 12008;
GLH0 = interp1(p,GLH71,12)/GLHmax;
GLH1 = 4000;
fac = 1/GLHmax/GLH0*GLH1;

p0 = 8;
beta0 = 70;
GLH = GLH_interp(p0,beta0);

figure(2)
clf
box on
hold on

plot(p,GLH55*fac,'bx-')
plot(p,GLH60*fac,'gx-')
plot(p,GLH65*fac,'rx-')
plot(p,GLH71*fac,'cx-')
plot(p0,GLH,'ko')


beta_table = [GLH55 GLH60 GLH65 GLH71]*fac;

figure(3)
clf
box on
hold on
plot(beta,beta_table(1,:)*fac,'bx-')
plot(beta,beta_table(2,:)*fac,'gx-')
plot(beta,beta_table(3,:)*fac,'rx-')
plot(beta,beta_table(4,:)*fac,'cx-')
plot(beta,beta_table(5,:)*fac,'mx-')
plot(beta0,GLH,'ko')





