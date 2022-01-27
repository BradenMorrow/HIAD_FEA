syms x y z_sym
R = 70;
r = 6.7;
h_off = 16;
eqn = (x^2 + y^2 +z^2 + R^2 - r^2)^2 - 4*R^2*(x^2 + y^2) == 0;%(sqrt(x^2 + y^2) - R)^2 + z_sym^2 == r^2;
angle = 75;
angle = angle.*pi/180;
[~,z] = pol2cart(angle,r);

r_circs = R + cos(angle);
th = 
torus_pts = 