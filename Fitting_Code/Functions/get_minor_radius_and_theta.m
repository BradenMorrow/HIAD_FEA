function [ractual, thetaactual] = get_minor_radius_and_theta(pts,cg)

Rcg = sqrt(cg(:,1)^2 + cg(:,2)^2);
Rpt = sqrt(pts(:,1).^2+pts(:,2).^2);

ractual= sqrt((pts(:,3)-cg(:,3)).^2 + (Rpt-Rcg).^2); % minor radius to point
thetaactual = atan2(pts(:,3)-cg(:,3),Rcg-Rpt);