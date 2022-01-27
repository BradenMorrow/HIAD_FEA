function [S] = get_S(w)
%GET_S
%   Get the S matrix

S = [0 0 0; 0 0 0; 0 0 0]; %replace zeros(3) with explicit definition to improve performance
S(2,1) = w(3);
S(3,1) = -w(2);
S(1,2) = -w(3);
S(3,2) = w(1);
S(1,3) = w(2);
S(2,3) = -w(1);

% S = [0 -w(3) w(2)
%     w(3) 0 -w(1)
%     -w(2) w(1) 0];


end

