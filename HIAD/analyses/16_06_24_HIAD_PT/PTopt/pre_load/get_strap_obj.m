function [obj] = get_strap_obj(F)
% Get the strap pretension objective

% Target strap forces
F0 = [50 % Loop1, aft1
    50 % Loop1, aft2
    50 % Loop1, aft3
    50 % Loop1, fore1
    50 % Loop1, fore2
    50 % Loop1, fore3
    50 % Loop2, aft1
    50 % Loop2, aft2
    50 % Loop2, aft3
    50 % Loop2, fore1
    50 % Loop2, fore2
    50 % Loop2, fore3
    100 % Radial, aft
    50 % Chevron, aft
    100 % Radial, fore
    50]; % Chevron, fore

Fdiff = (F - F0);
Fdiff([14 16]) = 0;
obj = sum(Fdiff.^2);

fprintf('strap_F = ')
fprintf('\t%5.3f\n',F)
fprintf('\n')
end

