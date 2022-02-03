% Plot the convergence of area (innextensable fabric), number of nodes, and
% bending moment.
clear

% For Stiffness
n = 50; % Number of nodes
I = 1; % Bending moment
A = 10^5; % Area (for stiffness)


iter = 20; % Number of data points to plot
start_I = 10^-5; % Starting I
end_I = 1*10^-10; % Ending I
K_mat = zeros(iter, 1); % Preallocate stiffness outputs
I_iter = zeros(iter, 1); % Preallocate number of nodes
plot_inc = (log10(end_I) - log10(start_I))/(iter-1); % How much to increment by each calculation of K

% Plot the bending moment vs stiffness
for i = 1:iter
    I = 1*10^(log10(start_I) + (i-1)*plot_inc); % Find the current I based on the number of data point
    I_iter(i) = I;
    try
        K_mat(i) = calc_K_ax_driver(n, I, A);
    catch exception
        K_mat(i) = NaN;
        try
            ex(i) = exception;
        catch
        end
    end
    disp(i)
end

figure(6)
clf
box on
hold on
I_iter_plot = -log10(I_iter);
plot(I_iter_plot, K_mat,'rx-')
xlabel('I = 1 * 10^{-x}');
ylabel('K');