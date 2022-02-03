function [orient_out] = orient_tor(orient,U)
% Update orientation nodes for torus

d_or = zeros(size(orient));
L = 100;

for i = 1:size(orient,1)
    dx = L*tan(U(i,4));
    dy = L*tan(U(i,5));
    dz = 0;
    d_or(i,:) = [dx dy dz];
end

orient_out = orient + d_or; % *10;
end

