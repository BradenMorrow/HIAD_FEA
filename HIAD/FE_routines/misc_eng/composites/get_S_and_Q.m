function [S,Q] = get_S_and_Q(E1, E2, v12, G12)
%STIFFNESS_AND_COMPLIANCE function [S,Q] = get_S_and_Q(E1, E2, v12, G12)
%   This routine takes the elastic properties E1, E2, v12 and G12 as 
%   inputs and returns the stiffness (Q) and compliance (S) matrices in
%   the principal material axis.

% Generate S
S(1,1) = 1/E1;
S(2,2) = 1/E2;
S(3,3) = 1/G12;
S(1,2) = -v12/E1;
S(2,1) = S(1,2);

% Compute Q
Q = inv(S);

end

