function [M] = get_M(z,e1,L)
%GET_M
%   Get the M matrix

%L = 1x1 double
%z = 3x1 double
%el = 3x1 double

A = 1/L*([1 0 0; 0 1 0; 0 0 1] - e1*e1');
M = -1/L*(A*z*e1' + (A*z*e1')' + A*(e1'*z));

end

