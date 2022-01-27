function [F_rot] = update_F_jdc(U,F)
% Follower forces, update the force vector to accomodate nodal rotations

% Reorganize displacement and force vector
F2 = zeros(length(F)/6,6);
F2(:,1) = F(1:6:size(U,1));
F2(:,2) = F(2:6:size(U,1));
F2(:,3) = F(3:6:size(U,1));

% Magnitude of forces
P = sum(F2(:,1:3).^2,2).^.5;

% Force unit vector
F_norm = zeros(size(P,1),3);
F_norm(P ~= 0,:) = bsxfun(@rdivide,F2(P ~= 0,1:3),P(P ~= 0));

% Rotation matrices
F_rot2 = zeros(6,size(F2,1));

ctx = cos(U(4:6:size(U,1)));
stx = sin(U(4:6:size(U,1)));
cty = cos(U(5:6:size(U,1)));
sty = sin(U(5:6:size(U,1)));
ctz = cos(U(6:6:size(U,1)));
stz = sin(U(6:6:size(U,1)));

R1 = [cty.*ctz -cty.*stz sty];
R2 = [ctx.*stz + ctz.*stx.*sty, ctx.*ctz - stx.*sty.*stz, -cty.*stx];
R3 = [stx.*stz - ctx.*ctz.*sty, ctz.*stx + ctx.*sty.*stz,  ctx.*cty];

F_rot2(1,:) = dot(R1,F_norm,2).*P;
F_rot2(2,:) = dot(R2,F_norm,2).*P;
F_rot2(3,:) = dot(R3,F_norm,2).*P;

% Reorganize new force vector
F_rot = F_rot2(:);
F_rot2 = F_rot2'; % Does this need to be here?