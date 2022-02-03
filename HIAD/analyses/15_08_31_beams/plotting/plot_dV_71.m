% Plot the change in tube volume
% December 2, 2015

% Load beam output
load('C:\Users\andrew.young\Desktop\FE_code\flex_06NOV15\analysis\15_08_31_beams\plotting\dV_09DEC15_71.mat')

dV_L = [0; FEM_out.OUT.dV_L];
dV_H = [0; FEM_out.OUT.dV_H];
dV0 = [0; FEM_out.OUT.dV];
Uy = [0; -FEM_out.OUT.Uinc(end - 4,:)'];

% Interpolate
dV_L = interp1(Uy,dV_L,(0:.2:5)');
dV_H = interp1(Uy,dV_H,(0:.2:5)');
dV = dV_L + dV_H;

dV0 = interp1(Uy,dV0,(0:.2:5)');
Uy = (0:.2:5)';

% Plot
figure(102)
clf
box on
hold on

plot(Uy,dV_L,'b--')
plot(Uy,dV_H,'b-.')
plot(Uy,dV,'b-')
plot(Uy,dV0,'k:','linewidth',1.5)

xlim([0 5])
ylim([-200 150])

xlabel('Midspan deflection (in)')
ylabel('Total volume change (in^3)')




% Shell Output
dV_sh = [0,0.152202702290197,0.373732869677042,0.785123065559674,1.29611781489166,1.42955608680677,1.42947420021301,1.42718483289991,1.41756347329283,1.38467073704942,1.24977498722092,1.05070241648536,0.660151810459865,0.129361925069134,-0.848653195644147,-2.46680460251719,-4.61935207941588,-7.04631476164741,-7.64146063771477,-8.51213376458236,-9.77326341720072,-11.6160943115719,-13.7682421765485,-15.9065551621406,-18.0518806801429,-20.1973945779318,-22.3963377113896,-24.5715298503465]';
Uy_sh = -[0,-0.0819839020266667,-0.163823458693333,-0.282587480915556,-0.449220214248889,-0.545908080915556,-0.551561792026667,-0.560126980915556,-0.573249080915556,-0.593959825360000,-0.633368058693333,-0.676315547582223,-0.740332547582222,-0.822289036471111,-0.964194247582223,-1.17291706980444,-1.47704540313778,-1.87455829202667,-1.97873618091556,-2.13432673647111,-2.36483540313778,-2.70889962536000,-3.11672129202667,-3.52525095869333,-3.93494084758222,-4.34287073647111,-4.75949451424889,-5.16720962536000]';

% Interpolate for comparison with beam model
dV_sh = interp1(Uy_sh,dV_sh,(0:.2:5)');
Uy_sh = Uy;

% plot(Uy_sh,dV_sh,'g-')



legend('Beam model, \DeltaV_{longitudinal}', ...
    'Beam model, \DeltaV_{hoop}', ...
    'Beam model, \DeltaV_{total}', ...
    'Beam model, \pir^2(1 - 2\nu_{LH})', ...
    'location','southwest')




% % % % Formulas
% % % figure(103)
% % % clf
% % % box off
% % % axis off
% % % hold on
% % % 
% % % 
% % % 
% % % X = .2;
% % % Y = 0;
% % % dY = -5;
% % % text(X,Y,'$$ V_0 = 24,720\\\ in^3 $$','Interpreter','latex','fontsize',16)
% % % str1 = '$$ \Delta V_{beam-long} = A \Delta L = \pi r^2 \int_{L} \varepsilon (x) dx $$';
% % % text(X,Y + dY,str1,'Interpreter','latex','fontsize',16)
% % % str2 = '$$ \Delta V_{beam-hoop} = \Delta A L = \pi r^2 \int_{L} \varepsilon (x)\nu_{LH}[\varepsilon (x)\nu_{LH} - 2] dx $$';
% % % text(X,Y + 2*dY,str2,'Interpreter','latex','fontsize',16)
% % % str3 = '$$ \Delta V_{beam} =  \Delta V_{beam-long} + \Delta V_{beam-hoop}$$';
% % % text(X,Y + 3*dY,str3,'Interpreter','latex','fontsize',16)
% % % 
% % % xlim([0 100])
% % % ylim([6*dY -dY])












