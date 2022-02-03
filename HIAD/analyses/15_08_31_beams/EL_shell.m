% Calculate effective longitudinal stiffness


%%
p = 20; % Pressure
r0 = 6.7225; % Initial radius
beta = 59.75; % Initial braid angle
EL = 99.7821957804708; % Shell modulus
nuLH0 = cotd(beta)^2; % Initial Poisson's ratio
eps0 = .001; % Arbitrary strain
nuLH1 = nuLH0 + .003744*eps0;
% nuLH1 = cotd(59.716586)^2; nuLH0 + .003744*eps0*200;

% beta1 = acot(sqrt(nuLH1))*180/pi;
% beta2 = beta0 - 0.132879573028813*eps0;
% nuLH1 = cotd(beta - 0.0317)^2;




F0 = p*pi*r0^2*(1 - 2*nuLH0); % Initial reaction
dr = -r0*nuLH0*eps0; % Change in tube radius
r1 = r0 + dr;
F1 = p*pi*r1^2*(1 - 2*nuLH1) - EL*eps0*2*pi*r0;

dTeff = -(F1 - F0); % Effective change in tensile force
Eeff = dTeff/(2*pi*r0*eps0) % Effective modulus



% p*r0*(1 - 2*nuLH0)/eps0



% h0 = 2*pi*r0*cotd(beta); % Change in tube height
% h1 = h0 + h0*eps0;
% 
% beta1 = atand((2*pi*r1)/h1); % New braid angle
% nuLH1 = cotd(beta1)^2; % New Poisson's ratio
% 
% F1 = p*pi*r1^2*(1 - 2*nuLH1) - EL*eps0*2*pi*r0; % New reaction
% 
% dTeff = -(F1 - F0); % Effective change in tensile force
% Eeff = dTeff/(2*pi*r0*eps0) % Effective modulus
% % Eeff = 237.000342996301






%%
R = [1	-947.09
    1.1	-921.948
    1.2	-896.669
    1.3	-871.248
    1.4	-845.685
    1.5	-819.979
    1.6	-794.13
    1.7	-768.137
    1.8	-742
    1.9	-715.719
    2	-689.293];

R(:,1) = R(:,1) - 1;


r = 6.641;
L = 40;

E = (R(end,2) - R(1,2))/(2*pi*r0)*L;

figure(1)
clf
box on
hold on
plot(R(:,1)/40,R(:,2)/(2*pi*r0))

xlabel('Strain')
ylabel('Reaction force per circumferential length (lbf)')

xlim([0 .025])
ylim([-28 -12])



%%

E11 = [-0.00100479
0.00160425
0.00422217
0.00684899
0.00948473
0.0121294
0.014783
0.0174456
0.0201171
0.0227976
0.0254871];
E11 = E11 - E11(1);

E22 = [0.00757063
    0.00670725
    0.00584087
    0.0049715
    0.00409913
    0.00322375
    0.00234536
    0.00146396
    0.000579532
    -0.000307913
    -0.00119838];
E22 = E22 - E22(1);

nuLH_out = -E22./E11

beta_out = acotd(sqrt(nuLH_out))


figure(2)
clf
box on
hold on
plot(E11,nuLH_out)


dnu = (nuLH_out(5) - nuLH_out(4))/(E11(5) - E11(4))
dbeta = (beta_out(5) - beta_out(4))/(E11(5) - E11(4))




























