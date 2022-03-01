function [FEM,strap_type,strap_EL_1] = build_links_straps(FEM,theta,tor,straps)
%% Preprocess link geometry
straps = straps(1:2);

%% GENERAL
% Theta tolerance
tol = 1e-12;

% Properties for link elements
E = 10e6;
R = 1;
A = pi*R^2;
Izz = pi*R^4/4;
Iyy = pi*R^4/4;
J = pi*R^4/2;

% Instantiate
r = [tor.r]'; % Radius of tori
c_link = zeros(size(straps,1)-1,4); % Preallocate

%% Create nodes
% Preallocate nodal matrix
join_master = [straps.join]';
join_master = join_master(3:3:end);
num_straps = [straps.num_straps]';
nodes = zeros(sum(num_straps(join_master == 0))*2 + sum(num_straps(join_master == 1)),8);
node_i = 1;

join_ID = [];
nodes_1 = [];
nodes_2 = [];

for i = 1:size(straps,1)
    
    
    % Theta vector for node 1
    theta_1 = linspace(straps(i).theta0,straps(i).theta0 + 2*pi,straps(i).num_straps + 1)';
    theta_1(theta_1 >= 2*pi) = theta_1(theta_1 >= 2*pi) - 2*pi;
    theta_1(theta_1 < 0) = theta_1(theta_1 < 0) + 2*pi;
    theta_1(end) = [];
    theta_1 = round(theta_1/tol)*tol;
    
    % Theta vector for node 2
    theta_2 = linspace(straps(i).theta0 + straps(i).theta_sweep,straps(i).theta0 + straps(i).theta_sweep + 2*pi,straps(i).num_straps + 1)';
    theta_2(theta_2 >= 2*pi) = theta_2(theta_2 >= 2*pi) - 2*pi;
    theta_2(theta_2 < 0) = theta_2(theta_2 < 0) + 2*pi;
    theta_2(end) = [];
    theta_2 = round(theta_2/tol)*tol;
    
    [~, ind] = intersect(theta, theta_1);
    ind2 = ind+length(theta);
    tori_nodes = FEM.MODEL.nodes(ind,:);
    tori_nodes2 = FEM.MODEL.nodes(ind2,:);
    tangent_nodes = [sqrt((tori_nodes(:,1).^2)+tori_nodes(:,2).^2) tori_nodes(:,3)];
    tangent_nodes2 = [sqrt((tori_nodes2(:,1).^2)+tori_nodes2(:,2).^2) tori_nodes2(:,3)];

    for j = 1:num_straps
        tangent = circle_tan([[tangent_nodes(j,1), tangent_nodes(j,2)], [tangent_nodes2(j,1), tangent_nodes2(j,2)]], [r(1) r(2)], straps(i).side);
        % % % Must modify Node 1 and Node 2 locations to coincide with location
        % % %  of tori for a configuration other than a perfect circle
        % Node 1
       %     if sum(straps(i).join(1) == join_ID) == 0 % If nodes have not been created yet
        if straps(i).join(1) == 0 || straps(i).join(3) == 0 % If nodes have not been created yet
            % Create nodes [x y z tor theta strap_set node_ij bound]
            nodes_1(j,:) = [tangent(1,1)*cos(theta_1(j))
                tangent(1,1)*sin(theta_1(j))
                tangent(1,2)*ones(size(theta_1(j)))
                straps(i).con(1)*1
                theta_1(j)'
                i*1
                1*1
                straps(i).bound1*1];
        end
        
        % Node 2
    %     if sum(straps(i).join(2) == join_ID) == 0 % If nodes have not been created yet
        if straps(i).join(2) == 0 || straps(i).join(3) == 0 % If nodes have not been created yet
            % Create nodes [x y z tor theta strap_set node_ij bound]
            nodes_2(j,:) = [tangent(2,1)*cos(theta_2(j))
                tangent(2,1)*sin(theta_2(j))'
                tangent(2,2)*1
                straps(i).con(2)*1
                theta_2(j)
                i*1
                2*1
                straps(i).bound2*1];
        end
    end
    
    % Add to nodal matrix
    nodes_i = [nodes_1; nodes_2];
    nodes(node_i:node_i + size(nodes_i,1) - 1,:) = nodes_i;
    
    % Reset
    nodes_1 = [];
    nodes_2 = [];
    node_i = node_i + size(nodes_i,1);
end

%% Connectivities
N = size(FEM.MODEL.nodes,1); % Number of nodes prior to link and straps

% Rigid links
% Initialize
con_link = zeros(size(nodes(nodes(:,4) ~= 0),1),2); % Preallocate
torus_ind = (1:size(theta,1))';
count = 1;

for i = 1:size(nodes,1)
    if nodes(i,4) ~= 0 % If a link node
        theta_ind = size(theta,1)*(nodes(i,4) - 1) + torus_ind(theta == nodes(i,5)); % Find the coresponding torus node
        con_link(count,:) = [theta_ind  N + i]; % From torus node to tangent strap node
        
        count = count + 1; % Update counter
    end
end

con_link = [con_link 2*ones(size(con_link,1),1)];

% Straps
% initialize
con_strap = zeros(sum(num_straps),2); % zeros(sum(num_straps),2);
strap_type = zeros(max(num_straps),size(straps,1));
nodes_ind = (1:size(nodes,1))';

for i = 1:size(straps,1)
    
    % First strap node
    con1 = nodes_ind(nodes(:,6) == i & nodes(:,7) == 1);
    if isempty(con1) % If the first node isn't unique
        ii = straps(i).join(3); % Look for the node
        join_id = straps(i).join(1);
        node_id = 1:2;
        node_id = node_id(straps(ii).join(1:2) == join_id);
        con1 = nodes_ind(nodes(:,6) == ii & nodes(:,7) == node_id);
    end
    
    if straps(i).join(3) ~= 0 && straps(i).join(1) ~= 0 % If the first node isn't unique
        ii = straps(i).join(3); % Look for the node
        node_id = 1:2;
        node_id = node_id(straps(ii).join(1:2) == 1);
        con1 = nodes_ind(nodes(:,6) == ii & nodes(:,7) == node_id);
        
        % nodes(nodes(:,6) == i & nodes(:,7) == 1,:) = [];
    end
    
    % Second strap node
    con2 = nodes_ind(nodes(:,6) == i & nodes(:,7) == 2);
    if isempty(con2) % If the second node isn't unique
        ii = straps(i).join(3);
        join_id = straps(i).join(1);
        node_id = 1:2;
        node_id = node_id(straps(ii).join(1:2) == join_id);
        con2 = nodes_ind(nodes(:,6) == ii & nodes(:,7) == node_id);
    end
    
    if straps(i).join(3) ~= 0 && straps(i).join(2) ~= 0 % If the second node isn't unique
        ii = straps(i).join(3); % Look for the node
        node_id = 1:2;
        node_id = node_id(straps(ii).join(1:2) == 1);
        con2 = nodes_ind(nodes(:,6) == ii & nodes(:,7) == node_id);
        
        % nodes(nodes(:,6) == i & nodes(:,7) == 1,:) = [];
    end
    
    con_strap(sum(num_straps(1:i - 1)) + 1:sum(num_straps(1:i)),:) = [con1 con2];
    strap_type(1:num_straps(i),i) = i;
end

con_strap = con_strap + N;
con_strap = [con_strap 3*ones(size(con_strap,1),1)];

strap_type = strap_type(:);
strap_type(strap_type == 0) = [];

%% ORIENTATION
% % % May need to modify location of orientation nodes for HIAD
% % %  configurations other than a perfect circle
orientation = zeros(size([con_link; con_strap],1),3);
orientation(:,3) = 1e6;


%% BOUNDARIES
b = zeros(size(nodes,1),6);
b = b';
bound = b(:);


%% Loading
F = zeros(size(bound));


%% U vector
u = zeros(size(nodes,1),6);
u = u';
U = u(:);
FEM.MODEL.U_pt = [FEM.MODEL.U_pt; U];


%% ELEMENTS
% Preallocate element structure
EL(size([con_link; con_strap],1)).el = [];
EL(size([con_link; con_strap],1)).el_in = [];
EL(size([con_link; con_strap],1)).el_in0.break = [];
EL(size([con_link; con_strap],1)).el_in0.mat = [];
EL(size([con_link; con_strap],1)).el_in0.geom = [];
EL = EL';

% Links
for i = 1:size(con_link,1)
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el2'; % Linear, corotational beam

    % Special element input
    EL(i).el_in0.break = 0;
    EL(i).el_in0.mat = [E .3]; % [E nu]
    EL(i).el_in0.geom = [A Izz Iyy 0 J]; % [A Izz Iyy ky J]
end

% Straps
count = 1;
for i = i + 1:size(con_link,1) + size(con_strap,1)
    EL(i).el_in0 = instantiate_EL; % Instatiate all element variables
    
    % Define element functions
    EL(i).el = 'el4'; % Corotational beam with axial lookup table
    
    EL(i).el_in0.break = 0;
    EL(i).el_in0.mat = straps(strap_type(count)).mat; % [E nu]
    EL(i).el_in0.geom = straps(strap_type(count)).geom; % [A Izz Iyy ky J]
    EL(i).el_in0.axial = straps(strap_type(count)).axial;
    EL(i).el_in0.axial_k = straps(strap_type(count)).axial_k;
    EL(i).el_in0.eps0 = straps(strap_type(count)).eps0;
    count = count + 1;
end


%% MODEL
strap_EL_1 = size(FEM.EL,1) + size(con_link,1) + 1;

FEM.EL = [FEM.EL; EL];
FEM.MODEL.nodes = [FEM.MODEL.nodes; nodes(:,1:3)];
FEM.MODEL.orientation = [FEM.MODEL.orientation; orientation];
FEM.MODEL.connect = [FEM.MODEL.connect; [con_link; con_strap]];
FEM.MODEL.B = [FEM.MODEL.B; bound];


%% Set forces
FEM.MODEL.F = [FEM.MODEL.F; F];


end




