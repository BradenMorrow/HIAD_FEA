function [ color_plot ] = color_matrix( u_comp,Connect,U2,n,frac,N,tor_num )
% color_matrix 
%   Gets color vector for figures with color plot (post_proc)

% Resize U2
U2 = U2(Connect(Connect(:,3) == 3),:);
if frac ~= 1
    I = [];
    for i = 1:size(U2,1)/(frac*2)
        I = [I, (1:2) + (i - 1)*frac*2];
    end
    U2 = U2(I,:);
end

% Initialize color matrices
x_color0 = zeros(size(U2,1),n);
y_color0 = zeros(size(U2,1),n);
z_color0 = zeros(size(U2,1),n);
c_color0 = zeros(size(U2,1),n);

X_color0 = zeros(N*n*tor_num,1);
Y_color0 = zeros(N*n*tor_num,1);
Z_color0 = zeros(N*n*tor_num,1);
C_color0 = zeros(N*n*tor_num,1);

% Populate color matrices
for k = 1:size(U2,1);
    % Populate color matrices
    x_color0(k,:) = U2(k,1)*ones(1,n);
    y_color0(k,:) = U2(k,2)*ones(1,n);
    z_color0(k,:) = U2(k,3)*ones(1,n);
    c_color0(k,:) = sum(U2(k,1:3).^2)^.5*ones(1,n);
end

% Reshape into vectors
num = size(x_color0,1)*size(x_color0,2)/tor_num;
for i = 1:tor_num
    X_color0((1:num) + num*(i - 1),1) = reshape(x_color0((1:size(x_color0,1)/tor_num) + size(x_color0,1)/tor_num*(i - 1),:),[],1);
    Y_color0((1:num) + num*(i - 1),1) = reshape(y_color0((1:size(x_color0,1)/tor_num) + size(x_color0,1)/tor_num*(i - 1),:),[],1);
    Z_color0((1:num) + num*(i - 1),1) = reshape(z_color0((1:size(x_color0,1)/tor_num) + size(x_color0,1)/tor_num*(i - 1),:),[],1);
    C_color0((1:num) + num*(i - 1),1) = reshape(c_color0((1:size(x_color0,1)/tor_num) + size(x_color0,1)/tor_num*(i - 1),:),[],1);
end
% Determine specific color vector
if u_comp == 1
    color_plot = X_color0;
elseif u_comp == 2
    color_plot = Y_color0;
elseif u_comp == 3
    color_plot = Z_color0;
else
    color_plot = C_color0;
end
end

