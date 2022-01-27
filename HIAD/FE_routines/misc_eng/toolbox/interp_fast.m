function [F] = interp_fast(pt, V_pt, LAMBDA)
% Linear interpolation with extrapolation faster than interp1

% For a 2 colum V_pt
if(length(pt) == 2)
    F = V_pt(:,1)+(LAMBDA-pt(1))*(V_pt(:,2)-V_pt(:,1))/(pt(2)-pt(1)); %linear interpolation of F_pt for a 2 dimensional (two colum) F_pt
else % For a greater than 2 colum F_pt
    F = zeros(size(V_pt,1),1);
    for i = 1:size(V_pt,1)
        F(i) = interp1qr_mex(pt',V_pt(i,:)',LAMBDA);
    end
end
end