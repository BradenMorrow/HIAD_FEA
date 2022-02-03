function [def_con,def_eqcon] = get_def_con(~)
% Get the HIAD deflection constraint

global Cout

% Ensure centers of tori lie on 20 degree line
% Equation of line
A = tand(20);
B = -1;
C = -A*185.185453 + 84.342298;

% Initialize
di = zeros(size(Cout,1),1);
for i = 1:size(di,1) - 1
    % Distance squared from 20 degree line
    di(i) = (A*Cout(i,1) + B*Cout(i,2) + C)^2/(A^2 + B^2);
end

% Ensure shoulder torus lies at specified angle from outer torus
% Equation of line
A1 = (124.113612 - 126.481936)/(322.382105 - 300.963157);
B1 = -1;
C1 = -A1*Cout(5,1) + Cout(5,2);

% Distance squared from line
di(6) = (A1*Cout(6,1) + B1*Cout(6,2) + C1)^2/(A1^2 + B1^2);

% Sum and factor for constraint
def_con = sum(di);
def_eqcon = [];

fprintf('D = ')
fprintf('\t%5.3f\n',di.^.5)
fprintf('\n')
end

