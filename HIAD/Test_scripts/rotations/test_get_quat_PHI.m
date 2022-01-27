% %% Test get_quat_Phi
% This is a script to test the mex function generated from get_quat_Phi
PHI = [0;0;0];

for i = 1:10000
qi = get_quat_PHI(PHI);
end