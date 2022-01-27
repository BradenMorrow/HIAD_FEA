% %% Test get_L
% This is a script to test the mex function generated from get_L

rk = [0; 0; 1];
z = [-.0053; 1; 0];
el = [-.0053; 1; 0];
L = 1.9655;
r1 = [-.0053; 1; 0];

for i = 1:10000
L_out = get_L(rk,el,L,r1);
end