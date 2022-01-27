function [Y] = fourier_expansion(t,y,n,theta)
% Fourier expansion
% t = input 'time'
% y = input y(t)
% n = number of waves
% theta = output theta
% Y = output Y(theta)

% Period and frequency
T = 2*pi;
omega = 2*pi/T;

% Initialize
% theta = interp1((t - t(1))/t(end),t,linspace(0,1,nn))';

% Mean
A0 = 1/T*sum((y(2:end) + y(1:end - 1))/2.*(t(2:end) - t(1:end - 1)));

ind = (1:n)'; %set the indices to be 1 to n

% Calculate coefficient of An
Cs = cos(ind*omega*t')'; %take the cos of 1 to n time omega times t, each colum corresponds to one element of An
an = bsxfun(@times, y, Cs); %element multiply Cs by y
an_sum = (an(2:end,:) + an(1:end - 1, :)) / 2; %an of rows 2 to the end plus rows 1 to (end - 1) all divided by 2
t_sum = (t(2:end) - t(1:(end-1))); %t of rows 2 to the end minus rows 1 to (end - 1) all divided by 2
tot_sum_a = t_sum' * an_sum; %sum the rows of an_sum by multiplying each colum of an_sum by t_sum transposed, the result is the size of An
An = (2/T*tot_sum_a)'; %calculate the coeficcent

%Calculate coefficient of Bn
Sn = sin(ind*omega*t')'; %take the cos of 1 to n time omega times t, each colum corresponds to one element of An
bn = bsxfun(@times, y, Sn); %element multiply Cs by y
bn_sum = (bn(2:end,:) + bn(1:end - 1, :)) / 2; %an of rows 2 to the end plus rows 1 to (end - 1) all divided by 2
tot_sum_b = t_sum' * bn_sum; %sum the rows of an_sum by multiplying each colum of an_sum by t_sum transposed, the result is the size of An
Bn = (2/T*tot_sum_b)'; %calculate the coeficcent




% Calculate coeficients
% for j = 1:n
%     an = y.*cos(j*omega*t);
%     An(j) = 2/T*sum(((an(2:end) + an(1:end - 1))/2).*(t(2:end) - t(1:end - 1)));
    
%     bn = y.*sin(j*omega*t);
%     Bn(j) = 2/T*sum(((bn(2:end) + bn(1:end - 1))/2).*(t(2:end) - t(1:end - 1)));
% end

% Fourier expansion approximation
% Initialize
Y = A0*ones(length(theta),1);

C = cos(ind*theta');
S = sin(ind*theta');
temp = An'*C + Bn'*S;
Y(:) = Y(:) + temp(:);

% for j = 1:length(theta) % For each 'time' step
%     for k = 1:n % Sum each component
%         Y(j) = Y(j) + An(k)*cos(k*theta(j)) + Bn(k)*sin(k*theta(j));
%     end
% end


end

