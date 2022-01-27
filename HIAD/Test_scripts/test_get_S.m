% %% Test get_S
% This is a script to test the mex function generated from get_S

w = [0;0;0];

for i = 1:10000
S = get_S(w);
end