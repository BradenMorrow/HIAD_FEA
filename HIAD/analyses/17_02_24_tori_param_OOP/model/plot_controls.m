function [PLOT] = plot_controls
% Plotting controls for FE analysis

% Plotting flags for FE_plot
PLOT.plot = 1; % 1 = plot output
PLOT.fig = 1; % Figure number
PLOT.scale = 10; % Deformation scale
PLOT.undef = true; % Plot undeformed shape
PLOT.def = true; % Plot deformed shape
PLOT.force = true; % Plot forces
PLOT.number = false; % Plot node numbers
PLOT.triad = false; % Plot triad
PLOT.els = [1 1 1 1]'; % Element types to plot [1 2 3 4];
PLOT.view = 3;

PLOT.plot_inc = true; % Plot each increment switch
PLOT.plot_iter = false; % Plot each iteration switch

% Analysis plot
PLOT.plot_shape = 'plot_tor_shape_09DEC16(FEM)';

end

