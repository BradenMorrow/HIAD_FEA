function [d] = cord_response(p,r,beta,n)
% Get load/unload cord response for 71 deg torus, 6.7 in minor diameter,
% May 11, 2016

% % % % Parameters
% % % p = 20;
% % % r = 6.7;
% % % beta = 71;
% % % n = 2;

% Compression stiffness
k_comp = 300; % (lb/in)

% Force in a cord
Fc = p*pi*r^2*(1 - 2*cotd(beta)^2)/n;

% Loading and unloading curves
d_load = load('d_load.txt');
d_unload = load('d_unload.txt');

un_scale = linspace(1,0,size(d_unload,1) - 3)';
d_unload1 = d_unload;
% d_unload(4:end,2) = d_unload(4:end,2) + un_scale*.0075;
% d_unload(4:end,2) = d_unload(4:end,2)*.75;
% d_unload(:,1) = d_unload(:,1)*interp1(d_load(:,2),d_load(:,1),d_unload(end,2))/d_unload(end,1);


% Interpolate for strain at inflation
eps = interp1(d_load(:,1),d_load(:,2),Fc);

% Scale unloading curve
d_unload0 = [d_unload(:,1)*Fc./d_unload(end,1) d_unload(:,2)*eps./d_unload(end,2)];
d_unload0(1,:) = [];

% Build cord force-strain relationship lookup table
d = [-k_comp*100 -100
    0 0
    d_unload0
    d_load(d_load(:,1) > Fc,:)];

% d(3:end,2) = d(3:end,2) + .05;

% % % cord = d';
% % % % save lookup table
% % % file = fopen(sprintf('%s.txt',fid),'w');
% % % fprintf(file,'%0.10f %0.10f\n',cord(:));
% % % fclose(file);


%% Plot
figure(10)
clf
box on
hold on
plot(d_load(:,2),d_load(:,1),'b-') % Load curve
plot(d_unload(:,2),d_unload(:,1),'g-') % Unload curve
plot(d_unload0(:,2),d_unload0(:,1),'c-') % Scaled unload curve
plot(d_unload1(:,2),d_unload1(:,1),'g--') % Scaled unload curve
plot(d(:,2),d(:,1),'k--') % Lookup table

xlim([-.005 .05])
ylim([-100 6000])

xlabel('Strain')
ylabel('Cord force (lbf)')
legend('Loading curve', ...
    'Unloading curve', ...
    'Scaled unloading curve', ...
    'Lookup table', ...
    'location','northwest')


end