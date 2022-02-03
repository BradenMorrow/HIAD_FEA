% Plot results of oop tests
% March 02, 2017

% % % fig = 30;
figure(fig) % PU eng
clf
figure(fig + 1) % PU SI
clf
figure(fig + 2) % Rtheta eng
clf
figure(fig + 3) % Rtheta SI
clf

U_oop = cell(2,1);
P_oop = cell(2,1);
cg_oop = cell(2,1);
cg_cyl_oop = cell(2,1);

load('oop1.mat')
d = csvread('oop1.txt',0,1);
ind = (1:801)';
[U_oop{1},P_oop{1},~,~,~,cg_cyl_oop{1},cg_oop{1}] = proc_torus(d,cgall,ind);
% PU(P_oop{1}(50:end,:),U_oop{1}(50:end,:),fig,'k-')
Rtheta(cg_cyl_oop{1},fig + 2,1,2)
Ztheta(cg_cyl_oop{1}(:,:,1),fig + 2,2,2,'k-')
Ztheta(cg_cyl_oop{1}(:,:,end),fig + 2,2,2,'b-')
% z_max(1) = zmax(cg_cyl_oop{1});
% k0 = get_k(P_oop{1}(50:end,:),U_oop{1}(50:end,:));


load('oop2.mat')
d = csvread('oop2.txt',0,1);
ind = (1:500)'; % (1:599)';
[U_oop{2},P_oop{2},~,~,~,cg_cyl_oop{2},cg_oop{2}] = proc_torus(d,cgall,ind);
PU(P_oop{2}(50:end,:),U_oop{2}(50:end,:),fig,'k-')
Rtheta2(cg_cyl_oop{2},fig + 2,1,2)
Ztheta(cg_cyl_oop{2}(:,:,end),fig + 2,2,2,'r-')
% z_max(1) = zmax(cg_cyl_oop{2});
% k0 = get_k(P_oop{2}(50:end,:),U_oop{2}(50:end,:));


%%
% % % figure(fig + 2)
% % % subplot(2,1,1)
% % % ylim([55 62])
% % % 
% % % subplot(2,1,2)
% % % ylim([-5 7])
% % % 
% % % leg_oop(1) = plot(0,0,'k-');
% % % leg_oop(2) = plot(0,0,'b-');
% % % leg_oop(3) = plot(0,0,'r-');
% % % 
% % % legend(leg_oop,'Initial','Out-of-plane load','In-plane load',...
% % %     'orientation','horizontal',...
% % %     'location','north')
% % % 
% % % figure(fig + 3)
% % % subplot(2,1,1)
% % % ylim([1400 1575])
% % % 
% % % subplot(2,1,2)
% % % ylim([-125 175])
% % % 
% % % leg_oop(1) = plot(0,0,'k-');
% % % leg_oop(2) = plot(0,0,'b-');
% % % leg_oop(3) = plot(0,0,'r-');
% % % 
% % % legend(leg_oop,'Initial','Out-of-plane load','In-plane load',...
% % %     'orientation','horizontal',...
% % %     'location','north')






