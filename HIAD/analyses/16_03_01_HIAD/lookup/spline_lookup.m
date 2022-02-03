% Create smooth lookup tables for straps
% March 9, 2016

d = load('loop_straps');










d2 = [d(1,:)
    interp1(d(:,2),d(:,1),-.002) -.002
    interp1(d(:,2),d(:,1),-.001) -.001
    interp1(d(:,2),d(:,1),.001) .001
    d(3:end,:)];
d2(:,2) = d2(:,2) + .001;

d3 = pchip(d2(:,2),d2(:,1));



eps = (-.01:.00001:.003)';
eps_bot = -.002;
eps_top = .0003;
ax_loop0 = load('loop_straps');
ax_loop = ax_loop0;
ax_loop(1) = ax_loop(1)*100;
ax_loop = [ax_loop(1,:)
    interp1(ax_loop(:,2),ax_loop(:,1),eps_bot) eps_bot
    interp1(ax_loop(:,2),ax_loop(:,1),eps_top) eps_top
    ax_loop(3:end,:)];
ax_loop(:,2) = ax_loop(:,2) + eps_top;
ax_loop_pt = [ax_loop(:,1) - 50 ax_loop(:,2)]; % Drop by pt
ax_loop_pchip = pchip(ax_loop_pt(:,2),ax_loop_pt(:,1),eps); % Interp P
ax_loop_pt(:,2) = ax_loop_pt(:,2) - pchip(ax_loop_pchip,eps,0);
ax_loop_interp = pchip(ax_loop_pt(:,2),ax_loop_pt(:,1));

ax_rad0 = load('radial_straps');
ax_rad = ax_rad0;
ax_rad(1) = ax_rad(1)*1000;
ax_rad = [ax_rad(1,:)
    interp1(ax_rad(:,2),ax_rad(:,1),eps_bot) eps_bot
    interp1(ax_rad(:,2),ax_rad(:,1),eps_top) eps_top
    ax_rad(3:end,:)];
ax_rad(:,2) = ax_rad(:,2) + eps_top;
ax_rad_pt = [ax_rad(:,1) - 100 ax_rad(:,2)]; % Drop by pt
ax_rad_pchip = pchip(ax_rad_pt(:,2),ax_rad_pt(:,1),eps); % Interp P
ax_rad_pt(:,2) = ax_rad_pt(:,2) - pchip(ax_rad_pchip,eps,0);
ax_rad_interp = pchip(ax_rad_pt(:,2),ax_rad_pt(:,1));

ax_chev0 = load('chevron_straps');
ax_chev0(1) = ax_chev0(1)*100;
% ax_chev = ax_chev0;
% ax_chev = [ax_chev(1,:)
%     interp1(ax_chev(:,2),ax_chev(:,1),eps_bot - .0001) eps_bot - .0001
%     interp1(ax_chev(:,2),ax_chev(:,1),eps_bot) eps_bot
%     interp1(ax_chev(:,2),ax_chev(:,1),eps_top) eps_top
%     interp1(ax_chev(:,2),ax_chev(:,1),eps_top + .0001) eps_top + .0001
%     ax_chev(3:end,:)];
% 
% % eps2 = [ax_chev(1,2) linspace(ax_chev(2,2),ax_chev(end - 2,2),100) ax_chev(end,2)]';
% % ax_chev = [interp1(ax_chev(:,2),ax_chev(:,1),eps2) eps2];
% ax_chev(:,2) = ax_chev(:,2) + eps_top;
% ax_chev_pt = [ax_chev(:,1) - 50 ax_chev(:,2)]; % Drop by pt
% ax_chev_pchip = pchip(ax_chev_pt(:,2),ax_chev_pt(:,1),eps); % Interp P
% ax_chev_pt(:,2) = ax_chev_pt(:,2) - pchip(ax_chev_pchip,eps,0);
% ax_chev_interp = pchip(ax_chev_pt(:,2),ax_chev_pt(:,1));



[ax_chev_interp,ax_chev_pt] = preproc_strap('chevron_straps',50,100);


figure(112)
clf
box on
hold on
% plot(d(:,2),d(:,1),'bx-')
% plot(d2(:,2),d2(:,1),'ro-')

% plot(eps,ppval(d3,eps),'g-')
% plot(ax_chev_pt(:,2),ax_chev_pt(:,1),'cx--')
% plot(ax_rad_pt(:,2),ax_rad_pt(:,1),'mx--')
% plot(ax_loop(:,2),ax_loop(:,1),'bx-')
% plot(ax_loop_pt(:,2),ax_loop_pt(:,1),'mx--')
% plot(eps,ax_loop_pchip,'g-')

% plot(ax_chev(:,2),ax_chev(:,1),'cx--')

plot(ax_chev_pt(:,2),ax_chev_pt(:,1),'cx--')
plot(eps,ppval(ax_chev_interp,eps),'r-')

% plot(eps,ppval(ax_rad_interp,eps),'m--')
% plot(eps,ppval(ax_loop_interp,eps),'g--')
% plot(0,0,'ko')


% % % eps2 = (-.005:.00001:.05)';
% % % % plot(ax_chev0(:,2),ax_chev0(:,1),'b-')
% % % plot(eps2 - ax_chev_pt(3,2),ppval(ax_chev_interp,eps2) - ax_chev_pt(3,1),'r-')


xlim([-.001 .01])
ylim([-60 1200])
xlabel('Strain')
ylabel('Force (lbf)')




%%
figure(113)
clf
box on
hold on
% plot(ax_chev_pt(:,2),ax_chev_pt(:,1),'cx--')
plot(ax_chev0(:,2),ax_chev0(:,1),'cx--')


eps_tot = (-.03:.0001:.06)';
plot(eps_tot - ax_chev_pt(3,2),ppval(ax_chev_interp,eps_tot) - ax_chev_pt(3,1),'r-')

xlim([-.002 .02])
ylim([-60 2000])
xlabel('Strain')
ylabel('Force (lbf)')


figure(114)
clf
box on
hold on
% plot(ax_chev_pt(:,2),ax_chev_pt(:,1),'cx--')
% plot(ax_chev0(:,2),ax_chev0(:,1),'c--')


eps_tot = (-.03:.0001:.03)';
plot(eps_tot,ppval(ax_chev_interp,eps_tot),'r-')



% [lin] = pchip([-1e10 1e10],[-1.14e+15 1.14e+15]);
% plot(eps_tot,ppval(lin,eps_tot),'g-')


% xlim([-.002 .002])
% ylim([-60 100])
xlabel('Strain')
ylabel('Force (lbf)')



figure(115)
clf
box on
hold on
ap = fnder(ax_chev_interp);
plot(eps_tot,ppval(ap,eps_tot),'b-')











%%
eps = [-.02 -.002 .002 .02]';
Pp = ppval(ap,eps);

Pp2 = pchip(eps,Pp);
Pp2.coefs(1,1:3) = 0;
Pp2.coefs(3,1:3) = 0;
% Pp2.breaks(2) = Pp2.breaks(2) - .0001;
% Pp2.breaks(3) = 0;


eps2 = linspace(-.03,.03,100000)';

P = fnint(Pp2,-55.4);
Pp4 = fnder(P);

figure(115)
plot(eps,Pp,'rx')
plot(eps2,ppval(Pp2,eps2),'g')
plot(eps2,ppval(Pp4,eps2),'b--')

figure(114)
plot(eps2,ppval(P,eps2),'b')
plot(eps - .002,ppval(P,eps - .002),'bx')
plot(0,0,'x')





%%
eps2 = (-.003:.00001:.003)';


tic
for i = 1:size(eps2,1)
    a = interp1(ax_chev_pt(:,2),ax_chev_pt(:,1),eps2(i));
end
toc_a = toc;

tic
for i = 1:size(eps2,1)
    b = ppval(ax_chev_interp,eps2(i));
end
toc_b = toc;


% ratio = toc_b/toc_a



