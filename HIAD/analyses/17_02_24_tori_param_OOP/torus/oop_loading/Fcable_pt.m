function [F_pt] = Fcable_pt(ind,theta,I_theta_cable,P)
% Apply recorded cable loads

%%

P(1:95,:) = [];

p0 = 10;

for i = 1:16
    P(:,i) = P(:,i) - P(1,i) + p0;
end

for i = 1:16
    P(:,i) = smooth(P(:,i),50);
end
P3 = P;

n = 1;
P3(end - 5:end,:) = [];
po = linspace(0,0,n)';
po(1) = [];
poi = zeros(16,n - 1);
k = zeros(16,1);
for i = 1:16
    k(i) = (P3(end,i) - P3(end - 30,i))/30;
    if k(i) < 0
        k(i) = 0;
    end
    poi(i,:) = P3(end,i) + po'*k(i);
end

n2 = 20;
pl = linspace(0,p0,n2)';
pl(end) = [];

P3 = [[pl pl pl pl pl pl pl pl pl pl pl pl pl pl pl pl]
    P3
    poi'];

P3 = P3*1;




% % % %%%
% % % P4 = P1;
% % % P4(1:85,:) = [];
% % % for i = 1:16
% % %     P4(:,i) = P4(:,i) - P4(1,i) + p0;
% % % end
% % % P3 = [[pl pl pl pl pl pl pl pl pl pl pl pl pl pl pl pl]
% % %     P4];
% % % P3(390:end,:) = [];
% % % 
% % % for i = 1:10
% % %     P5 = P3(end - 40:end,:);
% % %     for i = 1:16
% % %         P5(:,i) = P5(:,i) - P5(1,i) + P3(end,i);
% % %     end
% % %     P3 = [P3
% % %         P5];
% % % end
% % % 
% % % 
% % % Ptot = sum(P3,2);
% % % kP = (Ptot(420) - Ptot(410))/10;
% % % Ptot2 = Ptot;
% % % 
% % % for i = 420:size(Ptot,1)
% % %     Ptot2(i) = Ptot(419) + kP*(i - 419);
% % % end
% % % 
% % % P3(P3 < 0) = 0;
% % % 
% % % for i = 1:size(P3,1)
% % %     a = sum(P3(i,:));
% % %     if a > Ptot2(i)
% % %         P3(i,P3(i,:) > 0) = P3(i,P3(i,:) > 0) - (a - Ptot2(i))/sum(P3(i,:) > 0);
% % %     end
% % % end
% % % 
% % % P3(P3 < 0) = 0;





theta_cable = theta(I_theta_cable);
theta_cable = [theta_cable; theta_cable];

Pcos = P3*0;
Psin = P3*0;
Pfe = zeros(16*6,size(P3,1));
for i = 1:16
    Pcos(:,i) = P3(:,i)*cos(theta_cable(i));
    Psin(:,i) = P3(:,i)*sin(theta_cable(i));
    
    Pfe((i - 1)*6 + 1:(i - 1)*6 + 6,:) = [Pcos(:,i)'
        Psin(:,i)'
        zeros(size(Pcos(:,i)'))
        zeros(size(Pcos(:,i)'))
        zeros(size(Pcos(:,i)'))
        zeros(size(Pcos(:,i)'))];
end


F_pt = zeros(ind.ind8(end)*6,size(Pfe,2));
F_pt((ind.ind3(1) - 1)*6 + 1:(ind.ind3(end) - 1)*6 + 6,:) = -Pfe;

%%
figure(101)
clf
box on
hold on
% plot(P1)
% plot(P2)
for i = 1:16
    plot(linspace(0,1,size(P3,1))',P3(:,i),'-')
end

xlabel('Cable load step')
ylabel('Cable load (lbf)')

% % % figure(102)
% % % clf
% % % box on
% % % hold on
% % % plot(sum(P3,2))
% % % plot(Ptot2)
% F_pt = 1;
end

