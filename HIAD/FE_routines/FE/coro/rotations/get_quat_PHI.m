function [qi] = get_quat_PHI(PHI)
%GET_QUAT
%   Get unit quaternions from a rotational vector

phi = norm(PHI);
qi = zeros(4,1);
qi(1) = cos(phi/2);
qi(2:4) = sin(phi/2)*PHI; % /phi; % To normalize, divide by norm of PHI

% qi = qi/norm(qi);

if phi ~= 0
    qi(2:4) = qi(2:4)/phi;
end

end

