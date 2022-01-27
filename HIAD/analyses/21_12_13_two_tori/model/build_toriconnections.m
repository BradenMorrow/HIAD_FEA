function [FEM] = build_toriconnections(FEM,C,tor)
for i = 1:length(tor)
%% Make Connections (need to clean & comment)
    con1 = [];
    con2 = [];
    con = [];
    count1 = 1;
    count2 = 1;
    
    % finding all tori nodes and adding their index + theta to new vector
    
    for i = 1:size(FEM.MODEL.nodes,1)
        [theta, rho] = cart2pol(FEM.MODEL.nodes(i,1), FEM.MODEL.nodes(i,2));
        if FEM.MODEL.nodes(i,3) == C(1,2) && rho == C(1,1) 
            con1(count1,:) = [i, theta];
            count1 = count1 + 1;
        end
        if FEM.MODEL.nodes(i,3) == C(2,2) && rho == C(2,1)
            con2(count2,:) = [i, theta];
            count2 = count2 + 1;
        end
    end

    % sorting by theta
    con1sort = sortrows(con1,2);
    con2sort = sortrows(con2, 2);

    % Making connections
    con(1,:) = [con1sort(end,1), con1sort(1,1)];
    for i = 1:size(con1sort)-1
        con(1+i,:) = [con1sort(i,1), con1sort(i+1,1)];
    end
    newL = length(con(:,1))+1;
    con(newL,:) = [con2sort(end,1), con2sort(1,1)];
    for i = 1:size(con2sort)-1
        con(newL+i,:) = [con2sort(i,1), con2sort(i+1,1)];
    end
    con = [con 5*ones(size(con,1),1)];

%% ORIENTATION
    orientation = FEM.MODEL.nodes(con(:,1),:);
    orientation(:,3) = orientation(:,3) + 100;
%% LOADING
    % % % Must modify code here in order to use a pressure distribution
    % % %  other than a constant pressure load.  For example, pressure
    % % %  distribution on a torus could be a Fourier summation or include 
    % % %  point loads

    EL(size(con,1),1).el = [];
    % EL(size(theta,1),1).el_in.nodes_ij = [];
    % EL(size(theta,1),1).el_in.orient_ij = [];
    EL(size(con,1),1).el_in = [];
    EL(size(con,1),1).el_in0.mat = [];
    EL(size(con,1),1).el_in0.geom = [];
        % Loop through elements
    for j = 1:size(con1sort)
        i = 1;
    
        EL(j).el_in0 = instantiate_EL; % Instatiate all element variables
        
        % Define element functions
        EL(j).el = 'el3'; % Pneumatic, corotational beam
        
        % Special element input
        EL(j).el_in0.break = 0;
        EL(j).el_in0.K0 = zeros(6,6);
        EL(j).el_in0.p = tor(i).p;
        EL(j).el_in0.r = tor(i).r;
        EL(j).el_in0.alpha = zeros(size(tor(i).alpha,1),tor(i).Nint);
        EL(j).el_in0.beta = tor(i).beta;
        
        EL(j).el_in0.eps = tor(i).eps0*ones(size(tor(i).alpha,1),2);
        EL(j).el_in0.f = tor(i).Fc*ones(size(tor(i).alpha,1),2);
        
        % Cord input
        for g = 1:tor(i).Nint % Loop through integration points
            for k = 1:length(tor(i).alpha) % Loop through each cord
                EL(j).el_in0.nodes(g).cords(k).axial = tor(i).d;
            end
            
            EL(j).el_in0.alpha(:,g) = tor(i).alpha;
        end
        
        EL(j).el_in0.propsLH = [tor(i).ELong 0 tor(i).GLH 0 1]'; % [ELong EHoop GLH nuHL 1]'; % Shell properties
        
        EL(j).el_in0.D0 = [0 0 0 0 0 0]';
        EL(j).el_in0.P0 = [0 0 0 0 0 0]';
        
        EL(j).el_in0.n = tor(i).Nint;
        
        % Initialize stored variables for fiber model
        EL(j).el_in0.flex.break = 0;
        EL(j).el_in0.flex.K = zeros(5); % Element stiffness
        EL(j).el_in0.flex.D = zeros(5,tor(i).Nint); % Section forces
        EL(j).el_in0.flex.Du = zeros(5,tor(i).Nint); % Unbalanced section forces
        EL(j).el_in0.flex.Q = zeros(5,1); % Element forces
        EL(j).el_in0.flex.f = zeros(5,5,tor(i).Nint); % Section compliance matrices
        EL(j).el_in0.flex.d = zeros(5,tor(i).Nint); % Section deformations
        EL(j).el_in0.flex.e = zeros(size(tor(i).alpha,1),tor(i).Nint) + tor(i).eps0; % Section fiber strains
        
        % Iterative or non-iterative state determination procedure
        EL(j).el_in0.state_it = tor(i).state_it;
    end
    for j = size(con1sort):size(con1sort)+size(con2sort)
        i = 2;
    
        EL(j).el_in0 = instantiate_EL; % Instatiate all element variables
        
        % Define element functions
        EL(j).el = 'el3'; % Pneumatic, corotational beam
        
        % Special element input
        EL(j).el_in0.break = 0;
        EL(j).el_in0.K0 = zeros(6,6);
        EL(j).el_in0.p = tor(i).p;
        EL(j).el_in0.r = tor(i).r;
        EL(j).el_in0.alpha = zeros(size(tor(i).alpha,1),tor(i).Nint);
        EL(j).el_in0.beta = tor(i).beta;
        
        EL(j).el_in0.eps = tor(i).eps0*ones(size(tor(i).alpha,1),2);
        EL(j).el_in0.f = tor(i).Fc*ones(size(tor(i).alpha,1),2);
        
        % Cord input
        for g = 1:tor(i).Nint % Loop through integration points
            for k = 1:length(tor(i).alpha) % Loop through each cord
                EL(j).el_in0.nodes(g).cords(k).axial = tor(i).d;
            end
            
            EL(j).el_in0.alpha(:,g) = tor(i).alpha;
        end
        
        EL(j).el_in0.propsLH = [tor(i).ELong 0 tor(i).GLH 0 1]'; % [ELong EHoop GLH nuHL 1]'; % Shell properties
        
        EL(j).el_in0.D0 = [0 0 0 0 0 0]';
        EL(j).el_in0.P0 = [0 0 0 0 0 0]';
        
        EL(j).el_in0.n = tor(i).Nint;
        
        % Initialize stored variables for fiber model
        EL(j).el_in0.flex.break = 0;
        EL(j).el_in0.flex.K = zeros(5); % Element stiffness
        EL(j).el_in0.flex.D = zeros(5,tor(i).Nint); % Section forces
        EL(j).el_in0.flex.Du = zeros(5,tor(i).Nint); % Unbalanced section forces
        EL(j).el_in0.flex.Q = zeros(5,1); % Element forces
        EL(j).el_in0.flex.f = zeros(5,5,tor(i).Nint); % Section compliance matrices
        EL(j).el_in0.flex.d = zeros(5,tor(i).Nint); % Section deformations
        EL(j).el_in0.flex.e = zeros(size(tor(i).alpha,1),tor(i).Nint) + tor(i).eps0; % Section fiber strains
        
        % Iterative or non-iterative state determination procedure
        EL(j).el_in0.state_it = tor(i).state_it;
    end
    FEM.MODEL.orientation = [FEM.MODEL.orientation; orientation];
    FEM.EL = [FEM.EL; EL];
    FEM.MODEL.connect = [FEM.MODEL.connect; con];
end