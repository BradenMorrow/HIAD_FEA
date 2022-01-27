 function [Knc] = update_Knc(U,F)
% Follower forces, update the noncoservative force stiffness matrix to
% accomodate nodal rotations


n = size(U,1); %size of U along the fist dimention (6*num)
U1 = U(4:6:n); %U of 4 to n incremented by 6
cx = cos(U1); sx = sin(U1); %cos and sin of U1
U2 = U(5:6:n); %U of 5 to n incremented by 6
cy = cos(U2); sy = sin(U2); %cos and sin of U2
U3 = U(6:6:n);  %6 to n incremented by 6
cz = cos(U3); sz = sin(U3); %cos and sin of U3 (6 to size of U along the fist dimention incremented by 6)
F1 = F(1:6:n); %F of 1 to n incremented by 6
F2 = F(2:6:n); %F of 2 to n incremented by 6
F3 = F(3:6:n); %F of 3 to n incremented by 6
val(1:6:n) = -F2.*sx-F3.*cx; %value of 1 to n incremented by 6  = -F2*sin(U1)-F3*cos(U1)
val(2:6:n) = F2.*cx-F3.*sx;  %value of 2 to n incremented by 6  = F2*cos(U1)-F3*sin(U1)
val(3:6:n) = -F1.*sy+F3.*cy; %value of 3 to n incremented by 6  = -F1*sin(U2)+F3*cos(U2)
val(4:6:n) = -F1.*cy-F3.*sy; %value of 4 to n incremented by 6  = -F1*cos(U2)-F3*sin(U2)
val(5:6:n) = -F1.*sz-F2.*cz; %value of 5 to n incremented by 6  = -F1*sin(U3)-F2*cos(U3)
val(6:6:n) = F1.*cz-F2.*sz; %value of 6 to n incremented by 6  = F2*cos(U3)-F2*cos(U3)
a = zeros(n/6,1); b=a; c=a; d=a; e=a; f=a;  %a, b, c, d, e, f = a n/6 by 1 zeros matrix
a = 1:6:n; %value of 1 to n incremented by 6 
b = 2:6:n; %value of 2 to n incremented by 6
c = 3:6:n; %value of 3 to n incremented by 6 
d = 4:6:n; %value of 4 to n incremented by 6 
e = 5:6:n; %value of 5 to n incremented by 6 
f = 6:6:n; %value of 6 to n incremented by 6 
% Displacement indices
row = zeros(n,1); %zeros matrix of n (size of U along first dimension) by 1
row(1:6:n) = b; %value of 1 to n incremented by 6 = 2 to n incremented by 6
row(2:6:n) = c; %value of 1 to n incremented by 6 = 3 to n incremented by 6 
row(3:6:n) = a; %value of 1 to n incremented by 6 = 1 to n incremented by 6 
row(4:6:n) = c; %value of 1 to n incremented by 6 = %value of 3 to n incremented by 6 
row(5:6:n) = a; %value of 1 to n incremented by 6 = %value of 1 to n incremented by 6 
row(6:6:n) = b; %value of 1 to n incremented by 6 = %value of 2 to n incremented by 6
% Rotation indices
col = zeros(n,1); % zeros matrix with dimension n by 1
col(1:6:n) = d; %value of 1 to n incremented by 6 = 4 to n incremented by 6 
col(2:6:n) = d; %value of 1 to n incremented by 6 = 4 to n incremented by 6 
col(3:6:n) = e; %value of 1 to n incremented by 6 = 5 to n incremented by 6 
col(4:6:n) = e; %value of 1 to n incremented by 6 = 5 to n incremented by 6 
col(5:6:n) = f; %value of 1 to n incremented by 6 = 6 to n incremented by 6 
col(6:6:n) = f; %value of 1 to n incremented by 6 = 6 to n incremented by 6 
Knc = sparse(row,col,val,n,n); %create a sparse matrix of size n (first dimention of U) by n with the values of val at (row, col)
