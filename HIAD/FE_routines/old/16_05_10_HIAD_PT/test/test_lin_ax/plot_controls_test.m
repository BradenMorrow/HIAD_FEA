function [PLOT] = plot_controls_test
% Plotting controls for FE analysis

% Plotting flags for FE_plot
PLOT.plot = 1; % 1 = plot output
PLOT.fig = 1; % Figure number
PLOT.scale = 100; % Deformation scale
PLOT.undef = 1; % Plot undeformed shape
PLOT.def = 1; % Plot deformed shape
PLOT.force = 1; % Plot forces
PLOT.number = 0; % Plot node numbers
PLOT.triad = 1; % Plot triad
PLOT.els = [0 0 0 1]'; % Element types to plot [1 2 3];
PLOT.view = 2;

PLOT.plot_inc = 1; % Plot each increment switch
PLOT.plot_iter = 1; % Plot each iteration switch

% Analysis plot
PLOT.plot_shape = 'ax_test_plot(FEM)';

end

