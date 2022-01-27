function points_w_extra = get_indices_IH(x0, y0, z0, n)
pts_orig = [x0,y0,z0];
oend = size(x0,1);
points_w_extra = [zeros(n,3); pts_orig; zeros(n,3)];

points_w_extra(1:n,:) = pts_orig(end - n + 1:end,:);
points_w_extra(oend+n+1:end,:) = pts_orig(1:n,:);