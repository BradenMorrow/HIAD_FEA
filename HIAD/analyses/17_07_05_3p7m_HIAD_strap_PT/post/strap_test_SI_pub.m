function strap_test_SI_pub(fig_1)
% Model and test strap load comparisons

Ffac_kN = 0.004448; % 1; % 
f2 = 1; % /0.004448;
% Ffac_kN = Ffac_kN*1000;



% close([200 204 214 215 216 217 218 221])

d = csvread('HAID Static Load Test -3.7m No TPS - Run[14] All 12 psi,No Tri-Torus,Cord Shunt.csv',1,0);
ram = d(:,102);
ram = ram - mean(ram(1:500));
ind = (542:1306)';

% % % a = mean(Ffac_kN*AP_T1T2(ind,:)')';

%% T1 - T2
% Aft
AP_T1T2 = d(:,11:14);
figure(fig_1 + 9 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*AP_T1T2(ind,:)')' - mean(Ffac_kN*AP_T1T2(1,:)')')
xlim([0 40]/f2)
ylim([0 500]/f2)

% Fore
FP_T1T2 = d(:,7:10);
figure(fig_1 + 12 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*FP_T1T2(ind,:)')' - mean(Ffac_kN*FP_T1T2(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)


%% T2 - T3
% Aft
AP_T2T3 = d(:,17:18);
figure(fig_1 + 2 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*AP_T2T3(ind,:)')' - mean(Ffac_kN*AP_T2T3(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)

% Fore
FP_T2T3 = d(:,15:16);
figure(fig_1 + 6 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*FP_T2T3(ind,:)')' - mean(Ffac_kN*FP_T2T3(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)


%% T3 - T4
% Aft
AP_T3T4 = d(:,22:23);
figure(fig_1 + 10 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*AP_T3T4(ind,:)')' - mean(Ffac_kN*AP_T3T4(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)

% Fore
FP_T3T4 = d(:,21);
figure(fig_1 + 13 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*FP_T3T4(ind,:)')' - mean(Ffac_kN*FP_T3T4(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)


%% T4 - T5
% Aft
AP_T4T5 = d(:,26:27);
figure(fig_1 + 3 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*AP_T4T5(ind,:)')' - mean(Ffac_kN*AP_T4T5(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)

% Fore
FP_T4T5 = d(:,24:25);
figure(fig_1 + 7 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*FP_T4T5(ind,:)')' - mean(Ffac_kN*FP_T4T5(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)


%% T5 - T6
% Aft
AP_T5T6 = d(:,30:31); %%%%%%%%%%%%%%%%
figure(fig_1 + 11 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*AP_T5T6(ind,:)')' - mean(Ffac_kN*AP_T5T6(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)

% Fore
FP_T5T6 = d(:,28:29);
figure(fig_1 + 14 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*FP_T5T6(ind,:)')' - mean(Ffac_kN*FP_T5T6(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)


%% T6 - T7
% Aft
AP_T6T7 = d(:,35:36);
figure(fig_1 + 4 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*AP_T6T7(ind,:)')' - mean(Ffac_kN*AP_T6T7(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)

% Fore
FP_T6T7 = d(:,32:33);
figure(fig_1 + 8 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*FP_T6T7(ind,:)')' - mean(Ffac_kN*FP_T6T7(1,:)')')
xlim([0 40]/f2)
ylim([0 2.5]/f2)


%% Fore radial straps
rad = d(:,3:6);
figure(fig_1 + 20 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*rad(ind,:)')' - mean(Ffac_kN*rad(1,:)')')
xlim([0 40]/f2)
ylim([0 3]/f2)


%% Fore chevron straps
chev = d(:,37:44);
figure(fig_1 + 21 - 1)
hold on
plot(-ram(ind)*Ffac_kN,mean(Ffac_kN*chev(ind,:)')' - mean(Ffac_kN*chev(1,:)')')
xlim([0 40]/f2)
ylim([0 3]/f2)




end

