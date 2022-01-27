function [V2] = reorg_vec(V)
% Reorganize U vector   

ind = 1:6:size(V,1);
ind = [ind ind + 1 ind + 2 ind + 3 ind + 4 ind + 5]';
V2 = zeros(length(V)/6,6);
V2(:) = V(ind);

end

