function [d] = get_disp(cg_test,U,gamma,r_minor)
% plot_dvsP
%   Takes data from torus test and plots d vs P

% Angle between +x-axis and first cord
angle = 11.25*pi/180;

% Initialize matrices
D_tor = zeros(size(cg_test,3),8);

% Convert cartesian coordinates to cylindrical
[theta,r] = cart2pol(cg_test(:,1,:),cg_test(:,2,:));
theta(theta < 0) = theta(theta < 0) + 2*pi;

% Zero displacement matrices
for i = 1:16
    U(:,i) = U(:,i) - U(1,i);
end
for i = 1:size(r,1)
    r(i,1,:) = r(i,1,:) - r(i,1,1);
end

% Create vector of angles used in interp function
thetas = angle + (0:7)*pi/4;

% Get D_tor matrix using interp1
for j =1:size(theta,3)
    [theta0,it,~] = unique(reshape(theta(:,1,j),[],1));
    r0 = reshape(r(:,1,j),[],1);
    r0 = r0(it);
    D_tor(j,:) = interp1(theta0,r0,thetas);
end

% Change this is smoothing does not work correctly
limit = .01; % Maximum allowed difference between points

% Compute difference between points
dif = D_tor(2:end,:) - D_tor(1:end - 1,:);

% Smooth D_tor
[D_tor] = fix_data(D_tor,dif,limit);
D_tor = [D_tor D_tor];


% Get displacement matrix
d = -U + D_tor;
end



