% Analyze cord data
% June 22, 2017

clear
%% Load data
d0 = load('zylon_axial_table_update_06OCT16');

% Cord_typ
d1 = csvread('cord_typ_Test1.Stop.csv',1,0);
d2 = csvread('cord_typ_Test2.Stop.csv',1,0);
d3 = csvread('cord_typ_Test3.Stop.csv',1,0);
d4 = csvread('cord_typ_Test4.Stop.csv',1,0);

% Cord_sh
d5 = csvread('cord_sh_Test1.Stop.csv',1,0);
d6 = csvread('cord_sh_Test2.Stop.csv',1,0);
d7 = csvread('cord_sh_Test3.Stop.csv',1,0);
d8 = csvread('cord_sh_Test4.Stop.csv',1,0);

% Strap_1.75in
d9 = csvread('st_1p75in_Test1.Stop.csv',1,0);
d10 = csvread('st_1p75in_Test2.Stop.csv',1,0);
d11 = csvread('st_1p75in_Test3.Stop.csv',1,0);
d12 = csvread('st_1p75in_Test4.Stop.csv',1,0);

% Strap_2in
d13 = csvread('st_2in_Test1.Stop.csv',1,0);
d14 = csvread('st_2in_Test2.Stop.csv',1,0);
d15 = csvread('st_2in_Test3.Stop.csv',1,0);
d16 = csvread('st_2in_Test4.Stop.csv',1,0);


%% Plotting
load_fac = .004448;
dSI = [d1(:,9),d1(:,8)*load_fac];
dSI(:,1) = dSI(:,1) - dSI(1,1);
dSI(:,2) = dSI(:,2) - dSI(1,2);
dSI(177:223,:) = [];
dSI = [smooth(dSI(:,1),10), smooth(dSI(:,2),10)];

figure(1)
clf
box on
hold on
plot(dSI(:,1)*100,dSI(:,2),'k-')
% plot(dSI(:,1)*100,dSI(:,2))
% % plot(d2(:,9),d2(:,8))
% % plot(d3(:,9),d3(:,8))
% % plot(d4(:,9),d4(:,8))

xlabel('Strain (%)')
ylabel('Force (kN)')
% title('Cord, typical torus')
xlim([-.1 3])
ylim([-.1 7])

% % % figure(2)
% % % clf
% % % box on
% % % hold on
% % % plot(d5(:,9),d5(:,8))
% % % plot(d6(:,9),d6(:,8))
% % % plot(d7(:,9),d7(:,8))
% % % plot(d8(:,9),d8(:,8))
% % % 
% % % xlabel('Strain')
% % % ylabel('force (lbf)')
% % % title('Cord, shoulder torus')
% % % xlim([0 .045])
% % % ylim([0 2000])
% % % 
% % % figure(3)
% % % clf
% % % box on
% % % hold on
% % % plot(d9(:,9),d9(:,8))
% % % plot(d10(:,9),d10(:,8))
% % % plot(d11(:,9),d11(:,8))
% % % plot(d12(:,9),d12(:,8))
% % % 
% % % xlabel('Strain')
% % % ylabel('force (lbf)')
% % % title('1.75 inch strap')
% % % xlim([0 .045])
% % % ylim([0 2000])
% % % 
% % % figure(4)
% % % clf
% % % box on
% % % hold on
% % % plot(d13(:,9),d13(:,8))
% % % plot(d14(:,9),d14(:,8))
% % % plot(d15(:,9) - d15(1,9),d15(:,8))
% % % plot(d16(:,9),d16(:,8))
% % % 
% % % xlabel('Strain')
% % % ylabel('force (lbf)')
% % % title('2 inch strap')
% % % xlim([0 .045])
% % % ylim([0 2000])
% % % 
% % % figure(5)
% % % clf
% % % box on
% % % hold on
% % % plot(d9(:,9),d9(:,8),'k')
% % % plot(d14(:,9),d14(:,8))
% % % 
% % % figure(6)
% % % clf
% % % box on
% % % hold on
% % % plot(d1(:,9),d1(:,8))
% % % xlim([0 .02])
% % % ylim([0 1600])
% % % plot(d0(:,2) - .005,d0(:,1))


%% Cord_typ
% % % figure(8)
% % % clf
% % % box on
% % % hold on
% % % plot(d1(:,8),'o-')

dd1 = d1;
dd1(:,8) = smooth(dd1(:,8),3);
dd1(:,9) = smooth(dd1(:,9),3) - .008;
dd1(178:222,:) = [];


% % % figure(9)
% % % clf
% % % box on
% % % hold on
% % % plot(dd1(:,9) - .008,dd1(:,8),'-')


% % % figure(10)
% % % clf
% % % box on
% % % hold on
% % % plot(dd1(:,8),'o-')

% Compression
a0 = [-30000 -1000
    0 0];

% Unloading
ind1 = (1212:-1:1036)';
a1 = [smooth(dd1(ind1,8),10) smooth(dd1(ind1,9),10)];
Fc = 12*pi*4.95^2*(1 - 2*cotd(71)^2)/2;

f1 = interp1(a1(:,2),a1(:,1),linspace(a1(1,2),a1(end,2),25)');
a1 = [f1 linspace(a1(1,2),a1(end,2),25)'];

a1(:,2) = a1(:,2) - a1(1,2) + .001;

% At inflation pressure
a2 = [Fc (Fc - a1(end,1))*(a1(end,2) - a1(end - 1,2))/(a1(end,1) - a1(end - 1,1)) + a1(end,2)];

% Loading
ind2 = (1301:1530)';
a3 = dd1(ind2,[8 9]);
a3(:,2) = a3(:,2) + (a3(1,1) - Fc)/(a3(2,1) - a3(1,1))*(a3(2,2) - a3(1,2)) - (a3(1,2) - a2(end,2));
f3 = interp1(a3(:,2),a3(:,1),linspace(a3(1,2),a3(end,2),25)');
a3 = [f3 linspace(a3(1,2),a3(end,2),25)'];

% Loading extrapolation
a4 = [a3(end,1) + 1e6 a3(end,2) + (a3(end,2) - a3(end - 1,2))/(a3(end,1) - a3(end - 1,1))*1e6];

% Combine curves
a5 = [a0
    a1
    a2
    a3
    a4];

% % % figure(11)
% % % clf
% % % box on
% % % hold on
% % % plot(dd1(:,9) - .0161,dd1(:,8),'-')
% % % plot(a5(:,2),a5(:,1),'b--')
% % % plot(d0(:,2) - .0144,d0(:,1) - 17,'k-')
% % % xlim([0 .03])
% % % 
% % % xlabel('Strain')
% % % ylabel('force (lbf)')
% % % title('Cord response')
% % % xlim([0 .02])
% % % ylim([0 2000])

% Saved as: zylon_axial_table_typ


%% Cord_sh
% % % figure(12)
% % % clf
% % % box on
% % % hold on
% % % plot(d5(:,8),'o-')

dd5 = d5;
dd5(:,8) = smooth(dd5(:,8),3);
dd5(:,9) = smooth(dd5(:,9),3);
dd5(178:222,:) = [];


% % % figure(13)
% % % clf
% % % box on
% % % hold on
% % % plot(dd5(:,9) - .008,dd5(:,8),'-')


% % % figure(14)
% % % clf
% % % box on
% % % hold on
% % % plot(dd5(:,8),'o-')

% Compression
b0 = [-30000 -1000
    0 0];

% Unloading
ind1 = (581:-1:508)';
b1 = [smooth(dd5(ind1,8),10) smooth(dd5(ind1,9),10)];
Fc = 12*pi*1.75^2*(1 - 2*cotd(71)^2)/2;
b1(b1(:,1) >= Fc,:) = [];

f1 = interp1(b1(:,2),b1(:,1),linspace(b1(1,2),b1(end,2),10)');
b1 = [f1 linspace(b1(1,2),b1(end,2),10)'];

b1(:,2) = b1(:,2) - b1(1,2) + .001;


% At inflation pressure
b2 = [Fc (Fc - b1(end,1))*(b1(end,2) - b1(end - 1,2))/(b1(end,1) - b1(end - 1,1)) + b1(end,2)];

% Loading
ind2 = (615:902)';
b3 = dd5(ind2,[8 9]);
b3(:,2) = b3(:,2) + (b3(1,1) - Fc)/(b3(2,1) - b3(1,1))*(b3(2,2) - b3(1,2)) - (b3(1,2) - b2(end,2));
f3 = interp1(b3(:,2),b3(:,1),linspace(b3(1,2),b3(end,2),25)');
b3 = [f3 linspace(b3(1,2),b3(end,2),25)'];

% Loading extrapolation
b4 = [b3(end,1) + 1e6 b3(end,2) + (b3(end,2) - b3(end - 1,2))/(b3(end,1) - b3(end - 1,1))*1e6];

% Combine curves
b5 = [b0
    b1
    b2
    b3
    b4];

% % % figure(15)
% % % clf
% % % box on
% % % hold on
% % % plot(dd5(:,9),dd5(:,8),'-')
% % % plot(b5(:,2),b5(:,1),'o-')
% % % plot(d0(:,2) + .002,d0(:,1))
% % % xlim([0 .03])

% Saved as: zylon_axial_table_sh


%%
%% Strap 1.75 inch
% % % figure(16)
% % % clf
% % % box on
% % % hold on
% % % plot(d9(:,8),'o-')

dd9 = d9;
dd9(:,8) = smooth(dd9(:,8),3);
dd9(:,9) = smooth(dd9(:,9),3);


% % % figure(2)
% % % clf
% % % box on
% % % hold on
% % % plot(dd9(:,9),dd9(:,8),'-')


% % % figure(18)
% % % clf
% % % box on
% % % hold on
% % % plot(dd9(:,8),'o-')

% Compression
c0 = [-30000 -1000
    -30 -1
    0 0];

% Loading
ind1 = (79:270)';
c1 = [smooth(dd9(ind1,8),10) smooth(dd9(ind1,9),10)];
f1 = interp1(c1(:,2),c1(:,1),linspace(c1(1,2),c1(end,2),25)');
c1 = [f1 linspace(c1(1,2),c1(end,2),25)'];

ind2 = (1405:1603)';
c2 = [smooth(dd9(ind2,8),10) smooth(dd9(ind2,9),10)];
c2 = [c2(:,1) c2(:,2) - ((c2(1,2) - c1(end,2)) - (c2(1,1) - c1(end,1))*(c1(end,2) - c1(end - 1,2))/(c1(end,1) - c1(end - 1,1)))];
f2 = interp1(c2(:,2),c2(:,1),linspace(c2(1,2),c2(end,2),10)');
c2 = [f2 linspace(c2(1,2),c2(end,2),10)'];

% Loading extrapolation
c3 = [c2(end,1) + 1e6 c2(end,2) + (c2(end,2) - c2(end - 1,2))/(c2(end,1) - c2(end - 1,1))*1e6];

c4 = [c0
    c1
    c2
    c3];

c4(:,2) = c4(:,2)*1;
c4(c4(:,2) > 0,2) = c4(c4(:,2) > 0,2); % *1.17;

c = pchip(c4(:,2),c4(:,1));

% % % figure(19)
% % % clf
% % % box on
% % % hold on
% % % plot(dd9(:,9),dd9(:,8),'-')
% % % plot(c4(:,2),c4(:,1),'o-')
% % % fnplt(c,'b-')
% % % xlim([0 .045])

cord_response_1p75in = c;
% % % save('.\analyses\17_06_16_3p7m_HIAD_refine\define_system\cord\strap_1p75in','cord_response_1p75in')


%% Strap 2 inch
% % % figure(16)
% % % clf
% % % box on
% % % hold on
% % % plot(d15(:,8),'o-')
% % % 
% % % dd15 = d15;
% % % dd15(:,8) = smooth(dd15(:,8),3);
% % % dd15(:,9) = smooth(dd15(:,9),3);
% % % 
% % % 
% % % figure(20)
% % % clf
% % % box on
% % % hold on
% % % plot(dd15(:,9),dd15(:,8),'-')
% % % 
% % % 
% % % figure(21)
% % % clf
% % % box on
% % % hold on
% % % plot(dd15(:,8),'o-')
% % % 
% % % % Compression
% % % e0 = [-30000 -1000
% % %     -30 -1
% % %     0 0];
% % % 
% % % % Loading
% % % ind1 = (65:257)';
% % % e1 = [smooth(dd15(ind1,8),10) smooth(dd15(ind1,9),10)];
% % % f1 = interp1(e1(:,2),e1(:,1),linspace(e1(1,2),e1(end,2),25)');
% % % e1 = [f1 linspace(e1(1,2),e1(end,2),25)'];
% % % 
% % % ind2 = (1410:1607)';
% % % e2 = [smooth(dd15(ind2,8),10) smooth(dd15(ind2,9),10)];
% % % e2 = [e2(:,1) e2(:,2) - ((e2(1,2) - e1(end,2)) - (e2(1,1) - e1(end,1))*(e1(end,2) - e1(end - 1,2))/(e1(end,1) - e1(end - 1,1)))];
% % % f2 = interp1(e2(:,2),e2(:,1),linspace(e2(1,2),e2(end,2),10)');
% % % e2 = [f2 linspace(e2(1,2),e2(end,2),10)'];
% % % 
% % % e1(:,2) = e1(:,2) + .01;
% % % e2(:,2) = e2(:,2) + .01;
% % % 
% % % 
% % % % Loading extrapolation
% % % e3 = [e2(end,1) + 1e6 e2(end,2) + (e2(end,2) - e2(end - 1,2))/(e2(end,1) - e2(end - 1,1))*1e6];
% % % 
% % % e4 = [e0
% % %     e1
% % %     e2
% % %     e3];
% % % 
% % % e4(:,2) = e4(:,2)*1;
% % % 
% % % e = pchip(e4(:,2),e4(:,1));
% % % 
% % % figure(22)
% % % clf
% % % box on
% % % hold on
% % % plot(dd15(:,9) + .01,dd15(:,8),'-')
% % % plot(e4(:,2),e4(:,1),'o-')
% % % fnplt(e,'b-')
% % % xlim([0 .045])
% % % 
% % % cord_response_2in = e;
% % % save('.\analyses\17_06_16_3p7m_HIAD_refine\define_system\cord\strap_2in','cord_response_2in')
% % % 
% % % figure(23)
% % % clf
% % % box on
% % % hold on
% % % plot(c4(:,2),c4(:,1),'k-')
% % % plot(e4(:,2),e4(:,1),'b-')
% % % xlim([0 .15])
% % % ylim([0 10000])
% % % 
% % % xlabel('Strain')
% % % ylabel('force (lbf)')
% % % title('Strap response')
% % % % % % xlim([0 .045])
% % % % % % ylim([0 10000])
% % % 
% % % % close all


%% Strap 2 inch
% % % figure(16)
% % % clf
% % % box on
% % % hold on
% % % plot(d14(:,8),'o-')

dd15 = d14;
dd15(:,8) = smooth(dd15(:,8),3);
dd15(:,9) = smooth(dd15(:,9),3);

%%
ind1 = (1:271)';
ind2 = (1:262)';
r = [dd9(ind1,9)*100 dd9(ind1,8)*load_fac];
r(:,1) = r(:,1) - r(1,1);
r(:,2) = r(:,2) - r(1,2);
l = [dd15(ind2,9)*100 dd15(ind2,8)*load_fac];
l(:,1) = l(:,1) - l(1,1);
l(:,2) = l(:,2) - l(1,2);


figure(2)
clf
box on
hold on
plot(r(:,1),r(:,2),'k--','linewidth',1.5)
plot(l(:,1),l(:,2),'k-','linewidth',1.5)

xlabel('Strap strain (%)')
ylabel('Strap force (kN)')

xlim([-.1 3])
ylim([-.1 5])

legend('45 mm strap','50 mm strap','location','northwest')



%%
% % % figure(21)
% % % clf
% % % box on
% % % hold on
% % % plot(dd15(:,8),'o-')

% Compression
e0 = [-30000 -1000
    -30 -1
    0 0];

% Loading
ind1 = (60:257)';
e1 = [smooth(dd15(ind1,8),10) smooth(dd15(ind1,9),10)];
f1 = interp1(e1(:,2),e1(:,1),linspace(e1(1,2),e1(end,2),25)');
e1 = [f1 linspace(e1(1,2),e1(end,2),25)'];

ind2 = (1409:1605)';
e2 = [smooth(dd15(ind2,8),10) smooth(dd15(ind2,9),10)];
e2 = [e2(:,1) e2(:,2) - ((e2(1,2) - e1(end,2)) - (e2(1,1) - e1(end,1))*(e1(end,2) - e1(end - 1,2))/(e1(end,1) - e1(end - 1,1)))];
f2 = interp1(e2(:,2),e2(:,1),linspace(e2(1,2),e2(end,2),10)');
e2 = [f2 linspace(e2(1,2),e2(end,2),10)'];

e1(:,2) = e1(:,2) + .01;
e2(:,2) = e2(:,2) + .01;



% Loading extrapolation
e3 = [e2(end,1) + 1e6 e2(end,2) + (e2(end,2) - e2(end - 1,2))/(e2(end,1) - e2(end - 1,1))*1e6];

e4 = [e0
    e1
    e2
    e3];

e4(:,2) = e4(:,2)*1;
e4(e4(:,2) > 0,2) = e4(e4(:,2) > 0,2)*2.57;

e = pchip(e4(:,2),e4(:,1));

cord_response_2in_loop = e;
% % % save('.\analyses\17_06_16_3p7m_HIAD_refine\define_system\cord\strap_2in_loop','cord_response_2in_loop')




e4 = [e0
    e1
    e2
    e3];

e4(:,2) = e4(:,2)*1;
e4(e4(:,2) > 0,2) = e4(e4(:,2) > 0,2)*1.22;

e = pchip(e4(:,2),e4(:,1));

cord_response_2in_chev = e;
% % % save('.\analyses\17_06_16_3p7m_HIAD_refine\define_system\cord\strap_2in_chev','cord_response_2in_chev')



% % % figure(22)
% % % clf
% % % box on
% % % hold on
% % % plot(dd15(:,9) + .01,dd15(:,8),'-')
% % % plot(e4(:,2),e4(:,1),'o-')
% % % fnplt(e,'b-')
% % % xlim([0 .045])
% % % 
% % % figure(23)
% % % clf
% % % box on
% % % hold on
% % % plot(c4(:,2),c4(:,1),'k-')
% % % plot(e4(:,2),e4(:,1),'b-')
% % % xlim([0 .15])
% % % ylim([0 10000])
% % % 
% % % xlabel('Strain')
% % % ylabel('force (lbf)')
% % % title('Strap response')
% % % % % % xlim([0 .045])
% % % % % % ylim([0 10000])

% close all


%% Strap 1.75 inch
% % % figure(16)
% % % clf
% % % box on
% % % hold on
% % % plot(d9(:,8),'o-')
% % % 
% % % dd9 = d9;
% % % dd9(:,7) = smooth(dd9(:,7),3);
% % % dd9(:,8) = smooth(dd9(:,8),3);
% % % dd9(:,9) = smooth(dd9(:,9),3);
% % % 
% % % 
% % % figure(17)
% % % clf
% % % box on
% % % hold on
% % % plot(dd9(:,9),dd9(:,8),'k-')
% % % plot((dd9(:,7) - dd9(1,7))/12.5 + .01,dd9(:,8),'-')
% % % 
% % % 
% % % figure(18)
% % % clf
% % % box on
% % % hold on
% % % plot(dd9(:,8),'o-')
% % % 
% % % % Compression
% % % c0 = [-30000 -1000
% % %     -30 -1
% % %     0 0];
% % % 
% % % % Loading
% % % ind1 = (79:270)';
% % % c1 = [smooth(dd9(ind1,8),10) smooth((dd9(ind1,7) - dd9(1,7))/12.5,10)];
% % % f1 = interp1(c1(:,2),c1(:,1),linspace(c1(1,2),c1(end,2),25)');
% % % c1 = [f1 linspace(c1(1,2),c1(end,2),25)'];
% % % 
% % % ind2 = (1405:1603)';
% % % c2 = [smooth(dd9(ind2,8),10) smooth((dd9(ind2,7) - dd9(1,7))/12.5,10)];
% % % c2 = [c2(:,1) c2(:,2) - ((c2(1,2) - c1(end,2)) - (c2(1,1) - c1(end,1))*(c1(end,2) - c1(end - 1,2))/(c1(end,1) - c1(end - 1,1)))];
% % % f2 = interp1(c2(:,2),c2(:,1),linspace(c2(1,2),c2(end,2),10)');
% % % c2 = [f2 linspace(c2(1,2),c2(end,2),10)'];
% % % 
% % % % Loading extrapolation
% % % c3 = [c2(end,1) + 1e6 c2(end,2) + (c2(end,2) - c2(end - 1,2))/(c2(end,1) - c2(end - 1,1))*1e6];
% % % 
% % % c4 = [c0
% % %     c1
% % %     c2
% % %     c3];
% % % 
% % % c4(:,2) = c4(:,2)*1;
% % % 
% % % c = pchip(c4(:,2),c4(:,1));
% % % 
% % % figure(19)
% % % clf
% % % box on
% % % hold on
% % % plot(dd9(:,9) - .01,dd9(:,8),'-')
% % % plot(c4(:,2),c4(:,1),'o-')
% % % fnplt(c,'b-')
% % % xlim([0 .045])
% % % 
% % % cord_response_1p75in = c;
% % % save('.\analyses\17_06_16_3p7m_HIAD_refine\define_system\cord\strap_1p75in','cord_response_1p75in')
% % % 
% % % 
% % % %% Strap 2 inch
% % % figure(16)
% % % clf
% % % box on
% % % hold on
% % % plot(d15(:,8),'o-')
% % % 
% % % dd15 = d15;
% % % dd15(:,8) = smooth(dd15(:,8),3);
% % % dd15(:,9) = smooth(dd15(:,9),3);
% % % 
% % % 
% % % figure(20)
% % % clf
% % % box on
% % % hold on
% % % plot(dd15(:,9),dd15(:,8),'k-')
% % % plot((dd15(:,7) - dd15(1,7))/12.5 - .012,dd15(:,8),'-')
% % % 
% % % 
% % % figure(21)
% % % clf
% % % box on
% % % hold on
% % % plot(dd15(:,8),'o-')
% % % 
% % % % Compression
% % % e0 = [-30000 -1000
% % %     -30 -1
% % %     0 0];
% % % 
% % % % Loading
% % % ind1 = (65:257)';
% % % e1 = [smooth(dd15(ind1,8),10) smooth((dd15(ind1,7) - dd15(1,7))/12.5,10)];
% % % f1 = interp1(e1(:,2),e1(:,1),linspace(e1(1,2),e1(end,2),25)');
% % % e1 = [f1 linspace(e1(1,2),e1(end,2),25)'];
% % % 
% % % ind2 = (1410:1607)';
% % % e2 = [smooth(dd15(ind2,8),10) smooth((dd15(ind2,7) - dd15(1,7))/12.5,10)];
% % % e2 = [e2(:,1) e2(:,2) - ((e2(1,2) - e1(end,2)) - (e2(1,1) - e1(end,1))*(e1(end,2) - e1(end - 1,2))/(e1(end,1) - e1(end - 1,1)))];
% % % f2 = interp1(e2(:,2),e2(:,1),linspace(e2(1,2),e2(end,2),10)');
% % % e2 = [f2 linspace(e2(1,2),e2(end,2),10)'];
% % % 
% % % e1(:,2) = e1(:,2) + .01;
% % % e2(:,2) = e2(:,2) + .01;
% % % 
% % % 
% % % % Loading extrapolation
% % % e3 = [e2(end,1) + 1e6 e2(end,2) + (e2(end,2) - e2(end - 1,2))/(e2(end,1) - e2(end - 1,1))*1e6];
% % % 
% % % e4 = [e0
% % %     e1
% % %     e2
% % %     e3];
% % % 
% % % e4(:,2) = e4(:,2)*1;
% % % 
% % % e = pchip(e4(:,2),e4(:,1));
% % % 
% % % figure(22)
% % % clf
% % % box on
% % % hold on
% % % plot(dd15(:,9) + .02,dd15(:,8),'-')
% % % plot(e4(:,2),e4(:,1),'o-')
% % % fnplt(e,'b-')
% % % xlim([0 .045])
% % % 
% % % cord_response_2in = e;
% % % save('.\analyses\17_06_16_3p7m_HIAD_refine\define_system\cord\strap_2in','cord_response_2in')
% % % 
% % % figure(23)
% % % clf
% % % box on
% % % hold on
% % % plot(c4(:,2),c4(:,1),'k-')
% % % plot(e4(:,2),e4(:,1),'b-')
% % % xlim([0 .045])
% % % 
% % % % close all



























