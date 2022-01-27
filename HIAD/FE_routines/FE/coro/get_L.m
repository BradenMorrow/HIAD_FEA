function [L] = get_L(rk,e1,l,r1)
%GET_L
%   Get the L matrix


A = 1/l*([1 0 0; 0 1 0; 0 0 1] - e1*e1');

% Srk = get_S(rk);
% Sr1 = get_S(r1);

% Replace get_S with built in code to improve performance
Srk = [0 0 0; 0 0 0; 0 0 0]; %replace zeros(3) with explicit definition to improve performance
Srk(2,1) = rk(3);
Srk(3,1) = -rk(2);
Srk(1,2) = -rk(3);
Srk(3,2) = rk(1);
Srk(1,3) = rk(2);
Srk(2,3) = -rk(1);

Sr1 = [0 0 0; 0 0 0; 0 0 0]; %replace zeros(3) with explicit definition to improve performance
Sr1(2,1) = r1(3);
Sr1(3,1) = -r1(2);
Sr1(1,2) = -r1(3);
Sr1(3,2) = r1(1);
Sr1(1,3) = r1(2);
Sr1(2,3) = -r1(1);




L1 = rk'*e1*A/2 + A*rk*(e1 + r1)'/2;
L2 = Srk/2 - rk'*e1*Sr1/4 - Srk*e1*(e1 + r1)'/4;

L = [L1; L2; -L1; L2];

end

