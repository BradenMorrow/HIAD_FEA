% Get load/unload cord response for 71 deg torus, 6.7 inch minor diameter,
% two cords
% May 11, 2016

% Parameters
p = 20;
r = 6.7;
beta = 71;
n = 2;

% Compression stiffness
k_comp = 300; % (lb/in)

% Force in a cord
Fc = p*pi*r^2*(1 - 2*cotd(beta)^2)/n; % (lb)

% Loading and unloading curves
d_load = load('d_load.txt');
d_unload = load('d_unload.txt');

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
d0 = d';

% save lookup table
fid = fopen('axial_T4_20psi.txt','w');
fprintf(fid,'%0.10f %0.10f\n',d0(:));
fclose(fid);


% Plot
figure(10)
clf
box on
hold on
plot(d_load(:,2),d_load(:,1),'b-') % Load curve
plot(d_unload(:,2),d_unload(:,1),'g-') % Unload curve
plot(d_unload0(:,2),d_unload0(:,1),'c-') % Scaled unload curve
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


% Plot
figure(11)
clf
box on
hold on
plot(d(:,2),d(:,1),'k-') % Lookup table
plot(eps,Fc,'ko') % Lookup table

xlim([0 .025])
ylim([-100 2000])

xlabel('Strain')
ylabel('Cord force (lbf)')
