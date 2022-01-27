% %% Test get_PHI_quat
% This is a script to test the mex function generated from get_PHI_quat
qi = [1;1;1;1];

for i = 1:10000
M = get_PHI_quat(pi);
end