% Pre-process the torus load-cell data from test
% April 15, 2015
% Andy Young

% Load data
read_data = 1;
if read_data == 1
    d = dlmread('P_.1_Test2_proc');
    d(:,65:end) = [];
end

% Strap indices, start with bottom of strap 1, CCW around torus to obtain
% bottom of straps, Top of strap 1, CCW around torus again to obtain top of
% straps
ind = [(1:32)' (33:64)']';
ind = ind(:);
d_strap = d(:,ind);
t = linspace(0,10,size(d,1))';
d_strap(t > 3,:) = [];
t(t > 3) = [];

% Smooth data
for i = 1:size(d_strap,2)
    d_strap(:,i) = smooth(d_strap(:,i),150);
end

% Torus minor radius
r = 13.6/2; % Shell (minor) radius

% Initialize strap force and moment matrices for FE analysis
P_FE = zeros(size(d_strap,1),32);
M_FE = zeros(size(d_strap,1),32);

% Plot and calculate strap forces and moments
plot_data = 0;
str = 1; % Start with strap 1 (top and bottom), CCW around torus
for i = 1:2:64
    if plot_data == 1
        figure(str)
        clf
        box on
        hold on
        plot(t,d_strap(:,i),'b-')
        plot(t,d_strap(:,i + 1),'g-')

        xlabel('time')
        ylabel('load (lbf)')
        title(sprintf('Strap %g',str))
        legend('Bottom strap','Top strap'); %,'location','east')
        xlim([0 3])
        ylim([0 40])
    end
    
    % Strap forces and moments
    P_FE(:,str) = sum(d_strap(:,i:i + 1),2);
    M_FE(:,str) = (P_FE(:,str) - 2*d_strap(:,i + 1))*r;
    
    % Update strap number
    str = str + 1;
end

theta = linspace(0,2*pi - 2*pi/32,32)';
P_strap = zeros(32,6,size(d_strap,1));
M_strap = zeros(32,6,size(d_strap,1));
Z = zeros(32,1);
for i = 1:size(d_strap,1)
    P_strap(:,:,i) = [-P_FE(i,:)'.*cos(theta) -P_FE(i,:)'.*sin(theta) Z Z Z Z];
    M_strap(:,:,i) = [Z Z Z -M_FE(i,:)'.*sin(theta) M_FE(i,:)'.*cos(theta) Z];
end









