function [FEM] = apply_preten(FEM,eps)
% Apply strap pretension
ind = FEM.MODEL.theta_ind;

count = 1;
for i = 14:29
    for j = 1:size(ind(i).ind,1)
        FEM.EL(ind(i).ind(j)).el_in0.eps0 = eps(count);
    end
    count = count + 1;
end



end

