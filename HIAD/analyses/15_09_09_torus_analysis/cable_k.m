% Estimate cable stiffness
% Andy Young
% September 12, 2015

addpath 'C:\Users\andrew.young\Desktop\T4A-1'

d = load('Cable6_20psi_processed.dat');
p = d(:,2);
u1 = d(:,3);
u2 = d(:,4);
u = d(:,12);

p(isnan(u)) = [];
u(isnan(u)) = [];

ind = 15:60;

P = polyfit(u(ind),p(ind),1);
disp(P(1))


figure(1)
clf
box on
hold on
plot(u,p,'b-','linewidth',2)
% plot(u(ind),p(ind),'bx-')
plot([1.5 2.5],[1.5*P(1) + P(2) 2.5*P(1) + P(2)],'r-','linewidth',2)


xlim([0 3])
ylim([0 200])

xlabel('Radial displacement (in)')
ylabel('Load (lbf)')




% 1: bottom load cell (lbf)
% 2: top load cell (lbf)
% 3: stringpot displacement on outside of torus
% 4-5: stringpot displacements from steel fixture to D-rings - Sam could not remember which is top, but it may be possible to determine this based on other tests
% 6-12: pontos dot displacements