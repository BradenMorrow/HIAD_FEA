
% Update nodes based on displacement of nodes in elastic shell analysis
FEM_in_load.GEOM.nodes = FEM.GEOM.nodes + U2(:,1:3);
FEM_in_load.GEOM.nodes(strap_ind,:) = FEM.GEOM.nodes(strap_ind,:);

FEM_in_load.GEOM.orient(tor_ind,:) = FEM_in_load.GEOM.nodes(tor_ind,:);
FEM_in_load.GEOM.orient(tor_ind,3) = 1;

% Update orientation nodes based on rotation of nodes in elastic shell
% analysis
for i = 1:size(tor_ind,1)
    rot_vec = U2(i,4:6)'; % Rotation vector from U
    R1 = get_R_PHI(rot_vec); % Rotation matrix
    o_vec = (FEM.GEOM.orientation(i,:) - FEM.GEOM.nodes(i,:))'; % Orientation vector
    o_vec_new = R1*o_vec; % Rotate orientation vector
    FEM_in_load.GEOM.orientation(i,:) = FEM_in_load.GEOM.nodes(i,:) + o_vec_new'; % Update orientation vector
% % %     FEM_in_load.GEOM.orientation(i,:) = FEM.GEOM.nodes(i,:) + o_vec_new'; % Update orientation vector
end


% FEM_in_load.GEOM.nodes = FEM.GEOM.nodes;



