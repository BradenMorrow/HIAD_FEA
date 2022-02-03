function [pp] = cable_stiff_02DEC16(d,P,p_r,alias1,smooth_n,lim,fignum)
% cable_stiff_13JUL16
%   

%% Process test data
% Save original data
d0 = d;
P0 = P;

% Zero first entry
d1 = d(1,:);
P1 = P(1,:);
for i = 1:size(d0,1)
    d0(i,:) = d0(i,:) - d1;
    P0(i,:) = P0(i,:) - P1 + 10;
end

% Add ramp to 10 lb preload
d0 = d0 + .05;
d0 = [zeros(1,16); d0];
P0 = [zeros(1,16); P0];

% Removes last p_r of data points from d and P
d0(floor(size(d,1) - size(d,1)*p_r):end,:) = [];
P0(floor(size(P,1) - size(P,1)*p_r):end,:) = [];

% Alias1 
d2 = zeros(alias1,16);
P2 = zeros(size(d2,1),16);
for j = 1:16
    [du,I] = unique(d0(:,j));
    p = P0(I,j);
    d2(:,j) = linspace(0,max(du),alias1)';
    P2(:,j) = interp1(du,p,d2(:,j),'linear','extrap');
end

% Smooth data
for j = 1:16
    d2(:,j) = smooth(d2(:,j),smooth_n);
    P2(:,j) = smooth(P2(:,j),smooth_n);
    d2(:,j) = smooth(d2(:,j),smooth_n);
    P2(:,j) = smooth(P2(:,j),smooth_n);
end


% figure;plot(d2,P2)


% Extrapolate
P3 = zeros(1,16);
d3 = [d2; ones(1,size(d2,2))*lim];
for i = 1:16
    P3(i) = interp1(d2(:,i),P2(:,i),lim,'linear','extrap');
end
P3 = [P2;P3];

% % % % Zero first entry
% % % d1 = d(1,:);
% % % P1 = P(1,:);
% % % for i = 1:size(d3,1)
% % %     d3(i,:) = d3(i,:) - d1;
% % %     P3(i,:) = P3(i,:) - P1 + 10;
% % % end

% % % % Add ramp to 10 lb preload
% % % d3 = d3 + .1;
% % % d3 = [zeros(1,16); d3];
% % % P3 = [zeros(1,16); P3];

% Get polynomial
I0 = 0;
k0 = 1;
L = ones(16,1);
L(1:8) = 70 - 24;
L(9:16) = 70 - 16.85;
pp(16).d = [];
pp(16).k = [];

x = linspace(0,.04,100)'; % 0:.01:.7;
% % % figure(fignum)
% % % clf
% % % hold on 
% % % box on


remove = [0 0 0 0 0 0 0 0 10 0 0 12 11 0 0 10]';


for i = 1:16
% % %     figure(fignum)
% % %     plot(d0(:,i)./L(i),P0(:,i),'.-','linewidth',.5);
% % %     plot(d3(:,i)./L(i),P3(:,i),'.-','linewidth',.5);
    
    
    d4 = d3(:,i);
    P4 = P3(:,i);
    
    if remove(i) > 0
        d4(end - remove(i) + 1:end) = [];
        P4(end - remove(i) + 1:end) = [];
        
        ki = (P4(end) - P4(end - 1))/(d4(end) - d4(end - 1));
        d4 = [d4
            d4(end) + .02];
        P4 = [P4
            P4(end) + ki*.02];
    end
    
    
    plot(d4/L(i),P4,'.-','linewidth',.5);
    % Run function
% % %     if i == 3 || i == 2 || i == 11 || i == 10
% % %         fac = 10;
% % %     else
% % %         fac = 1;
% % %     end
    fac = 1;
    [pp(i).d,pp(i).k] = get_cable_pp_02DEC16([P4 d4*fac],I0,k0,L(i));
    
% % %     % Plot result
% % %     figure(fignum)
% % %     y = ppval(pp(i).d,x);
% % %     plot(x,y,'linewidth',2)
end
end

