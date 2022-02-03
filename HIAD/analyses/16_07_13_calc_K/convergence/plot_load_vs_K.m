% Plot the stiffness vs the load
clear


iter = 10; % Number of data points to plot
start_Load = 1; % Starting Load lb/in
end_Load = 100; % Ending Load lb/in
K_mat = zeros(iter, 1); % Preallocate stiffness outputs
Load_iter = zeros(iter, 1); % Preallocate number of nodes
plot_inc = (end_Load - start_Load)/(iter-1); % How much to increment by each calculation of K

% Plot the bending moment vs stiffness
for i = 1:iter
    Load = start_Load + (i-1)*plot_inc; % Find the current A based on the number of data point
    Load_iter(i) = Load;
    try
        K_mat(i) = calc_K_shear_driver(Load);
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
L_iter_plot = (Load_iter);
plot(L_iter_plot, K_mat,'rx-')
xlabel('Load lb');
ylabel('K');