% %% Test interp1qr
% This is a script to test the mex function generated from interp1qr
x = [1 2 3 4 5]';
y = [10 20 30 40 50]';
xi = [.0246;.0246];

for i = 1:10000
M = interp1qr(x, y, xi);
end