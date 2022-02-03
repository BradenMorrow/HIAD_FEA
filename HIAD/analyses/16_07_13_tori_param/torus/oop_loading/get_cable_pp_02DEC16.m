function [d_pp,k_pp] = get_cable_pp_02DEC16(d,I0,k0,L)
% Get a piecewise polynomial for cable

D = d;

% % % [D,I] = unique(d(:,2)); % Find unique displacement values
% % % D = [d(I) D];

% % % D(1:I0,:) = []; % Eliminate initial data

D(:,2) = D(:,2)/L; % Change displacement to strain

% % % D(:,1) = D(:,1) - D(1,1); % Zero data
% % % D(:,2) = D(:,2) - D(1,2);

% % % D(D(2:end,1) - D(1:end - 1,1) < 0,:) = []; % Eliminate non increasing values

D = [-k0*1 -1 % Add compression stiffness
    D];

% Create piecewise polynomial and derivative
d_pp = pchip(D(:,2),D(:,1));
k_pp = fnder(d_pp,1);




%% Starting with stiffness
n = 10;
eps = linspace(0,D(end,2),n)';
k = ppval(k_pp,eps);
eps = [eps; eps(end) + eps(end) - eps(end - 1)];
k = [k; k(end)];
k(1) = 0;
eps = [-1; eps];
k = [-k0*1; k];

n2 = 100;
eps0 = interp1(linspace(0,1,size(eps,1)),eps,linspace(0,1,n2)');
k0 = interp1(eps,k,eps0);
k0 = smooth(k0,10);
k1 = pchip(eps0,k0);

k2 = k1;
k2.coefs(:,4) = k2.coefs(:,4) + 1;
d0 = fnint(k2,0);
d0.coefs(:,5) = d0.coefs(:,5) - ppval(d0,0);




% % % d_pp = d0;
% % % k_pp = k1;



%%
% % % figure(15)
% % % clf
% % % box on
% % % hold on
% % % fnplt(d_pp,'c-')
% % % fnplt(d0,'k--')
% % % 
% % % xlabel('Strain')
% % % ylabel('Load (lbf)')
% % % % xlim([0 2])
% % % % ylim([0 500])
% % % 
% % % figure(16)
% % % % clf
% % % box on
% % % hold on
% % % fnplt(k_pp,'c-')
% % % plot(eps,k,'r-')
% % % plot(eps0,k0,'kx--')
% % % fnplt(k1,'g--')
% % % 
% % % xlabel('Strain')
% % % ylabel('Load (lbf)')




% % % x = linspace(-.005,.055,1000)';
% % % y = ppval(d0,x);
% % % figure(17)
% % % clf
% % % box on
% % % hold on
% % % plot(x,y,'b-')
% % % xlim([-.01 .06])
% % % ylim([-50 1000])
% % % 
% % % 
% % % x = linspace(-.005,.055,1000)';
% % % k = ppval(k1,x);
% % % figure(18)
% % % clf
% % % box on
% % % hold on
% % % plot(x,k,'b-')
% % % xlim([-.01 .06])
% % % % ylim([-50 1000])

% % % %%
% % % figure(17)
% % % clf
% % % box on
% % % hold on
% % % plot(D(:,2),D(:,1),'bx-')
% % % plot(-d(:,2),d(:,1),'ro-')



end

