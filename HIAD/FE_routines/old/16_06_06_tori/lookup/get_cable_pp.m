function [d_pp,k_pp] = get_cable_pp(d,I0,k0,L)
% Get a piecewise polynomial for cable

[D,I] = unique(-d(:,2)); % Find unique displacement values
D = [d(I) D];
D(1:I0,:) = []; % Eliminate initial data
D(:,2) = D(:,2)/L; % Change length to strain
D(:,1) = D(:,1) - D(1,1); % Zero data
D(:,2) = D(:,2) - D(1,2); %  + .005;
% D = [0 0; D];
D(D(2:end,1) - D(1:end - 1,1) < 0,:) = []; % Eliminate non increasing values
D = [interp1(D(:,2),D(:,1),linspace(0,D(end,2),1000)') linspace(0,D(end,2),1000)']; % Interpolate for more points and smooth
D(:,1) = smooth(D(:,1),50);
D = [interp1(D(:,2),D(:,1),linspace(0,D(end,2),25)') linspace(0,D(end,2),25)']; % Interpolate for less points
D = [-k0*1 -1 % Add compression stiffness
    D];

% Create piecewise polynomial and derivative
d_pp = pchip(D(:,2),D(:,1));
k_pp = fnder(d_pp,1);

%%
figure(15)
clf
box on
hold on
fnplt(d_pp,'c-')
% plot(D(:,2),D(:,1),'bx-')

xlim([-.001 .02])
ylim([-10 400])

xlabel('Strain')
ylabel('Load (lbf)')




%%
figure(16)
clf
box on
hold on
plot(D(:,2),D(:,1),'bx-')
plot(-d(:,2),d(:,1),'ro-')


end

