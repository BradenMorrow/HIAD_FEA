function [Knc] = update_Knc(U,F)
% Follower forces, update the noncoservative force stiffness matrix to
% accomodate nodal rotations

n = size(U,1);
row = zeros(6,n/6);
col = zeros(6,n/6);
val = zeros(6,n/6);

% Reorganize displacement and force vector
ind = 1:6:size(U,1);
ind = [ind ind + 1 ind + 2 ind + 3 ind + 4 ind + 5]';
U2 = zeros(length(U)/6,6);
U2(:) = U(ind);
F2 = zeros(length(F)/6,6);
F2(:) = F(ind);

for i = 1:n/6
    
    Fx = F2(i,1);
    Fy = F2(i,2);
    Fz = F2(i,3);
    
    theta_x = U2(i,4);
    theta_y = U2(i,5);
    theta_z = U2(i,6);

    % Displacement indices
    row(:,i) = [(i-1)*6+2;
        (i-1)*6+3;
        (i-1)*6+1;
        (i-1)*6+3;
        (i-1)*6+1;
        (i-1)*6+2];
    
    % Rotation indices
    col(:,i) = [(i-1)*6+4; 
        (i-1)*6+4;
        (i-1)*6+5;
        (i-1)*6+5;
        (i-1)*6+6;
        (i-1)*6+6];
        
    sx = sin(theta_x);
    cx = cos(theta_x);
    sy = sin(theta_y);
    cy = cos(theta_y);
    sz = sin(theta_z);
    cz = cos(theta_z);
    
    val(:,i) = [-Fy*sx-Fz*cx; % dF/dtheta_x(2)
        Fy*cx-Fz*sx; % dF/dtheta_x(3)
        -Fx*sy+Fz*cy; % dF/dtheta_y(1)
        -Fx*cy-Fz*sy; % dF/dtheta_y(3)
        -Fx*sz-Fy*cz; % dF/dtheta_z(2)
        Fx*cz-Fy*sz;]; % dF/dtheta_z(3)
end
Knc = sparse(row(:),col(:),val(:),n,n);