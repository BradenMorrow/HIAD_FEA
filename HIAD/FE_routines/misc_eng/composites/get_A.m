function [A,a] = get_A(E1, E2, v12, G12, theta, t)
%GET_A function [A,a] = get_A(E1, E2, v12, G12, theta, t)
%   This routine takes the laminate elastic properties, (E1, E2, v12 and 
%   G12, vectors) the orientation of each lamina (theta, vector) and the 
%   thickness of the lamina (t, vectors) as inputs and returns the laminate
%   extensional stiffness matrix (A) and the laminate extensional 
%   compliance matrix (a).

% Initiate T, S, Q, Sxy and Qxy as k 3x3 stacked matrices
T = zeros(3,3,length(theta));
S = T;
Q = T;
Sxy = T;
Qxy = T;

% Initialize the R and A matrices
R = eye(3);
R(3,3) = 2;

A = zeros(3);

% Compute T, S and Q, transform S and Q into global coordinates, (Sxy and
% Qxy) and compute the extensional stiffness matrix A
for k = 1:length(theta)
    
    % Tranformation matrix
    T(:,:,k) = get_T(theta(k));
    
    % S and Q
    [S(:,:,k),Q(:,:,k)] = get_S_and_Q(E1(k), E2(k), v12(k), G12(k));
    
    % Transform S and Q into Sxy and Qxy, (global coordinates)
    Qxy(:,:,k) = inv(T(:,:,k))*Q(:,:,k)*R*T(:,:,k)*inv(R);
    Sxy(:,:,k) = inv(Qxy(:,:,k));
    
    % Compute A
    A = A + t(k)*Qxy(:,:,k);
end

% Compute the laminate extensional compliance matrix
a = inv(A);

end









