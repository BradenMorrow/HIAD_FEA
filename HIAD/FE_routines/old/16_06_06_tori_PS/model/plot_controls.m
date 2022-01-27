function [PLOT] = plot_controls
% Plotting controls for FE analysis

% Plotting flags for FE_plot
PLOT.plot = 1; % 1 = plot output
PLOT.fig = 1; % Figure number
PLOT.scale = 10; % Deformation scale
PLOT.undef = 1; % Plot undeformed shape
PLOT.def = 1; % Plot deformed shape
PLOT.force = 1; % Plot forces
PLOT.number = 0; % Plot node numbers
PLOT.triad = 1; % Plot triad
PLOT.els = [1 1 1 1]'; % Element types to plot [1 2 3];
PLOT.view = 2;

PLOT.plot_inc = 1; % Plot each increment switch
PLOT.plot_iter = 0; % Plot each iteration switch

% Analysis plot
PLOT.plot_shape = 'plot_tor_shape(FEM)';

end

