function [F_rot] = update_F(U,F)
% Follower forces, update the force vector to accomodate nodal rotations

% Reorganize displacement and force vector
ind = 1:6:size(U,1);
ind = [ind ind + 1 ind + 2 ind + 3 ind + 4 ind + 5]';
U2 = zeros(length(U)/6,6);
U2(:) = U(ind);
F2 = zeros(length(F)/6,6);
F2(:) = F(ind);

% Magnitude of forces
P = sum(F2(:,1:3).^2,2).^.5;

% Force unit vector
F_norm = zeros(size(P,1),3);
F_norm(P ~= 0,:) = bsxfun(@rdivide,F2(P ~= 0,1:3),P(P ~= 0));

% Rotation matrices
Rx = get_Rx(U2(:,4));
Ry = get_Ry(U2(:,5));
Rz = get_Rz(U2(:,6));
R = zeros(size(Rx));
F_rot2 = zeros(6,size(F2,1));

% Loop through nodes
%%% VECTORIZE
for i = 1:size(U2,1)
    % Rotation matrix
    R(:,:,i) = Rx(:,:,i)*Ry(:,:,i)*Rz(:,:,i);
    
    % Transform and scale force vector
    F_rot2(1:3,i) = R(:,:,i)*F_norm(i,:)'*P(i);
end

% Reorganize new force vector
F_rot = F_rot2(:);
F_rot2 = F_rot2';

end

