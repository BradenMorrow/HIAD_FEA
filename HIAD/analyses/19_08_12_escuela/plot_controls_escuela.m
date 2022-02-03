function [PLOT] = plot_controls_load_frame
% Plotting controls for FE analysis

% Plotting flags for FE_plot
PLOT.plot = 1; % 1 = plot output
PLOT.fig = 1; % Figure number
PLOT.scale = 20; % Deformation scale
PLOT.undef = true; % Plot undeformed shape
PLOT.def = true; % Plot deformed shape
PLOT.force = true; % Plot forces
PLOT.number = true; % Plot node numbers
PLOT.triad = true; % Plot triad
PLOT.els = [1 1 1 1]'; % Element types to plot [1 2 3];
PLOT.view = 3;

PLOT.plot_inc = true; % Plot each increment switch
PLOT.plot_iter = false; % Plot each iteration switch

% Analysis plot
PLOT.plot_shape = '';

end

