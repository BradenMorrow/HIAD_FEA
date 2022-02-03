function [FEM] = build_int(FEM,theta,C,tor,pre_str)
%% Generate properties and geometry for interaction elements
% Evenly spaced theta

%% Preallocate and declare variables
EL(size(theta,1)).el = [];
EL(size(theta,1)).el_in = [];
EL(size(theta,1)).el_in0.mat = [];
EL(size(theta,1)).el_in0.geom = [];
EL = EL';


%% Create interaction elements
for i = 1:(size(C,1) - 1)
    
    
    %% General Properties
    if i == 1
        L0 = tor(i).r;
        
        K_ax2 = tor(i).K_ax*2; % lbf/in/in
        K_ax_eq = K_ax2*L0; % Equivalent axial stiffness lbf/in
        K_ax = K_ax_eq*2*pi*C(i + 1)/size(theta,1); % Distribute to each node (assumes uniform nodal distribution) lbf/in
        
        K_sh_eq = tor(i).K_shear*8; % Stiffness (of half of member) lbf/in/in
        K_shear = K_sh_eq*2*pi*C(1)/size(theta,1); % Distribute to each node (assumes uniform nodal distribution)
        
    else
        r1 = tor(i - 1).r;
        r2 = tor(i).r;
        L0 = r1 + r2;
        
        K_ax1 = tor(i - 1).K_ax*2; % lbf/in/in
        K_ax2 = tor(i).K_ax*2; % lbf/in/in
        K_ax_eq = 1/(1/K_ax1 + 1/K_ax2)*L0; % Equivalent axial stiffness lbf/in
        K_ax = K_ax_eq*2*pi*C(i + 1)/size(theta,1); % Distribute to each node (assumes uniform nodal distribution) lbf/strain
        
        
        
        K_shear1 = tor(i - 1).K_shear*8; % Stiffness (of half of member) lbf/in/in
        K_shear2 = tor(i).K_shear*8; % Stiffness (of half of member) lbf/in/in
        
        % Find the equivalent shear stiffness of two section, treat like
        % a stepped cantelever beam
        d1 = 1/K_shear1 + 3*r2/(2*K_shear1*r1); % Deflection of first section due to a unit load (in*in) (deflection*unit width)
        d2 = 1/K_shear2; % Deflection of the second section due to a unit load (in*in)
        rot = 3/K_shear1*(1/(2*r1) + r2/r1^2); % Rotation at end of first section (rad*in)
        d3 = r2*rot; % Deflection of the second section due to a rotation at the end of the first section (in*in)
        K_sh_eq = 1/(d1 + d2 + d3); % lbf/in/in
        
        % K_sh_eq = 1/(1/K_shear1 + 3*r2/(r1*K_shear1) + 3*r2^2/(r1^2*K_shear1) + 1/K_shear2);
        K_shear = K_sh_eq*2*pi*C(1)/size(theta,1); % Distribute to each node
        
    end
    
    % Determine geometric properties
    E = 10e6; % Arbitralily fixed
    A = K_ax/E;
    Izz = K_shear*L0^3/(3*E);
    Iyy = pi/4*2^4;
    J = 1;
    
    
    %% NODES
    if i == 1 % For tieback
        % % % Must modify code for configuration other than a perfect
        % % %  circle
        x = C(1,1)*cos(theta);
        y = C(1,1)*sin(theta);
        z = C(1,2)*ones(size(theta));
        
        nodes = [x y z];
    else
        nodes = [];
    end
    
    
    %% ORIENTATION
    orientation = zeros(size(theta,1),3);
    orientation(:,3) = 1e6;
    
    
    %% CONNECTIVITIES
    if(i == 1)
        N = size(theta,1)*(size(tor,1));  % For tieback
        connect_i = [(1:size(theta,1))' (1:size(theta,1))'];
        connect_i(:,1) = connect_i(:,1) + N;
    else
        N = size(theta,1)*(i - 2);
        connect_i = [(1:size(theta,1))' (1:size(theta,1))' + size(theta,1)];
        connect_i = connect_i + N;
    end
    connect = [connect_i 4*ones(size(connect_i,1),1)];
    
    
    %% BOUNDARIES
    b = ones(size(nodes,1),6); % For tieback
    b = b';
    bound = b(:);
    
    
    %% LOADING
    f = zeros(size(nodes,1),6);
    f = f';
    F = f(:);
    
    
    %% ELEMENTS
    for j = 1:size(connect,1)
        EL(j).el_in0 = instantiate_EL; % Instatiate all element variables
        
        % Define element functions
        EL(j).el = 'el2'; % Linear, corotational beam
        
        % Special element input
        EL(j).el_in0.break = 0;
        EL(j).el_in0.mat = [E .3]; % [E nu]
        EL(j).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
        
        % Element prestrain
        EL(j).el_in0.eps0 = pre_str(i);
    end
    
    
    %% MODEL
    FEM.EL = [FEM.EL; EL];
    FEM.MODEL.nodes = [FEM.MODEL.nodes; nodes];
    FEM.MODEL.orientation = [FEM.MODEL.orientation; orientation];
    FEM.MODEL.connect = [FEM.MODEL.connect; connect];
    FEM.MODEL.B = [FEM.MODEL.B; bound];
    FEM.MODEL.F = [FEM.MODEL.F; F];
end


%% Set forces
FEM.MODEL.F_pre = FEM.MODEL.F*0;
FEM.MODEL.F_pt = [FEM.MODEL.F_pre FEM.MODEL.F];
end


