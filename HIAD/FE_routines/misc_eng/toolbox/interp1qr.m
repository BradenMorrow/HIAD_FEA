function yi = interp1qr( x, y, xi )
%Quicker 1D linear interpolation with extrapolation in the positive x
%direction
% Performs 1D linear interpolation of 'xi' points using 'x' and 'y', resulting
% in 'yi' following the formula yi = y1 + y1 (y2-y1)/(x2-x1)*xi-x1).
% Returns NaN when 'xi' is Nan.
% 'x'  is column vector [m x 1], monotonically increasing.
% 'y'  is matrix [m x n], corresponding to 'x'.
% 'xi' is column vector [p x 1], in any order.
% 'yi' is matrix [p x n], corresponding to 'xi'.

% Size of 'x' and 'y'
m = size(x,1);
n = size(y,2);

% For each 'xi', get the position of the 'x' element bounding it on the left [p x 1]
[~,xi_pos] = histc(xi,x);
xi_pos = max(xi_pos,1);     % To avoid index=0 when xi < x(1)
xi_pos = min(xi_pos,m-1);   % To avoid index=m+1 when xi > x(end).

% 't' matrix [p x 1]
dxi = xi-x(xi_pos);
dx = x(xi_pos+1)-x(xi_pos);
t = dxi./dx;

% Get 'yi'
yi = y(xi_pos,:) + t(:,ones(1,n)).*(y(xi_pos+1,:)-y(xi_pos,:));

% Give extrapolate the values of 'yi' corresponding to 'xi' out of the range of 'x'
if (all(xi>x(end)))
    delta_x = x(end)-x(end-1);
    delta_y = y(end)-y(end-1);
    extrap_val = xi>x(end);
    yi(extrap_val,:) = delta_y*(xi(extrap_val)-x(end))/delta_x+y(end);
end
if (all(xi<x(1)))
    delta_x = x(2)-x(1);
    delta_y = y(2)-y(1);
    extrap_val = xi<x(1);
    yi(extrap_val,:) = -delta_y*(x(1)-xi(extrap_val))/delta_x+y(1);
end

end

