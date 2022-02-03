% Process cable stiffness tests
% May 17, 2016

% Load data
d_05 = load('5_psi.txt');
d_10 = load('10_psi.txt');
d_15 = load('15_psi.txt');
d_15_2 = load('15_psi2.txt');

% Smooth data
I0 = 16;
k0 = 1;
L = 1;

[d05,k05] = get_cable_pp(d_05,I0,k0,L);
[d10,k10] = get_cable_pp(d_10,I0,k0,L);
[d15,k15] = get_cable_pp(d_15,I0,k0,L);
[d15_2,k15_2] = get_cable_pp2(d_15_2,I0,k0,L);

% [D_05,I_05] = unique(-d_05(:,2));
% D_05 = [d_05(I_05) D_05];
% D_05(1:I0,:) = [];
% D_05(:,1) = D_05(:,1) - D_05(1,1);
% D_05(:,2) = D_05(:,2) - D_05(1,2);
% D_05 = [interp1(D_05(:,2),D_05(:,1),linspace(0,D_05(end,2),1000)') linspace(0,D_05(end,2),1000)'];
% D_05(:,1) = smooth(D_05(:,1),50);
% D_05 = [interp1(D_05(:,2),D_05(:,1),linspace(0,D_05(end,2),25)') linspace(0,D_05(end,2),25)'];
% D_05 = [-k0*1 -1
%     D_05];
% d05 = pchip(D_05(:,2),D_05(:,1));


% [D_10,I_10] = unique(-d_10(:,2));
% D_10 = [d_10(I_10) D_10];
% D_10(:,1) = smooth(D_10(:,1));
% D_10(:,2) = D_10(:,2) - D_10(1,2);
% D_10(1:I0,:) = [];
% D_10(:,1) = D_10(:,1) - D_10(1,1);
% D_10(:,2) = D_10(:,2) - D_10(1,2);
% D_10 = [interp1(D_10(:,2),D_10(:,1),linspace(0,D_10(end,2),1000)') linspace(0,D_10(end,2),1000)'];
% D_10(:,1) = smooth(D_10(:,1),50);
% D_10 = [interp1(D_10(:,2),D_10(:,1),linspace(0,D_10(end,2),25)') linspace(0,D_10(end,2),25)'];
% D_10 = [-k0*1 -1
%     D_10];
% d10 = pchip(D_10(:,2),D_10(:,1));
% 
% 
% [D_15,I_15] = unique(-d_15(:,2));
% D_15 = [d_15(I_15) D_15];
% D_15(:,1) = smooth(D_15(:,1));
% D_15(:,2) = D_15(:,2) - D_15(1,2);
% D_15(1:I0,:) = [];
% D_15(:,1) = D_15(:,1) - D_15(1,1);
% D_15(:,2) = D_15(:,2) - D_15(1,2);
% D_15 = [interp1(D_15(:,2),D_15(:,1),linspace(0,D_15(end,2),1000)') linspace(0,D_15(end,2),1000)'];
% D_15(:,1) = smooth(D_15(:,1),50);
% D_15 = [interp1(D_15(:,2),D_15(:,1),linspace(0,D_15(end,2),25)') linspace(0,D_15(end,2),25)'];
% D_15 = [-k0*1 -1
%     D_15];
% d15 = pchip(D_15(:,2),D_15(:,1));




figure(15)
clf
box on
hold on
% % plot(-d_05(:,2),d_05(:,1),'bx-')
% plot(D_05(:,2),D_05(:,1),'bo-')

% % plot(-d_10(:,2),d_10(:,1),'bx-')
% plot(D_10(:,2),D_10(:,1),'ro-')

% plot(-d_15(:,2),d_15(:,1),'bx-')
% plot(D_15(:,2),D_15(:,1),'go-')





fnplt(d05,'b-')
fnplt(d10,'r-')
fnplt(d15,'g-')
fnplt(d15_2,'c-')


figure(16)
clf
box on
hold on
fnplt(k05,'b-')
fnplt(k10,'r-')
fnplt(k15,'g-')
fnplt(k15_2,'c-')
% plot(D_05(:,1),'bx')
% plot(D_10(:,1),'rx')
% plot(D_15(:,1),'gx')



