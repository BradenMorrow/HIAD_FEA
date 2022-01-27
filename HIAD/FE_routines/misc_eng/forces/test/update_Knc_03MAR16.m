function [Knc] = update_Knc(U,F)
% Follower forces, update the noncoservative force stiffness matrix to
% accomodate nodal rotations

Knc = spalloc(size(U,1),size(U,1),3);

% Rotation indices
ind1 = 4:6:size(U,1);
ind1 = ind1(:);
ind1 = [ind1 ind1 + 1 ind1 + 2];

% Displacement indices
ind2 = 1:6:size(U,1);
ind2 = ind2(:);
ind2 = [ind2 ind2 + 1 ind2 + 2];

%%% VECTORIZE
for i = 1:size(ind1,1)
    Fx = F(ind2(i,1));
    Fy = F(ind2(i,2));
    Fz = F(ind2(i,3));
    
    theta_x = U(ind1(i,1));
    theta_y = U(ind1(i,2));
    theta_z = U(ind1(i,3));
    
    % dF/dtheta_x
    Knc(ind2(i,:),ind1(i,1)) = [0
        -Fy*sin(theta_x) - Fz*cos(theta_x)
        Fy*cos(theta_x) - Fz*sin(theta_x)];
    
    % dF/dtheta_y
    Knc(ind2(i,:),ind1(i,2)) = [-Fx*sin(theta_y) + Fz*cos(theta_y)
        0
        -Fx*cos(theta_y) - Fz*sin(theta_y)];
    
    % dF/dtheta_z
    Knc(ind2(i,:),ind1(i,3)) = [-Fx*sin(theta_z) - Fy*cos(theta_z)
        Fx*cos(theta_z) - Fy*sin(theta_z)
        0];
end

end

