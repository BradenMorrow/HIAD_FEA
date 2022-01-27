% %% Test normcfast
% This is a script to test the mex function generated from normcfast
x = magic(3);

for i = 1:10000
M = normcfast(x);
end