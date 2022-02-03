function [obj_d] = get_def_con(n0,n1,alpha_cone)
% Get the HIAD deflection constraint

n0(:,2) = [];
n1(:,2) = [];

% Ensure centers of tori lie on 20 degree line
% Equation of line
A = tand(90 - alpha_cone);
B = -1;
C = -A*n0(1,1) + n0(1,2);

% % % % Parameters
% % % tol = 2; % Maximum outer torus deflection
% % % toli = 0:tol/5:tol;
% % % toli = toli(2:end)'.^2;
% % % fac = (5:-1:1)'; % Penalize inner tori more

% Initialize
di = zeros(size(n1,1),1);
for i = 1:size(di,1) - 1
    % Distance squared from 20 degree line
    di(i) = (A*n1(i,1) + B*n1(i,2) + C)^2/(A^2 + B^2);
    
% % %     % Penalize if outside of allowable deflection
% % %     if d(i) < toli(i)
% % %         d(i) = di(i)*fac(i); % 0;
% % %     else
% % %         d(i) = di(i)*fac(i);
% % %     end
end


% Ensure shoulder torus lies at specified angle from outer torus
% Equation of line
A1 = (n0(end,2) - n0(end - 1,2))/(n0(end,1) - n0(end - 1,1));
B1 = -1;
C1 = -A1*n1(end - 1,1) + n1(end - 1,2);

% Distance squared from line
di(end) = (A1*n1(end,1) + B1*n1(end,2) + C1)^2/(A1^2 + B1^2);

% % % % Penalize if outside of allowable deflection
% % % if d(6) < toli(1)
% % %     d(6) = di(6)*fac(1); % 0;
% % % else
% % %     d(6) = di(6)*fac(1);
% % % end


% Sum and factor for constraint
obj_d = sum(di.^2);
% % % def_eqcon = [];
% % % 
% % % fprintf('D = ')
% % % fprintf('\t%5.3f\n',di.^.5)
% % % fprintf('\n')
end

