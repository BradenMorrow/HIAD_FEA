%% Test get_G
% This is a script to test the mex function generated from get_G

%%
rk = [0; 0; 1];
z = [-.0053; 1; 0];
el = [-.0053; 1; 0];
L = 1.9655;
r1 = [-.0053; 1; 0];

tic
for i = 1:10000
G = get_G(rk,z,el,L,r1);
end
toc