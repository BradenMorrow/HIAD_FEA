% function [Knc] = update_Knc(U,F)
% Follower forces, update the noncoservative force stiffness matrix to
% accomodate nodal rotations
clear all
num = 4340;
U = rand(6*num,3);
F = rand(6*num,3);

Knc = spalloc(size(U,1),size(U,1),6);

% Rotation indices
ind1 = 4:6:size(U,1);
ind1 = ind1(:);
ind1 = [ind1 ind1 + 1 ind1 + 2];

% Displacement indices
ind2 = ind1 - 3;

tic
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
t1 = toc

%% Using sparse
tic;
n = size(U,1);
row = zeros(n,1); col = zeros(n,1); val = zeros(n,1);

for i = 1:n/6

    Fx = F((i-1)*6+1);
    Fy = F((i-1)*6+2);
    Fz = F((i-1)*6+3);
    
    theta_x = U((i-1)*6+4);
    theta_y = U((i-1)*6+5);
    theta_z = U((i-1)*6+6);

    row((i-1)*6+1:i*6,1) = [(i-1)*6+2;
        (i-1)*6+3;
        (i-1)*6+1;
        (i-1)*6+3;
        (i-1)*6+1;
        (i-1)*6+2];
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
B = sparse(row,col,val,n,n);
t2 = toc
speedup = t1/t2