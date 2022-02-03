function [QFEM] = Qsym(FEM)
% Convert from full HIAD model to quarter symmetry model

%% INDICES
% Extract the theta location of nodes
theta = atan2(FEM.MODEL.nodes(:,2),FEM.MODEL.nodes(:,1));
theta(theta < 0) = theta(theta < 0) + 2*pi;

% Vector of node numbers
I_nodes = (1:size(theta,1))';

% Incices of nodes in first quadrant
I_QS_nodes = theta <= pi/2;

% New nodal indices
I_Qnodes = zeros(size(I_nodes));
I_Qnodes(I_QS_nodes) = (1:sum(I_QS_nodes))';

% Indices of DOFs in first quadrant
I_QS_DOF_mat = [I_QS_nodes I_QS_nodes I_QS_nodes I_QS_nodes I_QS_nodes I_QS_nodes]';
I_QS_DOF = I_QS_DOF_mat(:);

% Find indicis of elements in the first quadrant
% Preallocate indices
I_QS_els = false(size(FEM.MODEL.connect,1),1);
for i = 1:size(FEM.MODEL.connect,1)
    % Check if both nodes are in the first quadrant
    n1 = ~isempty(find(I_nodes(I_QS_nodes) == FEM.MODEL.connect(i,1),1));
    n2 = ~isempty(find(I_nodes(I_QS_nodes) == FEM.MODEL.connect(i,2),1));
    
    % If both nodes are in the first quadrant, save index
    if n1 && n2
        I_QS_els(i) = true;
    end
end


%% UPDATE MODEL
% Allocate output structure
QFEM = FEM;

% Keep only nodes and DOFs in first quadrant
QFEM.MODEL.nodes = FEM.MODEL.nodes(I_QS_nodes,:);
QFEM.MODEL.B = FEM.MODEL.B(I_QS_DOF);
QFEM.MODEL.F = FEM.MODEL.F(I_QS_DOF);
QFEM.MODEL.F_pre = FEM.MODEL.F_pre(I_QS_DOF);
QFEM.MODEL.F_pt = FEM.MODEL.F_pt(I_QS_DOF,:);

% Keep only elements in the first quadrant
QFEM.MODEL.connect = FEM.MODEL.connect(I_QS_els,:);
QFEM.MODEL.orientation = FEM.MODEL.orientation(I_QS_els,:);
QFEM.EL = FEM.EL(I_QS_els);

% Update node numbers
QFEM.MODEL.connect(:,1:2) = [I_Qnodes(QFEM.MODEL.connect(:,1)) I_Qnodes(QFEM.MODEL.connect(:,2))];

% Update element indices
ind = FEM.MODEL.theta_ind;
count = 1;
el0 = 0;
for i = 1:29 % Loop through element types
    for j = 1:size(ind(i).ind,1) % Loop through elements
        if I_QS_els(count) == 0 % If the element has been eliminated
            ind(i).ind(j) = 0; % Mark element
        end
        count = count + 1;
    end
    ind(i).ind(ind(i).ind == 0) = []; % Eliminate marked elements
    ind(i).ind = (el0 + 1:el0 + size(ind(i).ind,1))'; % Update element indices
    el0 = el0 + size(ind(i).ind,1);
end
QFEM.MODEL.theta_ind = ind;


%% QUARTER SYMMETRY BOUNDARIES
% Apply boundaries to cut nodes
I_QS_bound_x = theta == 0;
I_QS_bound_y = theta == pi/2;

B_QS = zeros(size(FEM.MODEL.nodes,1),6);
B_QS(I_QS_bound_x,[2 4 6]) = 1; % X-Z plane
B_QS(I_QS_bound_y,[1 5 6]) = 1; % Y-Z plane
B_QS = B_QS(I_QS_nodes,:);
B_QS = B_QS';
B_QS = B_QS(:);

QFEM.MODEL.B = QFEM.MODEL.B + B_QS;


% % % %% PLOT
% % % % Visualize
% % % figure(1)
% % % plot3(QFEM.MODEL.nodes(:,1),QFEM.MODEL.nodes(:,2),QFEM.MODEL.nodes(:,3),'b.')

end

