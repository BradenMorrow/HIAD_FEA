% Wind tunnel loading
% April 3, 2017

fid = 'Nodal_Forces.csv';
% load('theta.mat')
[Ftor] = get_F_03APR17(theta,fid);

fid = 'Nodal_Moments.csv';
[Mtor] = get_F_03APR17(theta,fid);

F = [Ftor Mtor]';
F = F(:);







