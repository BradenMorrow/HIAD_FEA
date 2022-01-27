% Plots supports and load frame of torus test setup
test_var.r_m = 6.7; % Minor? radius of torus
test_var.r_t = 129/2; % Major? radius of a torus
test_var.n = 100; % Number of slats in each cylinder
test_var.c_x = 0; % Center of the load frame
test_var.c_y = 0;
test_var.c_l = [.5,.5,.5]; % Color of the load frame
test_var.c_s = [0,0,0]; % Color of the supports
test_var.c_f = [0,.4,0]; % Color of the floor
test_var.f_x = 300; % Dimensions of floor
test_var.f_y = 300;
p_l = 1; % Plot load frame?
p_s = 1; % Plot supports?
p_f = 1; % Plot floor?
fignum = 6; % Figure number

% Call figure, determine limits of color scale
figure(fignum)
hold on
c_a = caxis;

% Run functions
if p_l == 1;
    plot_loadframe(test_var)
end

if p_s == 1;
    plot_supports(test_var)
end

if p_f == 1;
    plot_floor(test_var)
end

% Reset limits of color scale
caxis(c_a)