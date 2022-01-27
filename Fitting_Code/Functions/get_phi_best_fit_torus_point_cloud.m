function phi = get_phi_best_fit_torus_point_cloud(X1, pts, r)

pts2 = zeros(size(pts));
c6 = cos(X1(6));
c5 = cos(X1(5));
s6 = sin(X1(6));
s5 = sin(X1(5));
pts2(:,1) = X1(1) + c6*pts(:,1)+s6*pts(:,3);
pts2(:,2) = X1(2) + c5*pts(:,2)-c6*s5*pts(:,3)+s5*s6*pts(:,1);
pts2(:,3) = X1(3)+s5*pts(:,2)+c5*c6*pts(:,3)-c5*s6*pts(:,1);
ractual = hypot(pts2(:,3),hypot(pts2(:,1),pts2(:,2))-X1(4)); % minor radius to point
phi=norm(r-ractual);
% if X1(4) > 100
%     phi = 10^8;
% end