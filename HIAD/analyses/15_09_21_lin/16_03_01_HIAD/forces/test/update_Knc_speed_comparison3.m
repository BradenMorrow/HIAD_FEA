% function [Knc] = update_Knc(U,F)
% Follower forces, update the noncoservative force stiffness matrix to
% accomodate nodal rotations
clear
num = 4340;
U = rand(6*num,1);
F = rand(6*num,1);

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
row = zeros(n,1);
col = zeros(n,1);
val = zeros(n,1);

% ind = 1:
for i = 1:n/6
    
    Fx = F((i-1)*6+1);
    Fy = F((i-1)*6+2);
    Fz = F((i-1)*6+3);
    
    theta_x = U((i-1)*6+4);
    theta_y = U((i-1)*6+5);
    theta_z = U((i-1)*6+6);
    
    ind = (i-1)*6+1:i*6;
    row(ind,1) = [(i-1)*6+2;
        (i-1)*6+3;
        (i-1)*6+1;
        (i-1)*6+3;
        (i-1)*6+1;
        (i-1)*6+2];
    col(ind,1) = [(i-1)*6+4;
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
    
    val(ind,:) = [-Fy*sx-Fz*cx; % dF/dtheta_x(2)
        Fy*cx-Fz*sx; % dF/dtheta_x(3)
        -Fx*sy+Fz*cy; % dF/dtheta_y(1)
        -Fx*cy-Fz*sy; % dF/dtheta_y(3)
        -Fx*sz-Fy*cz; % dF/dtheta_z(2)
        Fx*cz-Fy*sz;]; % dF/dtheta_z(3)
end
B1 = sparse(row,col,val,n,n);
t2 = toc
speedup = t1/t2






%% Using sparse and parallelizing
tic;

n = size(U,1);
% Reorganize displacement and force vector
F2 = zeros(length(F)/6,6);
U2 = F2;
U2(:,1) = U(1:6:size(U,1));
U2(:,2) = U(2:6:size(U,1));
U2(:,3) = U(3:6:size(U,1));
F2(:,1) = F(1:6:size(U,1));
F2(:,2) = F(2:6:size(U,1));
F2(:,3) = F(3:6:size(U,1));

sx = sin(U2(:,4));
cx = cos(U2(:,4));
sy = sin(U2(:,5));
cy = cos(U2(:,5));
sz = sin(U2(:,6));
cz = cos(U2(:,6));
val = [-F2(:,2).*sx-F2(:,3).*cx; % dF/dtheta_x(2)
    F2(:,2).*cx-F2(:,3).*sx; % dF/dtheta_x(3)
    -F2(:,1).*sy+F2(:,3).*cy; % dF/dtheta_y(1)
    -F2(:,1).*cy-F2(:,3).*sy; % dF/dtheta_y(3)
    -F2(:,1).*sz-F2(:,2).*cz; % dF/dtheta_z(1)
    F2(:,1).*cz-F2(:,2).*sz;]; % dF/dtheta_z(2)

row = zeros(n,1);
col = row;
row(1:6) = [2;3;1;3;1;2];
col(1:6) = [4;4;5;5;6;6];
for i = 7:n
    row(i) = row(i-6)+6;
    col(i) = col(i-6)+6;
end
Knc2 = sparse(row(:),col(:),val(:),n,n);


t3 = toc
speedup2 = t2/t3
speedup2 = t1/t3








