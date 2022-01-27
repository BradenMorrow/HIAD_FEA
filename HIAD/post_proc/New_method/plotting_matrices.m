function [ v,f,xyz,X2,Y2,Z2,N,n ] = plotting_matrices( Connect,U2,nodes,...
    orientation,EL,scale,def,n,frac,tor_num )
% plotting_matrices
%   Gets plotting matrices for torus or HIAD

% Undeformed
x = [nodes(Connect(:,1),1) nodes(Connect(:,2),1)];
y = [nodes(Connect(:,1),2) nodes(Connect(:,2),2)];
z = [nodes(Connect(:,1),3) nodes(Connect(:,2),3)];

% Deformed
x1 = [nodes(Connect(:,1),1) + U2(Connect(:,1),1)*scale...
    nodes(Connect(:,2),1) + U2(Connect(:,2),1)*scale];
y1 = [nodes(Connect(:,1),2) + U2(Connect(:,1),2)*scale...
    nodes(Connect(:,2),2) + U2(Connect(:,2),2)*scale];
z1 = [nodes(Connect(:,1),3) + U2(Connect(:,1),3)*scale...
    nodes(Connect(:,2),3) + U2(Connect(:,2),3)*scale];

% Define correct x, y, z inputs
if def == 1
    X2 = x1;
    Y2 = y1;
    Z2 = z1;
else
    X2 = x;
    Y2 = y;
    Z2 = z;
end

% Remove some data, if needed
C = Connect(Connect(:,3) == 3,1);

    C = C(1:frac*2:size(C,1) - (frac*2 - 1),1);


x2 = X2(C,:);
y2 = Y2(C,:);
z2 = Z2(C,:);
N = 2*size(x2,1)/tor_num;

% Initialize matrices
x_plot = [];
y_plot = [];
z_plot = [];

X_plot = zeros(N*(n - 1)*tor_num,1);
Y_plot = zeros(N*(n - 1)*tor_num,1);
Z_plot = zeros(N*(n - 1)*tor_num,1);

% Get CSA outputs
for j = 1:size(x2,1);
    orientation1 = orientation(C(j,1),:)';
    cent1 = [x2(j,1),y2(j,1),z2(j,1)]';
    cent2 = [x2(j,2),y2(j,2),z2(j,2)]';
    
    % Run function
    [x_plot(end + 1:end + 2,:),y_plot(end + 1:end + 2,:),z_plot(end + 1:end + 2,:),xyz(n*j - (n - 1):n*j,:)] = ...
        circular_cross_section(cent1,cent2,orientation1,EL(C(j)).el_in0.r,n);
    
end

% Sort so points are in order
n = n - 1;
[I_c] = sort_plot_var(xyz(1:n,:));
x_plot = x_plot(:,I_c);
y_plot = y_plot(:,I_c);
z_plot = z_plot(:,I_c);
 
% Create vectors with all the pts for one torus before the next and so on
num = size(x_plot,1)*size(x_plot,2)/tor_num;
for i = 1:tor_num
    X_plot((1:num) + num*(i - 1),1) = reshape(x_plot((1:size(x_plot,1)/tor_num) + size(x_plot,1)/tor_num*(i - 1),:),[],1);
    Y_plot((1:num) + num*(i - 1),1) = reshape(y_plot((1:size(x_plot,1)/tor_num) + size(x_plot,1)/tor_num*(i - 1),:),[],1);
    Z_plot((1:num) + num*(i - 1),1) = reshape(z_plot((1:size(x_plot,1)/tor_num) + size(x_plot,1)/tor_num*(i - 1),:),[],1);
    
end

% Create vertices matrix and faces matrix
v = [X_plot,Y_plot,Z_plot];
for i = 1:n*tor_num;
    if mod(i,n) == 0; 
        f(i,:) = [[1:N,1] + N*(i - 1),f(i - (n - 1),1),sort(f(i - (n - 1),1:N),'descend'),N*(i - 1) + 1];
    else
        f(i,:) = [1:N,1,N + 1,sort(N + 1:2*N,'descend'),1] + N*(i - 1);
    end
end
end

