function [G] = get_G(rk,z,e1,L,r1)
%GET_G
%   Get the G matrix

%rk = 3x1 double
%z = 3x1 double
%el = 3x1 double
%L = 1x1 double
%r1 = 3x1 double



A = 1/L*(([1 0 0; 0 1 0; 0 0 1]) - e1*e1');


Mz = -1/L*(A*z*e1' + (A*z*e1')' + A*(e1'*z));
Mrk = -1/L*(A*rk*e1' + (A*rk*e1')' + A*(e1'*rk));
% Mz = get_M(z,e1,L);
% Mrk = get_M(rk,e1,L);

%explicitly do get_S for improved performance
%Srk = get_S(rk); %3x3 double
%Sr1 = get_S(r1); %3x3 double
%Sz = get_S(z); %3x3 double
%Se1 = get_S(e1); %3x3 double
Srk = [0 0 0; 0 0 0; 0 0 0];
Srk(2,1) =rk(3);
Srk(3,1) = -rk(2);
Srk(1,2) = -rk(3);
Srk(3,2) = rk(1);
Srk(1,3) = rk(2);
Srk(2,3) = -rk(1);

Sr1 = [0 0 0; 0 0 0; 0 0 0];
Sr1(2,1) =r1(3);
Sr1(3,1) = -r1(2);
Sr1(1,2) = -r1(3);
Sr1(3,2) = r1(1);
Sr1(1,3) = r1(2);
Sr1(2,3) = -r1(1);

Sz = [0 0 0; 0 0 0; 0 0 0];
Sz(2,1) =z(3);
Sz(3,1) = -z(2);
Sz(1,2) = -z(3);
Sz(3,2) = z(1);
Sz(1,3) = z(2);
Sz(2,3) = -z(1);

Se1 = [0 0 0; 0 0 0; 0 0 0];
Se1(2,1) = e1(3);
Se1(3,1) = -e1(2);
Se1(1,2) = -e1(3);
Se1(3,2) = e1(1);
Se1(1,3) = e1(2);
Se1(2,3) = -e1(1);




g11 = -1/2*(A*z*rk'*A + A*rk*z'*A + rk'*e1*Mz + (e1 + r1)'*z*Mrk); %3x3
g12 = -1/4*(A*z*e1'*Srk + (e1 + r1)'*z*A*Srk + A*rk*z'*Sr1); %3x3
g22 = 1/8*(-(rk'*e1)*Sz*Sr1 + Srk*e1*z'*Sr1 + 2*Sz*Srk + ...
    Sr1*z*e1'*Srk - (e1 + r1)'*z*Se1*Srk); %3x3


G = [0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0     0]; % zeros(12) explicitly state for improved performance

G(1:3,1:3) = g11; %set rows 1 to 3 and cols 1 to 3 to g11
G(4:6,1:3) = g12'; %set rows 4 to 6 and cols 1 to 3 to g12 transposed
G(7:9,1:3) = -g11; %set rows 7 to 9 and cols 1 to 3 to -g11
G(10:12,1:3) = g12'; %set rows 10 to 12 and cols 1 to 3 to g12 transposed

G(1:3,4:6) = g12; %set rows 1 to 3 and cols 4 to 6 to g12
G(4:6,4:6) = g22; %set rows 4 to 6 and cols 4 to 6 to g22
G(7:9,4:6) = -g12; %set rows 7 to 9 and cols 4 to 6 to -g12
G(10:12,4:6) = g22; %set rows 10 to 12 and cols 4 to 6 to g22

G(1:3,7:9) = -g11; %set rows 1 to 3 and cols 7 to 9 to -g11
G(4:6,7:9) = -g12'; %set rows 4 to 6 and cols 7 to 9 to -g12
G(7:9,7:9) = g11; %set rows 7 to 9 and cols 7 to 9 to g11
G(10:12,7:9) = -g12'; %set rows 10 to 12 and cols 7 to 9 to -g12

G(1:3,10:12) = g12; %set rows 1 to 3 and cols 10 to 12 to g12
G(4:6,10:12) = g22; %set rows 4 to 6 and cols 10 to 12 to g22
G(7:9,10:12) = -g12; %set rows 7 to 9 and cols 10 to 12 to -g12
G(10:12,10:12) = g22; %set rows 10 to 12 and cols 10 to 12 to g22

% G = [g11 g12 -g11 g12
%     g12' g22 -g12' g22
%     -g11 -g12 g11 -g12
%     g12' g22 -g12' g22];

end

