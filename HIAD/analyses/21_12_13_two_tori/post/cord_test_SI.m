function cord_test_SI(fig_1)
% Model and test strap load comparisons

Ffac_kN = 0.004448;
% Ffac_kN = Ffac_kN*1000;



% close([200 204 214 215 216 217 218 221])

d = csvread('HAID Static Load Test -3.7m No TPS - Run[14] All 12 psi,No Tri-Torus,Cord Shunt.csv',1,0);
ram = d(:,102);
ram = ram - mean(ram(1:500));
ind = (542:1306)';


%% T2
% Fore
CS_F_T2 = d(:,66:67);
CS_F_T2(:,1) = CS_F_T2(:,1) - CS_F_T2(1,1);
CS_F_T2(:,2) = CS_F_T2(:,2) - CS_F_T2(1,2);

figure(fig_1)
hold on
plot(-ram(ind)*Ffac_kN,CS_F_T2(ind,1)*100,'k-')
xlim([0 9000])
ylim([0 500])

% Fore
CS_A_T2 = d(:,82:83);
CS_A_T2(:,1) = CS_A_T2(:,1) - CS_A_T2(1,1);
CS_A_T2(:,2) = CS_A_T2(:,2) - CS_A_T2(1,2);

figure(fig_1)
hold on
plot(-ram(ind)*Ffac_kN,CS_A_T2(ind,1)*100,'r-')
% xlim([0 9000])
% ylim([0 2.5])


%% T7
% Fore
CS_F_T7 = d(:,76:77);
CS_F_T7(:,1) = CS_F_T7(:,1) - CS_F_T7(1,1);
CS_F_T7(:,2) = CS_F_T7(:,2) - CS_F_T7(1,2);

figure(fig_1 + 1)
hold on
plot(-ram(ind)*Ffac_kN,CS_F_T7(ind,1)*100,'k-')
xlim([0 9000])
% ylim([0 500])

% Fore
CS_A_T7 = d(:,100:101);
CS_A_T7(:,1) = CS_A_T7(:,1) - CS_A_T7(1,1);
CS_A_T7(:,2) = CS_A_T7(:,2) - CS_A_T7(1,2);

figure(fig_1 + 1)
hold on
plot(-ram(ind)*Ffac_kN,CS_A_T7(ind,1)*100,'r-')
% xlim([0 9000])
% ylim([0 2.5])


end

