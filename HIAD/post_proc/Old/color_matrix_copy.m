function [ color_plot ] = color_matrix( u_comp,Connect,U2,n,x_plot )
% color_matrix 
%   Gets color matrix for figures with color plot (post_proc)

% Initialize color matrices
x_color0 = zeros(size(U2,1),n);
y_color0 = zeros(size(U2,1),n);
z_color0 = zeros(size(U2,1),n);
c_color0 = zeros(size(U2,1),n);

% Populate color matrices
for k = 1:size(U2,1)
    if Connect(k,3) == 3 % 5
        % Populate color matrices
        x_color0(k,:) = U2(k,1);
        y_color0(k,:) = U2(k,2);
        z_color0(k,:) = U2(k,3);
        c_color0(k,:) = sum(U2(k,1:3).^2)^.5;
    end
end

% Determine specific color matrix
if u_comp == 1
    color_plot0 = x_color0;
elseif u_comp == 2
    color_plot0 = y_color0;
elseif u_comp == 3
    color_plot0 = z_color0;
else
    color_plot0 = c_color0;
end

% Transpose color matrix
color_plot1 = color_plot0';
% Vectorize color matrix
color_plot2 = color_plot1(:);
% Transpose color vector
color_plot3 = color_plot2';

% Create final color matrix
color_plot = [color_plot3(1:end - n)
    color_plot3(n + 1:end)
    color_plot3(n + 1:end)
    color_plot3(1:end - n)];

if numel(unique(Connect(:,3)))>1
    color_plot = color_plot(1:4,1:size(x_plot,2) - n);

%     for j = 1:n
%         color_plot(1:4,end+j) = [color_plot(2,end-(n-j))
%             color_plot(1,1+j-1)
%             color_plot(4,1+j-1)
%             color_plot(3,end-(n-j))];
%     end
end
color_plot(:,end + 1:end + n) = repmat([color_plot(2,size(x_plot,2) - n);...
    color_plot(1,1);color_plot(4,1);color_plot(3,size(x_plot,2) - n)],1,n);
end

