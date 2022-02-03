function [strap_pp,ax_pt] = preproc_strap(strap,pt,comp_fac)

eps = (-.005:.00001:.003)';

% eps_bot = -.002;
% eps_top = .0003;
eps_bot = -.0005;
eps_top = .0004;


ax0 = load(strap);
ax0(1) = ax0(1)*comp_fac;
ax = ax0;
ax = [ax(1,:)
    interp1(ax(:,2),ax(:,1),eps_bot - .001) eps_bot - .001
    interp1(ax(:,2),ax(:,1),eps_bot) eps_bot
    interp1(ax(:,2),ax(:,1),eps_top) eps_top
%     interp1(ax(:,2),ax(:,1),eps_top + .0001) eps_top + .0001
    ax(3:end,:)];

% eps2 = [ax_chev(1,2) linspace(ax_chev(2,2),ax_chev(end - 2,2),100) ax_chev(end,2)]';
% ax_chev = [interp1(ax_chev(:,2),ax_chev(:,1),eps2) eps2];
ax(:,2) = ax(:,2) + eps_top;
ax_pt = [ax(:,1) - pt ax(:,2)]; % Drop by pt
ax_pchip = pchip(ax_pt(:,2),ax_pt(:,1),eps); % Interp P
ax_pt(:,2) = ax_pt(:,2) - pchip(ax_pchip,eps,0);

strap_pp = pchip(ax_pt(:,2),ax_pt(:,1));




end

