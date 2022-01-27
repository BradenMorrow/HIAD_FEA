function [PLOT] = plot_controls_beam_1el
% Plotting controls for FE analysis

% Plotting flags for FE_plot
PLOT.plot = 1; % 1 = plot output
PLOT.fig = 1; % Figure number
PLOT.scale = 1; % Deformation scale
PLOT.undef = true; % Plot undeformed shape
PLOT.def = true; % Plot deformed shape
PLOT.force = true; % Plot forces
PLOT.number = false; % Plot node numbers
PLOT.triad = true; % Plot triad
PLOT.els = [1 1 1 1]'; % Element types to plot [1 2 3];
PLOT.view = 2;

PLOT.plot_inc = true; % Plot each increment switch
PLOT.plot_iter = true; % Plot each iteration switch

% Analysis plot
nDOF = 0;
PLOT.plot_shape = sprintf('misc_plot_28OCT15_2(FEM,%g)',nDOF);

end

