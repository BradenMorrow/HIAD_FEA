function [PHI] = get_PHI_quat(qi)
%GET_PHI_QUAT
% Get a rotational vector from a quaternion
% de Souza (2000), figure 3.3

% % % q0 = qi(1);
% % % 
% % % if q0 < 0
% % %     qi = -qi;
% % % end

q0 = qi(1);
q = qi(2:4);

if norm(q) == 0
    PHI = [0 0 0]';
    
elseif norm(q) < q0
    PHI = 2*q/norm(q)*asin(norm(q));
else
    PHI = 2*q/norm(q)*acos(q0);
end


end

