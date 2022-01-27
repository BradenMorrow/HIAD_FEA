function [FEM,DEBUG] = assemble_stiff_Fint(FEM)
%ASSEMBLE_STIFFNESS
%   Assembles the system stiffness matrix (corotational formulation)

% DEBUG = 0;
% Extract required variables
DOF = FEM.ANALYSIS.DOF;
nodes = FEM.GEOM.nodes;
connect = FEM.GEOM.connect;
orientation = FEM.GEOM.orientation;
U = FEM.OUT.U;
DELTA_U = FEM.OUT.DELTA_U;
delta_U = FEM.OUT.delta_U;
U0 = FEM.OUT.U0;

% Reorganize U and R
U_2 = zeros(size(nodes,1),DOF);
DELTA_U_2 = zeros(size(nodes,1),DOF);
delta_U_2 = zeros(size(nodes,1),DOF);
U0_2 = zeros(size(nodes,1),DOF);
for j = 1:DOF
    U_2(:,j) = U(j:DOF:length(U));
    DELTA_U_2(:,j) = DELTA_U(j:DOF:length(U));
    delta_U_2(:,j) = delta_U(j:DOF:length(U));
    U0_2(:,j) = U0(j:DOF:length(U));
end

% Initialize variables
FEM.STIFF.K = zeros(DOF*size(nodes,1));
FEM.OUT.rot = zeros(size(nodes));
FEM.OUT.DELTA_rot = zeros(size(nodes));

FEM.STIFF.Kel = zeros(DOF*2);
Fint = zeros(size(U));


% Loop through each element
for i = 1:size(connect,1)
    % Linear beam element - linear elastic
    if connect(i,3) == 3
        con = connect(i,:);
        orient_ij = [orientation(con(1),:)
            orientation(con(2),:)];
        config = con(4);
        nodes_ij = [nodes(con(1),:)
            nodes(con(2),:)];
        L_el = sqrt((nodes_ij(2,1) - nodes_ij(1,1))^2 + ...
            (nodes_ij(2,2) - nodes_ij(1,2))^2 + ...
            (nodes_ij(2,3) - nodes_ij(1,3))^2);
        
        mat = FEM.SPRING(config).material(i,:);
        
        % Generate the transformation matrix
        T = T_beam_3d(con,orient_ij,nodes);
        
        Uel = [U_2(con(1),:)'
            U_2(con(2),:)'];
        u = T*Uel;
        eps = (u(7) - u(1))/L_el;
        
        
        if isfield(FEM.SPRING(config).geom,'bilinear_flag')
            if eps <= FEM.SPRING(config).geom.eps0
                geom = FEM.SPRING(config).geom.geom1(i,:);
            else
                geom = FEM.SPRING(config).geom.geom2(i,:);
            end
        else
            geom = FEM.SPRING(config).geom(i,:);
        end
        
        % Generate the element stiffness matrix (local coordinates)
        k = element_3(mat,geom,L_el);
        
        
        % Transform element stiffness matrix (local to global coordinates)
        FEM.STIFF.Kel = T'*k*T;
        
        % Element forces
        fint_i = k*u;
        Fint_i = T'*fint_i;
        
        
        drot = [delta_U_2(con(1),4:6)
            delta_U_2(con(2),4:6)];
        roti = [U_2(con(1),4:6)
            U_2(con(2),4:6)];
        rot = roti + drot;
        rot0 = [U0_2(con(1),4:6)
            U0_2(con(2),4:6)];
        DELTA_rot = rot - rot0;
        
        if sum(FEM.OUT.rot(con(1),:)) == 0
            FEM.OUT.rot(con(1),:) = rot(1,:);
            FEM.OUT.DELTA_rot(con(1),:) = DELTA_rot(1,:);
        end
        if sum(FEM.OUT.rot(con(2),:)) == 0
            FEM.OUT.rot(con(2),:) = rot(2,:);
            FEM.OUT.DELTA_rot(con(2),:) = DELTA_rot(2,:);
        end
        
        DEBUG = 0;
        
    % Corotational beam element - linear elastic
    elseif connect(i,3) == 4
        % Element inputs
        con = connect(i,:);
        config = con(4);
        element_in = FEM.SPRING(config);
        element_in.node_ij = [nodes(con(1),:)
            nodes(con(2),:)];
        element_in.orient_ij = [orientation(con(1),:)
            orientation(con(2),:)];
        element_in.U_ij = [U_2(con(1),:)
            U_2(con(2),:)];
        element_in.DELTA_U_ij = [DELTA_U_2(con(1),:)
            DELTA_U_2(con(2),:)];
        element_in.delta_U_ij = [delta_U_2(con(1),:)
            delta_U_2(con(2),:)];
        element_in.U0_ij = [U0_2(con(1),:)
            U0_2(con(2),:)];
        
        element_in.material = FEM.SPRING(config).material(i,:);
        element_in.geom = FEM.SPRING(config).geom(i,:);
        
        if 1 <= sum(i == FEM.SPRING(1).ind)
            element_in.disp_flag = 1;
        else
            element_in.disp_flag = 0;
        end
        
        % Generate the element stiffness matrix (global coordinates)
        [FEM.STIFF.Kel,Fint_i,fint_i,rot,DELTA_rot] = element_4(element_in);
        
%         KK = diag(FEM.STIFF.Kel)
        

%         if config == 2 && FEM.SPRING(config).ind(1) == i
            DEBUG = 0;
%         end
        
        % Store new total nodal rotations
        FEM.OUT.rot(con(1),:) = rot(1,:);
        FEM.OUT.rot(con(2),:) = rot(2,:);
        
        FEM.OUT.DELTA_rot(con(1),:) = DELTA_rot(1,:);
        FEM.OUT.DELTA_rot(con(2),:) = DELTA_rot(2,:);
        
    % Corotational beam element - inflatable shell with nonlinear cords
    elseif connect(i,3) == 5
        % Element inputs
        con = connect(i,:);
        config = con(4);
        element_in = FEM.CONFIG(config);
        element_in.cords = FEM.CONFIG(config).element(i).nodes;
        
%         element_in.f_old = FEM.CONFIG(config).ax(i,1:2)';
%         element_in.eps = FEM.CONFIG(config).ax(i,3);
        
        
        
        element_in.node_ij = [nodes(con(1),:)
            nodes(con(2),:)];
        element_in.orient_ij = [orientation(con(1),:)
            orientation(con(2),:)];
        element_in.U_ij = [U_2(con(1),:)
            U_2(con(2),:)];
        element_in.DELTA_U_ij = [DELTA_U_2(con(1),:)
            DELTA_U_2(con(2),:)];
        element_in.delta_U_ij = [delta_U_2(con(1),:)
            delta_U_2(con(2),:)];
        element_in.U0_ij = [U0_2(con(1),:)
            U0_2(con(2),:)];
%         element_in.f_cord0 = FEM.CONFIG(config).f_cord(:,:,i);
        
        element_in.y_bar0 = [FEM.CONFIG(config).y_bar(con(1),:) FEM.CONFIG(config).y_bar(con(2),:)]';
        element_in.EI0 = FEM.CONFIG(config).EI(i,1:2);
        element_in.EA0 = FEM.CONFIG(config).EI(i,3);
        
        element_in.p = FEM.CONFIG(config).p;
        
        element_in.i = i;
        element_in.inc = FEM.i;
        element_in.first_flag = FEM.PASS.first_flag;
        
        element_in.eps_cord_old = FEM.CONFIG(config).element(i).eps0;
        element_in.f_cord_old = FEM.CONFIG(config).element(i).f0;
        element_in.f_shell_old = 0; %FEM.CONFIG(config).element(i).f_shell0;
        
        element_in.D0 = FEM.OUT.D0(:,i);
        element_in.P0 = FEM.OUT.P0(:,i);
        
        % Generate the element stiffness matrix (global coordinates)
        [FEM.STIFF.Kel,Fint_i,fint_i,y_bar,cord,f_shell,EI,rot,DELTA_rot,DEBUG] = element_5(element_in);
        
        % Update location of NA
        FEM.CONFIG(config).y_bar(con(1),:) = y_bar(1);
        FEM.CONFIG(config).y_bar(con(2),:) = y_bar(2);
        
        % Store tangent EI
        FEM.CONFIG(config).EI1(i,:) = EI;
%         FEM.CONFIG(config).ax1(i,:) = [cord(:,5)' cord(1,6)];
%         FEM.CONFIG(config).f_cord(:,:,i) = f_cord;
        
        % Store new total nodal rotations
        FEM.OUT.rot(con(1),:) = rot(1,:);
        FEM.OUT.rot(con(2),:) = rot(2,:);
        
        FEM.OUT.DELTA_rot(con(1),:) = DELTA_rot(1,:);
        FEM.OUT.DELTA_rot(con(2),:) = DELTA_rot(2,:);
        
        FEM.OUT.P(:,i) = DEBUG.P;
        FEM.OUT.D(:,i) = DEBUG.D;
        
%         FEM.OUT.D0(:,i) = DEBUG.D;
%         FEM.OUT.P0(:,i) = DEBUG.P;
        
        FEM.CONFIG(config).element(i).eps = cord(:,1:2);
        FEM.CONFIG(config).element(i).f = cord(:,3:4);
        FEM.CONFIG(config).element(i).f_shell = f_shell;
        
        FEM.CONFIG(config).element(i).eps0 = cord(:,1:2);
        FEM.CONFIG(config).element(i).f0 = cord(:,3:4);
        FEM.CONFIG(config).element(i).f_shell0 = f_shell;
        
        if i == 31
            a = 1;
        end
        
    end
    
    % Add global element stiffness matrix to system stiffness matrix
    if FEM.PASS.assemble == 1
        FEM.GEOM.con = connect(i,:);
        [FEM] = add_Kel(FEM);
    end
    
    % Add element internal force vector to global internal force vector
    start1 = connect(i,1)*6 - 5;
    start2 = connect(i,2)*6 - 5;
    Fint(start1:start1 + 5) = Fint(start1:start1 + 5) + Fint_i(1:6);
    Fint(start2:start2 + 5) = Fint(start2:start2 + 5) + Fint_i(7:12);
    FEM.PASS.Fint = Fint;
    
    FEM.OUT.Fint_el(:,i,FEM.ANALYSIS.step + 1) = Fint_i;
    FEM.OUT.fint_el(:,i,FEM.ANALYSIS.step + 1) = fint_i;
    
    
end
% % % FEM.ANALYSIS.step
% % % 
% % % if FEM.ANALYSIS.step == 2
% % %     a = 1;
% % %     FEM.OUT.fint_el(:,129,3)
% % % end


FEM.OUT.D0 = FEM.OUT.D;
FEM.OUT.P0 = FEM.OUT.P;
end

