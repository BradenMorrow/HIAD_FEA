% Cable stiffness directly from test
% June 10, 2016
p_r = .1;
fignum1 = 1;
alias1 = 20;
smooth_n = 5;
fignum2 = 2;
n = 3;
lim = .7;
%% Load test data
close all
load('C:\Users\irja.hepler\Desktop\Outputs\1016\dP.mat')
d0 = d;
P0 = P;


%%
% REMOVE LAST 10% OF DATA POINTS FOR D AND P
d(floor(size(d,1) - size(d,1)*p_r):end,:) = [];
P(floor(size(P,1) - size(P,1)*p_r):end,:) = [];

plot_d_P(d,P,fignum1)

% [d,I] = sort(d);
% P = P(I);
% Alias1 
d2 = zeros(alias1,16);
P2 = zeros(size(d2,1),16);
for j = 1:16
    [du,I] = unique(d(:,j));
    p = P(I,j);
    d2(:,j) = linspace(0,max(du),alias1)';
    P2(:,j) = interp1(du,p,d2(:,j),'linear','extrap');
end







%% Process test data
% Smooth data
for j = 1:16
    d2(:,j) = smooth(d2(:,j),smooth_n);
    P2(:,j) = smooth(P2(:,j),smooth_n);
end
for j = 1:16
    d2(:,j) = smooth(d2(:,j),smooth_n);
    P2(:,j) = smooth(P2(:,j),smooth_n);
end


% Zero first entry
d1 = d(1,:);
P1 = P(1,:);
for i = 1:size(d2,1)
    d2(i,:) = d2(i,:) - d1;
    P2(i,:) = P2(i,:) - P1 + 10;
end


<<<<<<< HEAD:HIAD_FE/analyses/16_04_19_tori/torus/cable_stiff_10JUN16.m
I0 = 0;
k0 = 1;
L = ones(16,1);
% % % L(1:8) = 70 - 24;
% % % L(1:16) = 70 - 16.85;
pp(16).d = [];
pp(16).k = [];
=======
% % % % Eliminate last entries
% % % d(end - end_i:end,:) = [];
% % % P(end - end_i:end,:) = [];
>>>>>>> origin/structure_visualization:analyses/16_04_19_tori/torus/cable_stiff_10JUN16.m

% Add ramp to 10 lb preload
d2 = d2 + .1;
d2 = [zeros(1,16); d2];
P2 = [zeros(1,16); P2];

% % % % Check for monotonic increasing values
% % % d_check = d(2:end,:) - d(1:end - 1,:) < 0;
% % % P_check = P(1:end - 1,:) - P(2:end,:) > 0;


<<<<<<< HEAD:HIAD_FE/analyses/16_04_19_tori/torus/cable_stiff_10JUN16.m
% % % % Save output
% % % save('cable_stiff','pp')
=======
>>>>>>> origin/structure_visualization:analyses/16_04_19_tori/torus/cable_stiff_10JUN16.m



% % % % Smooth aliased data
% % % smooth_n2 = 100;
% % % for j = 1:16
% % %     P2(:,j) = smooth(P2(:,j),smooth_n2);
% % % end
plot_d_P(d2,P2,fignum2)

% Alias2
% d3 = linspace(0,.7,20)';
% P3 = zeros(size(d3,1),16);
% for j = 1:16
%     P3(:,j) = interp1(d2(:,j),P2(:,j),d3,'linear','extrap');
% end

% Extrapolate
[d3,P3] = extrap(d2,P2,n,lim);

plot_d_P(d3,P3,fignum3)

% I0 = 0;
% k0 = 1;
% L = ones(16,1);
% % % % L(1:8) = 70 - 24;
% % % % L(1:16) = 70 - 16.85;
% pp(16).d = [];
% pp(16).k = [];
% 
% for i = 1:16
%     [pp(i).d,pp(i).k] = get_cable_pp3([P3(:,i) d3],I0,k0,L(i));
% end



% % % % Save output
% % % save('cable_stiff','pp')

%% Plotting
% figure(5)
% clf
% box on
% hold on
% xlim([0 .7])
% for j = 1:16
%     plot(d(:,j),P(:,j),'-','linewidth',5)
% end


% figure(2)
% clf
% box on
% hold on
% xlim([0 .7])
% for j = 1:16
%     plot(d2,P2(:,j),'x-')
% end


% figure(15)
% hold on
% plot(d3,P3(:,1),'b-')


