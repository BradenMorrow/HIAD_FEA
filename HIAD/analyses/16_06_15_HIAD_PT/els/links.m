function [MODEL,EL,str] = links(theta,I_theta,C,r)

% Preprocess link geometry
% February 12, 2016

% Loop strap set 1
%% GENERAL
% Properties
E = 10e6;
R = 1;
A = pi*R^2; % 50;
Izz = pi*R^4/4; % 200;
Iyy = pi*R^4/4; % 200;
J = pi*R^4/2; % 10;

% Geometry
% T5 - T6 aft tangents
dx = C(5,1) - C(6,1); % Distance between centers
dy = C(5,2) - C(6,2);
d = sqrt(dx^2 + dy^2);
alpha1 = -atand(dy/dx); % Angle from horizontal center to center
b = r(6)*d/(r(5) - r(6)); % Distance from T6 center to tangent line convergence point
alpha2 = atand(r(6)/b) + alpha1; % Angle from vertical to tangent point

% Link nodes cross section
c_link = [(C(1,1) - r(1)*cosd(20) - r(1)*sind(20)), (C(1,2) - r(1)*sind(20) + r(1)*cosd(20)) % Centerbody tieback - AFT
    (C(1,1) - r(1)*sind(20)), (C(1,2) + r(1)*cosd(20)) % T1 - AFT
    (C(2,1) - r(2)*sind(20)), (C(2,2) + r(2)*cosd(20)) % T2 - AFT
    ((C(2,1) + C(3,1))/2 - r(2)*sind(20)), ((C(2,2) + C(3,2))/2 + r(2)*cosd(20)) % T2/T3 chevron break - AFT
    (C(3,1) - r(3)*sind(20)), (C(3,2) + r(3)*cosd(20)) % T3 - AFT
    (C(4,1) - r(4)*sind(20)), (C(4,2) + r(4)*cosd(20)) % T4 - AFT
    (C(5,1) - r(5)*sind(20)), (C(5,2) + r(5)*cosd(20)) % T5_1 (T4 tie) - AFT
    (C(5,1) + r(5)*sind(alpha2)), (C(5,2) + r(5)*cosd(alpha2)) % T5_2 (T6 tie) - AFT
    (C(6,1) + r(6)*sind(alpha2)), (C(6,2) + r(6)*cosd(alpha2))% T6 - AFT
    (C(1,1) - r(1)*cosd(20) + r(1)*sind(20)), (C(1,2) - r(1)*sind(20) - r(1)*cosd(20)) % Centerbody tieback - FORE
    (C(1,1) + r(1)*sind(20)), (C(1,2) - r(1)*cosd(20)) % T1 - FORE
    (C(2,1) + r(2)*sind(20)), (C(2,2) - r(2)*cosd(20)) % T2 - FORE
    ((C(2,1) + C(3,1))/2 + r(2)*sind(20)), ((C(2,2) + C(3,2))/2 - r(2)*cosd(20)) % T2/T3 chevron break - FORE
    (C(3,1) + r(3)*sind(20)), (C(3,2) - r(3)*cosd(20)) % T3 - FORE
    (C(4,1) + r(4)*sind(20)), (C(4,2) - r(4)*cosd(20)) % T4 - FORE
    (C(5,1) + r(5)*sind(20)), (C(5,2) - r(5)*cosd(20)) % T5 - FORE
    (C(6,1) + r(6)*sind(20)), (C(6,2) - r(6)*cosd(20))]; % T6 - FORE

% Link indices
ind_tie = [1 10]';
ind_link1 = [2 3 5 6 7 11 12 14 15 16]';
ind_link2 = [2 3 5 6 8 9 11 12 14 15 16 17]';
ind_link_chev = [6 15]';
ind_chev = [4 13]';

% Indeces of tori
ind_tor = I_theta; % (1:size(theta,1))';



%% Nodes
% Links for loop strap set 1
th_loop1 = theta(I_theta(1:4:end)); % Theta location of loop straps set 1
nodes_loop1 = zeros(size(th_loop1,1)*size(ind_link1,1),3); % Preallocate nodal array
ind_tor1 = ind_tor(1:4:size(ind_tor,1)); % Indices on tori for connectivities
con_tor1 = [ind_tor1 + size(theta,1)*0 % Indices of torus nodes to connect to
    ind_tor1 + size(theta,1)*1
    ind_tor1 + size(theta,1)*2
    ind_tor1 + size(theta,1)*3
    ind_tor1 + size(theta,1)*4
    ind_tor1 + size(theta,1)*0
    ind_tor1 + size(theta,1)*1
    ind_tor1 + size(theta,1)*2
    ind_tor1 + size(theta,1)*3
    ind_tor1 + size(theta,1)*4];

% Loop through loop strap set 1 links
for i = 1:length(ind_link1);
    % Generate loop strap set 1 nodes
    nodes_loop1((1:size(th_loop1,1)) + (i - 1)*size(th_loop1,1),:) = ...
        [c_link(ind_link1(i),1)*cos(th_loop1) c_link(ind_link1(i),1)*sin(th_loop1) c_link(ind_link1(i),2)*ones(size(th_loop1,1),1)];
end

% Links for loop strap set 2
th_loop2 = theta(I_theta(3:4:end)); % Theta location of loop straps set 2
nodes_loop2 = zeros(size(th_loop2,1)*size(ind_link2,1),3); % Preallocate nodal array
ind_tor2 = ind_tor(3:4:size(ind_tor,1)); % Indices on tori for connectivities
con_tor2 = [ind_tor2 + size(ind_tor,1)*0 % Indices of torus nodes to connect to
    ind_tor2 + size(theta,1)*1
    ind_tor2 + size(theta,1)*2
    ind_tor2 + size(theta,1)*3
    ind_tor2 + size(theta,1)*4
    ind_tor2 + size(theta,1)*5
    ind_tor2 + size(theta,1)*0
    ind_tor2 + size(theta,1)*1
    ind_tor2 + size(theta,1)*2
    ind_tor2 + size(theta,1)*3
    ind_tor2 + size(theta,1)*4
    ind_tor2 + size(theta,1)*5];

% Loop through loop strap set 2 links
for i = 1:length(ind_link2);
    % Generate loop strap set 2 nodes
    nodes_loop2((1:size(th_loop2,1)) + (i - 1)*size(th_loop2,1),:) = ...
        [c_link(ind_link2(i),1)*cos(th_loop2) c_link(ind_link2(i),1)*sin(th_loop2) c_link(ind_link2(i),2)*ones(size(th_loop2,1),1)];
end

% Links for chevron straps
th_chev = theta(I_theta(2:2:end)); % Theta location of chevron straps set
nodes_chev = zeros(size(th_chev,1)*size(ind_link_chev,1),3); % Preallocate nodal array
ind_tor_chev = ind_tor(2:2:size(ind_tor,1)); % Indices on tori for connectivities
con_tor_chev = [ind_tor_chev + size(theta,1)*3 % Indices of torus nodes to connect to
    ind_tor_chev + size(theta,1)*3];

% Loop through loop strap set 2 links
for i = 1:length(ind_link_chev);
    % Generate loop chevron straps set nodes
    nodes_chev((1:size(th_chev,1)) + (i - 1)*size(th_chev,1),:) = ...
        [c_link(ind_link_chev(i),1)*cos(th_chev) c_link(ind_link_chev(i),1)*sin(th_chev) c_link(ind_link_chev(i),2)*ones(size(th_chev,1),1)];
end

% Consolidate nodes
nodes = [nodes_loop1
    nodes_loop2
    nodes_chev];


%% ORIENTATION
orientation = zeros(size(nodes,1),3);
orientation(:,3) = r(1)*cosd(20);


%% CONNECTIVITIES
% Consolidate torus connectivities
con_tor = [con_tor1
    con_tor2
    con_tor_chev];

N = size(theta,1)*7;
connect = [(1:size(nodes,1))' con_tor];
connect(:,1) = connect(:,1) + N;
connect = [connect 2*ones(size(connect,1),1)];


%% BOUNDARIES
b = zeros(size(nodes,1),6);
b = b';
bound = b(:);


%% LOADING
f = zeros(size(nodes,1),6);
F = f(:);


%% MODEL
MODEL.nodes = nodes;
MODEL.orientation = orientation;
MODEL.connect = connect;
MODEL.bound = bound;
MODEL.F = F;


%% ELEMENTS
% Preallocate element structure
EL(size(connect,1)).el = [];
EL(size(connect,1)).el_in.nodes_ij = [];
EL(size(connect,1)).el_in.orient_ij = [];
EL(size(connect,1)).el_in.connect_ij = [];
EL(size(connect,1)).el_in0.mat = [];
EL(size(connect,1)).el_in0.geom = [];
EL = EL';

for i = 1:size(connect,1)
    % Define element functions
    EL(i).el = @el2; % Linear, corotational beam

    % Special element input
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
end


% Output for strap generation
str.c_link = c_link;
str.ind_tie = ind_tie;
str.ind_chev = ind_chev;




% % % %% Visualize
% % % % Plot cross section
% % % figure(12)
% % % clf
% % % box on
% % % hold on
% % % axis equal
% % % 
% % % xlim([0 max(C(:,1))*1.1])
% % % ylim([0 (max(C(:,2)) + max(r))*1.1])
% % % 
% % % % Tori centers
% % % plot(C(:,1),C(:,2),'bx')
% % % 
% % % th = linspace(0,2*pi,100)';
% % % for i = 1:size(r,1)
% % %     plot(r(i)*cos(th) + C(i,1),r(i)*sin(th) + C(i,2),'b-')
% % %     text(C(i,1) - 12,C(i,2),strcat('T',num2str(i)))
% % % end
% % % 
% % % plot(c_link(:,1),c_link(:,2),'ko')
% % % 
% % % for i = 1:17
% % %     text(c_link(i,1) + 1,c_link(i,2) + 7,num2str(i))
% % % end

end
