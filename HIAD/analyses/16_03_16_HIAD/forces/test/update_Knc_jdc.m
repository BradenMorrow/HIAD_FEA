function [Knc] = update_Knc_jdc(U,F)
% Follower forces, update the noncoservative force stiffness matrix to
% accomodate nodal rotations

n = size(U,1);
row = zeros(n,1); col = zeros(n,1); val = zeros(n,1);

for i = 1:n/6
    
    Fx = F((i-1)*6+1);
    Fy = F((i-1)*6+2);
    Fz = F((i-1)*6+3);
    
    theta_x = U((i-1)*6+4);
    theta_y = U((i-1)*6+5);
    theta_z = U((i-1)*6+6);

    % Displacement indices
    row((i-1)*6+1:i*6,1) = [(i-1)*6+2;
        (i-1)*6+3;
        (i-1)*6+1;
        (i-1)*6+3;
        (i-1)*6+1;
        (i-1)*6+2];
    
    % Rotation indices
    col((i-1)*6+1:i*6,1) = [(i-1)*6+4; 
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
    
    val((i-1)*6+1:i*6,:) = [-Fy*sx-Fz*cx; % dF/dtheta_x(2)
        Fy*cx-Fz*sx; % dF/dtheta_x(3)
        -Fx*sy+Fz*cy; % dF/dtheta_y(1)
        -Fx*cy-Fz*sy; % dF/dtheta_y(3)
        -Fx*sz-Fy*cz; % dF/dtheta_z(2)
        Fx*cz-Fy*sz;]; % dF/dtheta_z(3)
end
Knc = sparse(row,col,val,n,n);