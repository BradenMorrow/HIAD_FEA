% Plot the convergence of area (innextensable fabric), number of nodes, and
% bending moment.
clear

% For Stiffness
n = 50; % Number of nodes
I = 1e-7; % Bending moment
A = 1e5; % Area (for stiffness)


iter = 10; % Number of data points to plot
start_A = 1*10^-2; % Starting A
end_A = 1*10^3; % Ending A
K_mat = zeros(iter, 1); % Preallocate stiffness outputs
A_iter = zeros(iter, 1); % Preallocate number of nodes
plot_inc = (log10(end_A) - log10(start_A))/(iter-1); % How much to increment by each calculation of K

% Plot the bending moment vs stiffness
for i = 1:iter
    A = 1*10^(log10(start_A) + (i-1)*plot_inc); % Find the current A based on the number of data point
    A_iter(i) = A;
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
A_iter_plot = log10(A_iter);
plot(A_iter_plot, K_mat,'r*')
xlabel('Area  1 * 10^{x}');
ylabel('K');