function [MODEL,EL] = cables(theta,I_theta_cable)
% Generate properties and geometry of cable elements

%% GENERAL
% Properties
k0 = 114000; % Tension stiffness (lb/in)
k1 = 30; % Compression stiffness (lb/in)

% Cable response
t = .0285;
w = 2;

d_15 = load('15_psi.txt');
d_15(:,2) = d_15(:,2)/100;
% d_15 = load('15_psi.txt');
% d_15(:,2) = d_15(:,2);

I0 = 16;
k0 = 1;
L0 = 70 -  24;
L1 = 70 - 16.85;
[cable_f0,cable_k0] = get_cable_pp2(d_15,I0,k0,L0);
[cable_f1,cable_k1] = get_cable_pp2(d_15,I0,k0,L1);

% [cable_f0,cable_k0] = get_cable_pp(d_15,I0,k0,L0);
% [cable_f1,cable_k1] = get_cable_pp(d_15,I0,k0,L1);

% [cable_f,cable_k] = lin_strap_response(k0,k1,.0001);


E = 29e6;
r = 0; % .1;
A = pi*r^2;
Izz = pi/4*r^2; % w*t^3/12;
Iyy = pi/4*r^2; % w^3*t/12;
J = Izz + Iyy; % .312*w*t^3;


%% NODES
Rt = 16.85; % Radius to top pullies (in)
Rb = 24; % Radius to bottom pullies (in)
Pz = 14; % Distance between cables (in)

nodes = [Rb*cos(theta(I_theta_cable)) Rb*sin(theta(I_theta_cable)) -Pz/2*ones(size(I_theta_cable))
    Rt*cos(theta(I_theta_cable)) Rt*sin(theta(I_theta_cable)) Pz/2*ones(size(I_theta_cable))];


%% ORIENTATION
orientation = [zeros(size(nodes,1),2) 1e6*ones(size(nodes,1),1)];


%% CONNECTIVITIES
N = size(theta,1);
N0 = N + size(I_theta_cable,1)*1;
N1 = N + size(I_theta_cable,1)*2;
N2 = N + size(I_theta_cable,1)*3;
connect = [(N1 + 1:N1 + size(I_theta_cable,1))' (N + 1:N0)'
    (N2 + 1:N2 + size(I_theta_cable,1))' (N0 + 1:N1)'];
connect = [connect 4*ones(size(connect,1),1)];


%% BOUNDARIES
b = [zeros(size(nodes,1),3) ones(size(nodes,1),3)];
b = b';
bound = b(:);


%% LOADING
f = zeros(size(nodes,1),6);
f = f';
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

i0 = 1; %.70;
i1 = 1; %1.00;
for i = 1:size(connect,1)
    % Define element functions
    EL(i).el = @el4; % Linear, corotational beam

    % Element geometry
    EL(i).el_in.connect_ij = connect(i,1:2);

    % Special element input
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
    
%     % Axial response
%     EL(i).el_in0.axial = cable_f;
%     EL(i).el_in0.axial_k = cable_k;
    
    if i <= size(connect,1)/2
        
        d_in = d_15;
        d_in(:,2) = d_in(:,2)*(i0 + (i1 - i0).*rand(1));
        [cable_f0,cable_k0] = get_cable_pp2(d_in,I0,k0,L0);
        
        % Axial response
        EL(i).el_in0.axial = cable_f0;
        EL(i).el_in0.axial_k = cable_k0;
        
        

        
    else
        
        d_in = d_15;
        d_in(:,2) = d_in(:,2)*(i0 + (i1 - i0).*rand(1));
        [cable_f1,cable_k1] = get_cable_pp2(d_in,I0,k0,L1);
        
        % Axial response
        EL(i).el_in0.axial = cable_f1;
        EL(i).el_in0.axial_k = cable_k1;
    end
    
    
end



end