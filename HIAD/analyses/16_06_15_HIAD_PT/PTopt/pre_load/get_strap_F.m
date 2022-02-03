function [strap_F] = get_strap_F(FEM)
% Get the strap set forces
% May 11, 2016

% Extract strap incices
ind = FEM.MODEL.theta_ind;

% Preallocate
strap_F = zeros(16,1);

% Index of strap to get internal force from
strap_i = 6;

% Loop through straps
count = 1;
for i = 14:29
    strap_F(count) = FEM.OUT.fint_el(7,ind(i).ind(strap_i),2); % Get strap force
    count = count + 1;
end

end

