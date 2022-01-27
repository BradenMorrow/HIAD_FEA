% %% Test get_M
% This is a script to test the mex function generated from get_M

z = [0;0;1];
el = [-.0053;1;0];
L = 1.9655;

for i = 1:10000
M = get_M(z,el,L);
end