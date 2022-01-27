function [strap_F] = get_strap_F(FEM)
% Get the strap set forces
% May 11, 2016

ind = FEM.MODEL.theta_ind;
strap_F = zeros(16,1);

count = 1;
for i = 14:29
    strap_F(count) = FEM.OUT.fint_el(7,ind(i).ind(1),2);
    count = count + 1;
end

end

