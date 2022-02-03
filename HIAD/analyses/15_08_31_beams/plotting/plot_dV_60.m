% Plot the change in tube volume
% December 2, 2015

% Load beam output
% load('C:\Users\andrew.young\Desktop\FE_code\flex_06NOV15\analysis\15_08_31_beams\plotting\dV_05JAN16_60.mat')

dV_L = FEM_out.OUT.dV_L;
dV_H = FEM_out.OUT.dV_H;
dV2 = FEM_out.OUT.dV;
Uy = -FEM_out.OUT.Uinc(end - 4,:)';

% Interpolate
dV_L = interp1(Uy,dV_L,(0:.2:5)');
dV_H = interp1(Uy,dV_H,(0:.2:5)');
dV = dV_L + dV_H;
dV2 = interp1(Uy,dV2,(0:.2:5)');
Uy = (0:.2:5)';

% Plot
figure(102)
clf
box on
hold on

plot(Uy,dV_L,'b--')
plot(Uy,dV_H,'b-.')
plot(Uy,dV,'b-')
plot(Uy,dV2,'k:','linewidth',2)

xlim([0 5])
ylim([-200 150])

xlabel('Midspan deflection (in)')
ylabel('Total volume change (in^3)')




% Shell Output
dV_sh = -[0,0.383348038765689,0.787401630730528,1.22583697924165,1.76999562880155,2.61045446605203,3.38769132748166,4.23060408597667,5.56715228072699,7.63733811122893,10.0866932654271,10.6966374992480,11.6104313538817,12.9572834305463,14.9408511388983,17.0867653088762,19.1106527632510,21.0265821021458,22.9060141678183,24.7689050191366,25.2293991673423,25.9205302728305,26.9601750472084,28.5087387230906,30.3358329431312,32.1645405518339,33.9752531896329,35.7858207063791,37.5718225162718]';
Uy_sh = [0,0.212306822166667,0.421259755500000,0.635186588833333,0.856321422166667,1.07350168883333,1.17170435550000,1.26066335550000,1.39469735550000,1.59510168883333,1.83153335550000,1.89047802216667,1.97881935550000,2.11085902216667,2.31075402216667,2.54737135550000,2.78215002216667,3.01141135550000,3.23848302216667,3.46791302216667,3.52463235550000,3.60966235550000,3.73701268883333,3.92780735550000,4.15339935550000,4.37857568883333,4.60116102216667,4.82516002216667,5.04508535550000]';

% Interpolate for comparison with beam model
dV_sh = interp1(Uy_sh,dV_sh,(0:.2:5)');
Uy_sh = Uy;

plot(Uy_sh,dV_sh,'g-')
% plot([0 5],[0 0],'k--')



legend('Beam model, \DeltaV_{longitudinal}',...
    'Beam model, \DeltaV_{hoop}',...
    'Beam model, \DeltaV_{total}',...
    'Beam model, \pi r^2 (1 - 2 \nu_{LH})', ...
    'Shell model',...
    'location','southwest')




% Formulas
figure(103)
clf
box off
axis off
hold on



X = .2;
Y = 0;
dY = -5;
text(X,Y,'$$ V_0 = 24,720\\\ in^3 $$','Interpreter','latex','fontsize',16)
str1 = '$$ \Delta V_{beam-long} = A \Delta L = \pi r^2 \int_{L} \varepsilon (x) dx $$';
text(X,Y + dY,str1,'Interpreter','latex','fontsize',16)
str2 = '$$ \Delta V_{beam-hoop} = \Delta A L = \pi r^2 \int_{L} \varepsilon (x)\nu_{LH}[\varepsilon (x)\nu_{LH} - 2] dx $$';
text(X,Y + 2*dY,str2,'Interpreter','latex','fontsize',16)
str3 = '$$ \Delta V_{beam} =  \Delta V_{beam-long} + \Delta V_{beam-hoop}$$';
text(X,Y + 3*dY,str3,'Interpreter','latex','fontsize',16)
str4 = '$$ \Delta V_{beam-approx} = \pi r^2 (1 - 2 \nu_{LH}) \int_{L} \varepsilon (x) dx $$';
text(X,Y + 4*dY,str4,'Interpreter','latex','fontsize',16)

xlim([0 100])
ylim([6*dY -dY])












