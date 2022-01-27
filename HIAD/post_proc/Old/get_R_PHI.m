function [R] = get_R_PHI(PHI)

%----------------------------------------------------------%
%--                     GET_R_PHI                        --%
%--      Get rotation matrix from rotation vector        --%
%--                   Andrew Young                       --%
%--                Updated 5/29/2015                     --%
%--                   Project 1263                       --%
%----------------------------------------------------------%

phi = norm(PHI);
S_PHI = get_S(PHI);
S_PHI2 = PHI*PHI' - (PHI'*PHI)*eye(3);

% % % w = 2*tan(phi/2)/phi*PHI; %[S_PHI(3,2) S_PHI(1,3) S_PHI(2,1)]';
% % % S_w = get_S(w);
% % % S_w2 = w*w' - norm(w)*eye(3);
% % % 
% % % R = eye(3) + 1/(1 + (w'*w)/4)*(S_w + S_w2/2); % (3.36)

R = eye(3) + sin(phi)/phi*S_PHI + (1 - cos(phi))/phi^2*S_PHI2; % (3.21)

R = normc(R);

if norm(PHI) == 0 || isnan(norm(PHI))
    R = eye(3);
end

end

