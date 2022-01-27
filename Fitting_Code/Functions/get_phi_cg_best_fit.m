function phi = get_phi_cg_best_fit(alpha, x, theta)
pts = [x(4)*cos(alpha) x(4)*sin(alpha) 0];
c6=cos(x(6));c5=cos(x(5));s6=sin(x(6));s5=sin(x(5));
A = [c6 0 s6 x(1);
    s5*s6 c5 -c6*s5 x(2);
    -c5*s6 s5 c5*c6 x(3);
    0 0 0 1];
try
pts = A\[pts';ones(1,size(pts,1))];
catch
    ads
end
thetacomp = atan2pos(pts');
phi = (theta - thetacomp)^2;