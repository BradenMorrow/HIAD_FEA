function [PHI] = get_PHI_R(R)
%GET_R_PHI
%   Get rotation vector from rotation matrix

S = R - R';
S_axial = -[S(3,2) S(3,1) S(1,2)]';

PHI = asin(1/2*norm(S_axial))*S_axial/norm(S_axial);

if isnan(PHI)
    PHI = [0 0 0]';
end

end

