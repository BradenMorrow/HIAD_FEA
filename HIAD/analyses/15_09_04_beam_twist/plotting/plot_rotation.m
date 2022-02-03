% Plot analysis results on test results
Di = 104; %FEM.MODEL.Di;
% out = 1;

Ufac = 25.4;
Pfac = 0.004448;
Uvert = FEM_out.OUT.Uinc(Di,:)';
Uhor = FEM_out.OUT.Uinc(Di + 1,:)';

P = FEM_out.OUT.Finc(200,:)' + FEM_out.OUT.Finc(206,:)';

figure(2)
clf
box on
hold on

plot(-Uvert*Ufac,P*Pfac,'r-','linewidth',2.5)
plot(Uhor*Ufac,P*Pfac,'c-','linewidth',2.5)


% xlim([-40 120])
% ylim([0 3.5])
