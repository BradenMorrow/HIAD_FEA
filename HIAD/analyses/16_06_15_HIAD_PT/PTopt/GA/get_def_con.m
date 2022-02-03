function [def_con] = get_def_con(Cout)
% Get the HIAD deflection constraint

% Ensure centers of tori lie on 20 degree line
% Equation of line
A = tand(20);
B = -1;
C = -A*185.185453 + 84.342298;

% Parameters
tol = 2; % Maximum outer torus deflection
toli = 0:tol/5:tol;
toli = toli(2:end)'.^2;
fac = (5:-1:1)'; % Penalize inner tori more

% Initialize
di = zeros(size(Cout,1),1);
d = zeros(size(Cout,1),1);
for i = 1:size(d,1) - 1
    % Distance squared from 20 degree line
    di(i) = (A*Cout(i,1) + B*Cout(i,2) + C)^2/(A^2 + B^2);
    
    % Penalize if outside of allowable deflection
    if d(i) < toli(i)
        d(i) = di(i)*fac(i); % 0;
    else
        d(i) = di(i)*fac(i);
    end
end


% Ensure shoulder torus lies at specified angle from outer torus
% Equation of line
A1 = (124.113612 - 126.481936)/(322.382105 - 300.963157);
B1 = -1;
C1 = -A1*Cout(5,1) + Cout(5,2);

% Distance squared from line
di(6) = (A1*Cout(6,1) + B1*Cout(6,2) + C1)^2/(A1^2 + B1^2);

% Penalize if outside of allowable deflection
if d(6) < toli(1)
    d(6) = di(6)*fac(1); % 0;
else
    d(6) = di(6)*fac(1);
end


% Sum and factor for constraint
def_con = sum(d)*100;

end

