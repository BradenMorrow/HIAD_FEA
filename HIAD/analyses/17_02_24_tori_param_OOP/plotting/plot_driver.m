% Plots for publication
% March 2, 2017


% load('oop_an_E80_CSest_1p7_24FEB17.mat')
load('oop_an_E0_CSest_1p7_24FEB17.mat')
% load('oop_an_E80_CSest_LC_27FEB17.mat')







%%
fig = 30;
plot_oop_PU_02MAR17

%%
% plot_RZ_02MAR17(FEM_out0,32,1,'k--',1)
plot_RZ_02MAR17(FEM_out0,32,size(FEM_out0.OUT.Uinc,2),'b--',1)
plot_RZ_02MAR17(FEM_out2,32,size(FEM_out2.OUT.Uinc,2),'r--',1)

% plot_RZ_02MAR17(FEM_out0,33,1,'k--',25.4)
plot_RZ_02MAR17(FEM_out0,33,size(FEM_out0.OUT.Uinc,2),'b--',25.4)
plot_RZ_02MAR17(FEM_out2,33,size(FEM_out2.OUT.Uinc,2),'r--',25.4)

figure(fig + 3)
subplot(2,1,1)
ylim([1400 1575])

subplot(2,1,2)
ylim([-250 100])

leg_oop(1) = plot(0,0,'k-');
leg_oop(2) = plot(0,0,'b-');
leg_oop(3) = plot(0,0,'r-');
leg_oop(4) = plot(0,0,'b--','linewidth',1.5);
leg_oop(5) = plot(0,0,'r--','linewidth',1.5);

figure(33)
legend(leg_oop,'Initial',...
    'Out-of-plane load, test',...
    'In-plane load, test',...
    'Out-of-plane load, model',...
    'In-plane load, model',...
    'orientation','vertical',...
    'location','south')









%%
load('oop_an_E80_CSest_LC_27FEB17.mat')
fig = 30;
plot_oop_PU_02MAR17

% plot_RZ_02MAR17(FEM_out0,32,1,'k--',1)
plot_RZ_02MAR17(FEM_out0,32,size(FEM_out0.OUT.Uinc,2),'b--',1)
plot_RZ_02MAR17(FEM_out1,32,size(FEM_out1.OUT.Uinc,2),'r--',1)

% plot_RZ_02MAR17(FEM_out0,33,1,'k--',25.4)
plot_RZ_02MAR17(FEM_out0,33,size(FEM_out0.OUT.Uinc,2),'b--',25.4)
plot_RZ_02MAR17(FEM_out1,33,size(FEM_out1.OUT.Uinc,2),'r--',25.4)

figure(fig + 3)
subplot(2,1,1)
ylim([1250 1575])

subplot(2,1,2)
ylim([-250 100])

leg_oop(1) = plot(0,0,'k-');
leg_oop(2) = plot(0,0,'b-');
leg_oop(3) = plot(0,0,'r-');
leg_oop(4) = plot(0,0,'b--','linewidth',1.5);
leg_oop(5) = plot(0,0,'r--','linewidth',1.5);

figure(fig + 3)
subplot(2,1,1)

legend(leg_oop,'Initial',...
    'Out-of-plane load, test',...
    'In-plane load, test',...
    'Out-of-plane load, model',...
    'In-plane load, model',...
    'orientation','vertical',...
    'location','south')









%%
% Nominal
load('oop_an_E80_CSest_1p7_24FEB17.mat')
plot_PU_02MAR17(FEM_out2,31,25.4,4.448222/1000,'b-',2)

% Reduced Eg
load('oop_an_E0_CSest_1p7_24FEB17.mat')
plot_PU_02MAR17(FEM_out2,31,25.4,4.448222/1000,'b--',1)

% Rigid cables
load('oop_an_E80_CSrig_1p7_24FEB17.mat')
plot_PU_02MAR17(FEM_out2,31,25.4,4.448222/1000,'r-',2)

% % % % Load control
% % % load('oop_an_E80_CSest_LC_27FEB17.mat')
% % % plot_PU_02MAR17(FEM_out1,31,25.4,4.448222/1000,'r:',2)


leg_oop1(1) = plot(0,0,'k-');
leg_oop1(2) = plot(0,0,'b-');
leg_oop1(3) = plot(0,0,'b--');
leg_oop1(4) = plot(0,0,'r-');
% leg_oop1(5) = plot(0,0,'r:');

legend(leg_oop1,...
    'Test',...
    'Nominal model',...
    'Reduced shell modulus model',...
    'Rigid cables model')




