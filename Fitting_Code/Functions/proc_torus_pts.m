function [r_tp,th_tp,z_tp,all_pts] = proc_torus_pts(torus_pts)


all_pts = [];
for i = 1:length(torus_pts)
    all_pts = [all_pts;torus_pts{i}(:,1)];
end
all_pts = unique(all_pts);

n = length(all_pts);
x = nan(length(torus_pts),n);
y = x;
z = x;
for i = 1:length(torus_pts)
    tp = torus_pts{i};
    [la,lb] = ismember(all_pts,tp(:,1));
    x(i,la) = tp(lb(~~lb),2)';
    y(i,la) = tp(lb(~~lb),3)';
    z(i,la) = tp(lb(~~lb),4)';
end
z_tp = z;
[th_tp,r_tp] = cart2pol(x,y);
% xd = x - x(1,:);
% yd = y - y(1,:);
% zd = z - z(1,:);

% rd = r(1,:) - r;