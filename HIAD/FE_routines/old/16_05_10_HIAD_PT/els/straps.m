function [MODEL,EL,strap_ind1] = straps(theta,I_theta,str)

% Preprocess strap geometry
% February 16, 2016

%% GENERAL
% Properties
t = .0285;
w = 2;
E_loop = 114000*t*w;
E_rad = 114000*t*w;
E_chev = 114000*t*w;

% [loop_f,loop_k] = lin_strap_response(114000,30,.001);
% [rad_f,rad_k] = lin_strap_response(99751,300,.001);
% [chev_f,chev_k] = lin_strap_response(114000,114000,.001);

[loop_f,loop_k] = strap_response(114000,300,50,2,1);
[rad_f,rad_k] = strap_response(99751,300,100,2,1);
[chev_f,chev_k] = strap_response(114000,114000,10,1,1);





% [ax_loop_interp] = preproc_strap('loop_straps',50,1);
% [ax_rad_interp] = preproc_strap('radial_straps',100,10000);
% [ax_chev_interp] = preproc_strap('chevron_straps',50,10000);

% [loop_f,loop_k] = lin_strap_response(114000,30,50);
% [rad_f,rad_k] = lin_strap_response(99751,300,100);
% [chev_f,chev_k] = lin_strap_response(114000,114000,10);



% loop_f = load('loop_straps');
% loop_f(:,1) = loop_f(:,1) - 50;
% loop_eps0 = interp1(loop_f(:,1),loop_f(:,2),0);
% loop_f(:,2) = loop_f(:,2) - loop_eps0;
% 
% rad_f = load('radial_straps');
% rad_f(:,1) = rad_f(:,1) - 100;
% rad_eps0 = interp1(rad_f(:,1),rad_f(:,2),0);
% rad_f(:,2) = rad_f(:,2) - rad_eps0;
% 
% chev_f = load('lin_chevron_straps');
% 
% loop_k = [300 -10000000000.05
%     300 0
%     114000 1e-8
%     114000 10000000000.05];
% loop_k(:,2) = loop_k(:,2) - loop_eps0;
% 
% rad_k = [300 -10000000000.05
%     300 0
%     114000 1e-8
%     114000 10000000000.05];
% rad_k(:,2) = rad_k(:,2) - rad_eps0;
% 
% chev_k = [114000 -10000000000.05
%     114000 10000000000.05];



% eps = (-.003:.00001:.003)';
% eps_bot = -.002;
% eps_top = .0003;
% ax_loop = load('loop_straps');
% ax_loop(1) = ax_loop(1)*5;
% ax_loop = [ax_loop(1,:)
%     interp1(ax_loop(:,2),ax_loop(:,1),eps_bot) eps_bot
%     interp1(ax_loop(:,2),ax_loop(:,1),eps_top) eps_top
%     ax_loop(3:end,:)];
% ax_loop(:,2) = ax_loop(:,2) + eps_top;
% ax_loop_pt = [ax_loop(:,1) - 50 ax_loop(:,2)]; % Drop by pt
% ax_loop_pchip = pchip(ax_loop_pt(:,2),ax_loop_pt(:,1),eps); % Interp P
% ax_loop_pt(:,2) = ax_loop_pt(:,2) - pchip(ax_loop_pchip,eps,0);
% ax_loop_interp = pchip(ax_loop_pt(:,2),ax_loop_pt(:,1));
% 
% ax_rad = load('radial_straps');
% ax_rad(1) = ax_rad(1)*100;
% ax_rad = [ax_rad(1,:)
%     interp1(ax_rad(:,2),ax_rad(:,1),eps_bot) eps_bot
%     interp1(ax_rad(:,2),ax_rad(:,1),eps_top) eps_top
%     ax_rad(3:end,:)];
% ax_rad(:,2) = ax_rad(:,2) + eps_top;
% ax_rad_pt = [ax_rad(:,1) - 100 ax_rad(:,2)]; % Drop by pt
% ax_rad_pchip = pchip(ax_rad_pt(:,2),ax_rad_pt(:,1),eps); % Interp P
% ax_rad_pt(:,2) = ax_rad_pt(:,2) - pchip(ax_rad_pchip,eps,0);
% ax_rad_interp = pchip(ax_rad_pt(:,2),ax_rad_pt(:,1));
% 
% ax_chev = load('chevron_straps');
% ax_chev(1) = ax_chev(1)*100;
% ax_chev = [ax_chev(1,:)
%     interp1(ax_chev(:,2),ax_chev(:,1),eps_bot) eps_bot
%     interp1(ax_chev(:,2),ax_chev(:,1),eps_top) eps_top
%     ax_chev(3:end,:)];
% ax_chev(:,2) = ax_chev(:,2) + eps_top;
% ax_chev_pt = [ax_chev(:,1) - 50 ax_chev(:,2)]; % Drop by pt
% ax_chev_pchip = pchip(ax_chev_pt(:,2),ax_chev_pt(:,1),eps); % Interp P
% ax_chev_pt(:,2) = ax_chev_pt(:,2) - pchip(ax_chev_pchip,eps,0);
% ax_chev_interp = pchip(ax_chev_pt(:,2),ax_chev_pt(:,1));

% % % strap_pt = [50 % Loop pretension (lbf)
% % %     100 % Radial pretension (lbf)
% % %     50]; % Chevron pretension (lbf)

A = t*w;
Izz = w*t^3/12;
Iyy = w^3*t/12;
J = .312*w*t^3;

% Geometry
c_link = str.c_link;
ind_tie = str.ind_tie;
ind_chev = str.ind_chev;
% N = str.N;

%% Nodes
% Centerbody nodes - AFT - loop1 and radial
th_aft = theta(I_theta(1:4:end)); % Theta location of AFT nodes
nodes_cb_aft = zeros(size(th_aft,1),3); % AFT nodes
nodes_cb_aft(:,1) = c_link(ind_tie(1),1)*cos(th_aft);
nodes_cb_aft(:,2) = c_link(ind_tie(1),1)*sin(th_aft);
nodes_cb_aft(:,3) = c_link(ind_tie(1),2);

% Centerbody nodes - FORE - loop1
th_fore1 = theta(I_theta(1:4:end)); % Theta location of FORE nodes
nodes_cb_fore1 = zeros(size(th_fore1,1),3); % FORE nodes
nodes_cb_fore1(:,1) = c_link(ind_tie(2),1)*cos(th_fore1);
nodes_cb_fore1(:,2) = c_link(ind_tie(2),1)*sin(th_fore1);
nodes_cb_fore1(:,3) = c_link(ind_tie(2),2);

% Centerbody nodes - FORE - radial
th_fore2 = theta(I_theta(3:4:end)); % Theta location of FORE nodes
nodes_cb_fore2 = zeros(size(th_fore2,1),3); % FORE nodes
nodes_cb_fore2(:,1) = c_link(ind_tie(2),1)*cos(th_fore2);
nodes_cb_fore2(:,2) = c_link(ind_tie(2),1)*sin(th_fore2);
nodes_cb_fore2(:,3) = c_link(ind_tie(2),2);

% Chevron nodes - AFT
nodes_chev_aft = zeros(size(th_aft,1),3); % AFT nodes
nodes_chev_aft(:,1) = c_link(ind_chev(1),1)*cos(th_aft);
nodes_chev_aft(:,2) = c_link(ind_chev(1),1)*sin(th_aft);
nodes_chev_aft(:,3) = c_link(ind_chev(1),2);

% Chevron nodes - Fore
nodes_chev_fore = zeros(size(th_fore2,1),3); % FORE nodes
nodes_chev_fore(:,1) = c_link(ind_chev(2),1)*cos(th_fore2);
nodes_chev_fore(:,2) = c_link(ind_chev(2),1)*sin(th_fore2);
nodes_chev_fore(:,3) = c_link(ind_chev(2),2);

% Consolidate nodes
nodes = [nodes_cb_aft
    nodes_cb_fore1
    nodes_cb_fore2
    nodes_chev_aft
    nodes_chev_fore];


%% ORIENTATION
orientation = zeros(size(nodes,1),3);
orientation(:,3) = 200;


%% CONNECTIVITIES
N = [size(theta,1)*7 (size(theta,1)*7 + 5*2*size(I_theta,1)/4 + 6*2*size(I_theta,1)/4 + 1*2*size(I_theta,1)/2)]; % [start_DOF end_DOF]
loop1 = [...
    (1:size(th_aft,1))' + size(th_aft,1)*0 + N(2) (1:size(th_aft,1))' + size(th_aft,1)*0 + N(1) % CB return
    (1:size(th_aft,1))' + size(th_aft,1)*1 + N(1) (1:size(th_aft,1))' + size(th_aft,1)*2 + N(1)
    (1:size(th_aft,1))' + size(th_aft,1)*3 + N(1) (1:size(th_aft,1))' + size(th_aft,1)*4 + N(1)
    (1:size(th_aft,1))' + size(th_aft,1)*1 + N(2)  (1:size(th_aft,1))' + size(th_aft,1)*5 + N(1) % CB return
    (1:size(th_aft,1))' + size(th_aft,1)*6 + N(1) (1:size(th_aft,1))' + size(th_aft,1)*7 + N(1)
    (1:size(th_aft,1))' + size(th_aft,1)*8 + N(1) (1:size(th_aft,1))' + size(th_aft,1)*9 + N(1)];

loop2 = [...
    (1:size(th_fore2,1))' + size(th_fore2,1)*10 + N(1) (1:size(th_fore2,1))' + size(th_fore2,1)*11 + N(1)
    (1:size(th_fore2,1))' + size(th_fore2,1)*12 + N(1) (1:size(th_fore2,1))' + size(th_fore2,1)*13 + N(1)
    (1:size(th_fore2,1))' + size(th_fore2,1)*14 + N(1) (1:size(th_fore2,1))' + size(th_fore2,1)*15 + N(1)
    (1:size(th_fore2,1))' + size(th_fore2,1)*16 + N(1) (1:size(th_fore2,1))' + size(th_fore2,1)*17 + N(1)
    (1:size(th_fore2,1))' + size(th_fore2,1)*18 + N(1) (1:size(th_fore2,1))' + size(th_fore2,1)*19 + N(1)
    (1:size(th_fore2,1))' + size(th_fore2,1)*20 + N(1) (1:size(th_fore2,1))' + size(th_fore2,1)*21 + N(1)];

chev_aft = [...
    (1:size(th_aft,1))' + size(th_aft,1)*0 + N(2) (1:size(th_aft,1))' + size(th_aft,1)*3 + N(2) % Radial
    (1:size(th_aft,1))' + size(th_aft,1)*3 + N(2) (1:2:size(th_aft,1)*2)' + size(th_aft,1)*22 + N(1) % Chev
    (1:size(th_aft,1))' + size(th_aft,1)*3 + N(2) [size(th_aft,1)*2 2:2:size(th_aft,1)*2 - 1]' + size(th_aft,1)*22 + N(1)]; % Chev

chev_fore = [...
    (1:size(th_fore1,1))' + size(th_fore1,1)*2 + N(2) (1:size(th_fore1,1))' + size(th_fore1,1)*4 + N(2) % Radial
    (1:size(th_fore1,1))' + size(th_fore1,1)*4 + N(2) (2:2:size(th_fore2,1)*2)' + size(th_fore2,1)*24 + N(1) % Chev
    (1:size(th_fore1,1))' + size(th_fore1,1)*4 + N(2) (1:2:size(th_fore2,1)*2 )' + size(th_fore2,1)*24 + N(1)]; % Chev

strap_ind = [ones(size(theta,1)/4*6,1)*1 % Loop1
    ones(size(theta,1)/4*6,1)*1 % Loop2
    ones(size(theta,1)/4,1)*2 % Radial aft
    ones(size(theta,1)/4*2,1)*3 % Chevron aft
    ones(size(theta,1)/4,1)*2 % Radial fore
    ones(size(theta,1)/4*2,1)*3]; % Chevron fore

strap_ind1 = [ones(size(theta,1)/4,1)*1 % Loop1 1 aft
    ones(size(theta,1)/4,1)*2 % Loop1 2 aft
    ones(size(theta,1)/4,1)*3 % Loop1 3 aft
    ones(size(theta,1)/4,1)*4 % Loop1 1 fore
    ones(size(theta,1)/4,1)*5 % Loop1 2 fore
    ones(size(theta,1)/4,1)*6 % Loop1 3 fore
    ones(size(theta,1)/4,1)*7 % Loop2 1 aft
    ones(size(theta,1)/4,1)*8 % Loop2 2 aft
    ones(size(theta,1)/4,1)*9 % Loop2 3 aft
    ones(size(theta,1)/4,1)*10 % Loop2 1 fore
    ones(size(theta,1)/4,1)*11 % Loop2 2 fore
    ones(size(theta,1)/4,1)*12 % Loop2 3 fore
    ones(size(theta,1)/4,1)*13 % Radial aft
    ones(size(theta,1)/4*2,1)*14 % Chevron aft
    ones(size(theta,1)/4,1)*15 % Radial fore
    ones(size(theta,1)/4*2,1)*16]; % Chevron fore

% Consolidate torus connectivities
connect = [loop1
    loop2
    chev_aft
    chev_fore];
connect = [connect 4*ones(size(connect,1),1)];


%% BOUNDARIES
b = zeros(size(nodes,1),6);
b(1:size(th_aft,1)*3,1:6) = 1;
% b(:,4:6) = 1;
% b(1:size(th_aft,1)*3,4:6) = 0;

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

Nint = 5; % Number of integration points (3 to 10)

for i = 1:size(connect,1)
    % Define element functions
    EL(i).el = @el4; % Corotational beam with axial lookup table

    % Element geometry
    EL(i).el_in.connect_ij = connect(i,1:2);

    % Special element input
    if strap_ind(i) == 1
        E = E_loop;
    elseif strap_ind(i) == 2
        E = E_rad;
    elseif strap_ind(i) == 3
        E = E_chev;
    end
    
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
    
%     if strap_ind1(i) == 13 || strap_ind1(i) == 14
%         EL(i).el_in0.geom = [A Izz Iyy 0 J]*10; % [A Izz Iyy ky J]
%     end
    
    if strap_ind(i) == 1
        % ax_loop_pt = [ax_loop(:,1) - strap_pt(strap_ind(i)) ax_loop(:,2) - interp1(ax_loop(:,1),ax_loop(:,2),strap_pt(strap_ind(i)))];
        % EL(i).el_in0.axial = ax_loop_interp;
        EL(i).el_in0.axial = loop_f;
        EL(i).el_in0.axial_k = loop_k;
        
        EL(i).el_in0.eps0 = 0;

    elseif strap_ind(i) == 2
        % ax_rad_pt = [ax_rad(:,1) - strap_pt(strap_ind(i)) ax_rad(:,2) - interp1(ax_rad(:,1),ax_rad(:,2),strap_pt(strap_ind(i)))];
        % EL(i).el_in0.axial = ax_rad_interp;
        EL(i).el_in0.axial = rad_f;
        EL(i).el_in0.axial_k = rad_k;
        
        EL(i).el_in0.eps0 = 0;
        
    elseif strap_ind(i) == 3
        % ax_chev_pt = [ax_chev(:,1) - strap_pt(strap_ind(i)) ax_chev(:,2) - interp1(ax_chev(:,1),ax_chev(:,2),strap_pt(strap_ind(i)))];
        % EL(i).el_in0.axial = ax_chev_interp;
        EL(i).el_in0.axial = chev_f;
        EL(i).el_in0.axial_k = chev_k;
        
        EL(i).el_in0.eps0 = 0;
        
    end
    
    
    
    
    
% % %     EL(i).el_in0.D0 = [0 0 0 0 0 0]';
% % %     EL(i).el_in0.P0 = [0 0 0 0 0 0]';
% % %     
% % %     EL(i).el_in0.n = Nint;
% % %     
% % %     % Initialize stored variables for fiber model
% % %     EL(i).el_in0.flex.K = zeros(5); % Element stiffness
% % %     EL(i).el_in0.flex.D = zeros(5,Nint); % Section forces
% % %     EL(i).el_in0.flex.Q = zeros(5,1); % Element forces
% % %     EL(i).el_in0.flex.f = zeros(5,5,Nint); % Section compliance matrices
% % %     EL(i).el_in0.flex.d = zeros(5,Nint); % Section deformations
% % %     EL(i).el_in0.flex.e = zeros(1,Nint); % Section fiber strains
% % %     
% % %     % Iterative or non-iterative state determination procedure
% % %     EL(i).el_in0.state_it = 1;
end


% % % %%
% % % figure(1)
% % % % clf
% % % % box on
% % % % axis off
% % % % axis equal
% % % hold on
% % % 
% % % for i = 1:size(nodes,1)
% % %     plot3(nodes(i,1),nodes(i,2),nodes(i,3),'ro')
% % % end
end
