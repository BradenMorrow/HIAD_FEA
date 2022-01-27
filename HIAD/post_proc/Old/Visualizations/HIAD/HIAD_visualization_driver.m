
% Plots nosecone and centerbody of torus

% Input variables
HIAD_vis.n = 504; % Slats on cylinder, part of sphere
HIAD_vis.h_c1 = 100; % Height of cylinders (centerbody)
HIAD_vis.h_c2 = 20;
HIAD_vis.h_c3 = 20;
HIAD_vis.r_c1= 170; % Radius of top of nose cone
HIAD_vis.r_c2 = 140; % Radii of other cylinders on centerbody
HIAD_vis.r_c3 = 110;
HIAD_vis.c_t = 1; % Nose cone connected to torus?
HIAD_vis.c_n = [.6 .6 .6]; % Color of the nose cone
HIAD_vis.c_c = [.6 .6 .6]; % Color of the cylinder
HIAD_vis.angle = 70; % Angle of hiad
HIAD_vis.t_cx = 185.185453; % Center of first torus
HIAD_vis.t_cz = 84.342298;
HIAD_vis.t_r = 31.837/2; % Radius of first torus

fignum = 2; % Figure number
p_c = 1; % Plot centerbody?
p_n = 1; % Plot nosecone?

figure(fignum)
hold on


% Run functions
if p_c == 1
    plot_centerbody(HIAD_vis)
end

if p_n == 1
    plot_nosecone(HIAD_vis)
end





