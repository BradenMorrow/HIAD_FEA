% Plot the convergence of area (innextensable fabric), number of nodes, and
% bending moment.
clear

% For Stiffness
n = 3; % Number of nodes
I = 1e-10; % Bending moment
A = 1*10^5; % Area (for stiffness)


iter = 50; % number of data points to plot
K_mat = zeros(iter, 1); % Preallocate stiffness outputs
n_num = zeros(iter, 1); % Preallocate number of nodes

% Plot of number of nodes vs stiffness
for i = 1:iter
    try
        K_mat(i) = calc_K_ax_driver(n, I, A);
    catch exception
        K_mat(i) = NaN;
        try
            ex(i) = exception;
        catch
        end
    end
    n_num(i) = n;
    n = n+1; %1*(ceil(i/20))
    disp(i)
end

figure(6)
clf
box on
hold on
plot(n_num, K_mat,'rx-')
xlabel('Number of nodes');
ylabel('K');