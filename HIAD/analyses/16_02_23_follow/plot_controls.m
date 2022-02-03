function [PLOT] = plot_controls
% Plotting controls for FE analysis

% Plotting flags for FE_plot
PLOT.plot = 10; % 1 = plot output
PLOT.fig = 1; % Figure number
PLOT.scale = 1; % Deformation scale
PLOT.undef = true; % Plot undeformed shape
PLOT.def = true; % Plot deformed shape
PLOT.force = false; % Plot forces
PLOT.number = false; % Plot node numbers
PLOT.triad = false; % Plot triad
PLOT.els = [1 1 1 1]'; % Element types to plot [1 2 3];
PLOT.view = 2;

PLOT.plot_inc = true; % Plot each increment switch
PLOT.plot_iter = false; % Plot each iteration switch

% Analysis plot
PLOT.plot_shape = 'cant_def(FEM)';

end

