function strap_test(fig_1)
% Model and test strap load comparisons

% close([200 204 214 215 216 217 218 221])

d = csvread('HAID Static Load Test -3.7m No TPS - Run[14] All 12 psi,No Tri-Torus,Cord Shunt.csv',1,0);
ram = d(:,102);
ram = ram - mean(ram(1:500));
ind = (542:1306)';


%% T1 - T2
% Aft
AP_T1T2 = d(:,11:14);
figure(fig_1 + 9 - 1)
hold on
plot(-ram(ind),AP_T1T2(ind,:))
xlim([0 8000])
ylim([0 500])

% Fore
FP_T1T2 = d(:,7:10);
figure(fig_1 + 12 - 1)
hold on
plot(-ram(ind),FP_T1T2(ind,:))
xlim([0 8000])
ylim([0 500])


%% T2 - T3
% Aft
AP_T2T3 = d(:,17:18);
figure(fig_1 + 2 - 1)
hold on
plot(-ram(ind),AP_T2T3(ind,:))
xlim([0 8000])
ylim([0 500])

% Fore
FP_T2T3 = d(:,15:16);
figure(fig_1 + 6 - 1)
hold on
plot(-ram(ind),FP_T2T3(ind,:))
xlim([0 8000])
ylim([0 500])


%% T3 - T4
% Aft
AP_T3T4 = d(:,22:23);
figure(fig_1 + 10 - 1)
hold on
plot(-ram(ind),AP_T3T4(ind,:))
xlim([0 8000])
ylim([0 500])

% Fore
FP_T3T4 = d(:,21);
figure(fig_1 + 13 - 1)
hold on
plot(-ram(ind),FP_T3T4(ind,:))
xlim([0 8000])
ylim([0 500])


%% T4 - T5
% Aft
AP_T4T5 = d(:,26:27);
figure(fig_1 + 3 - 1)
hold on
plot(-ram(ind),AP_T4T5(ind,:))
xlim([0 8000])
ylim([0 500])

% Fore
FP_T4T5 = d(:,24:25);
figure(fig_1 + 7 - 1)
hold on
plot(-ram(ind),FP_T4T5(ind,:))
xlim([0 8000])
ylim([0 500])


%% T5 - T6
% Aft
AP_T5T6 = d(:,30:31); %%%%%%%%%%%%%%%%
figure(fig_1 + 11 - 1)
hold on
plot(-ram(ind),AP_T5T6(ind,:))
xlim([0 8000])
ylim([0 500])

% Fore
FP_T5T6 = d(:,28:29);
figure(fig_1 + 14 - 1)
hold on
plot(-ram(ind),FP_T5T6(ind,:))
xlim([0 8000])
ylim([0 500])


%% T6 - T7
% Aft
AP_T6T7 = d(:,35:36);
figure(fig_1 + 4 - 1)
hold on
plot(-ram(ind),AP_T6T7(ind,:))
xlim([0 8000])
ylim([0 500])

% Fore
FP_T6T7 = d(:,32:33);
figure(fig_1 + 8 - 1)
hold on
plot(-ram(ind),FP_T6T7(ind,:))
xlim([0 8000])
ylim([0 500])


%% Fore radial straps
rad = d(:,3:6);
figure(fig_1 + 20 - 1)
hold on
plot(-ram(ind),rad(ind,:))
xlim([0 8000])
ylim([0 1000])


%% Fore chevron straps
chev = d(:,37:44);
figure(fig_1 + 21 - 1)
hold on
plot(-ram(ind),chev(ind,:))
xlim([0 8000])
ylim([0 1000])




end

