% Calculate effective longitudinal stiffness and look at scaling
% January 16 2016

Egross = 225; % Gross modulus from tension torsion testing
rt = 6.641; % Specimen radius

p = 20; % Pressure
beta0 = 59.75; % Initial braid angle
EL = 99.7821957804708; % Shell modulus
r0 = 6.7225; % Initial radius

% Beam scale
[Eeff] = get_Eeff(p,beta0,EL,r0);

% One meter scale
r_scale = 39.37/2;
[Eeff_1m] = get_Eeff(p,beta0,EL,r_scale);



%% Shell FE results
% From shell model
k_ab = [0	-8732.63
    .1	-8656.37
    .2	-8579.76
    .3	-8502.99
    .4	-8426.03
    .5	-8348.88
    .6	-8271.56
    .7	-8194.04
    .8	-8116.35
    .9	-8038.47
    1	-7960.41];

figure(1)
clf
box on
hold on
plot(k_ab(:,1)/80,k_ab(:,2))


Eeff_FE = (k_ab(end,2) - k_ab(1,2))/(2*pi*r0)*80;



%% Effect of diameter
r = (0:20)';
r(1) = .000001;
[Eeff_scale] = get_Eeff(p,beta0,EL,r);


figure(2)
clf
box on
hold on
plot(r,Eeff_scale,'b-')

xlabel('Tube radius (in)')
ylabel('Effective shell stiffness (lb/in)')

% plot(r0,Eeff,'rx')
% plot(rt,Egross,'go')

ylim([0 600])









