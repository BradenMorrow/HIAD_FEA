function [F_rot] = update_F(U,F)
% Follower forces, update the force vector to accomodate nodal rotations


% Reorganize displacement and force vector
F2 = zeros(length(F)/6,6); %num by 6 zeros matrix
F2(:,1) = F(1:6:size(U,1)); %F2 of the first colum = F of 1 to length(U) incremented by 6
F2(:,2) = F(2:6:size(U,1)); %F2 of the second colum = F of 2 to length(U) incremented by 6
F2(:,3) = F(3:6:size(U,1)); %F2 of the third colum = F of 3 to length(U) incremented by 6

% Magnitude of forces
P = sum(F2(:,1:3).^2,2).^.5; %sum of F2 of elements 1 2 3 in a row squared then take the sqrt of it

% Force unit vector
F_norm = zeros(size(P,1),3); %zeros of length(U)/6, 3
F_norm(P ~= 0,:) = bsxfun(@rdivide,F2(P ~= 0,1:3),P(P ~= 0));
%the rows of P that are not equal to 0 = 
%F2 of (the rows p is not zero cols 1 to 3) element divided by P of (the rows P is not zero) 

% Rotation matrices
F_rot2 = zeros(6,size(F2,1)); %zeros matrix of (6xnum nodes)

ctx = cos(U(4:6:size(U,1))); %take the cos of U of 4 to length(U) incremented by 6
stx = sin(U(4:6:size(U,1))); %take the cos of U of 4 to length(U) incremented by 6
cty = cos(U(5:6:size(U,1))); %take the cos of U of 5 to length(U) incremented by 6
sty = sin(U(5:6:size(U,1))); %take the cos of U of 5 to length(U) incremented by 6
ctz = cos(U(6:6:size(U,1))); %take the cos of U of 6 to length(U) incremented by 6
stz = sin(U(6:6:size(U,1))); %take the cos of U of 6 to length(U) incremented by 6

R1 = [cty.*ctz -cty.*stz sty]; %R1 = element wise multiplicatin of cty and ctz, cty*stz, sty
R2 = [ctx.*stz + ctz.*stx.*sty, ctx.*ctz - stx.*sty.*stz, -cty.*stx];
R3 = [stx.*stz - ctx.*ctz.*sty, ctz.*stx + ctx.*sty.*stz,  ctx.*cty];

F_rot2(1,:) = dot(R1,F_norm,2).*P;
F_rot2(2,:) = dot(R2,F_norm,2).*P;
F_rot2(3,:) = dot(R3,F_norm,2).*P;

% Reorganize new force vector
F_rot = F_rot2(:);
