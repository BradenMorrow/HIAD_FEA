function [theta, ind] = atan2pos(pts)

theta = atan2(pts(:,2),pts(:,1));
theta(theta<0,:) = theta(theta<0,:) + 2*pi;
[theta, ind] = sort(theta);