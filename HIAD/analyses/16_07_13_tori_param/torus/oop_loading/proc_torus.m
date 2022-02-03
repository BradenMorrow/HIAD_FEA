function [U,P,R,theta,z,cg_cyl,cg,gamma_int] = proc_torus(d,cgall,ind)
% Process the torus shape

% Load data
d = d(ind,:);

% Load torus shape
cgall = cgall(ind);

% Check data
for i = 1:size(cgall,1)
    cgall{i}(abs(cgall{i}(:,1)) > 100,:) = [];
    cgall{i}(abs(cgall{i}(:,2)) > 100,:) = [];
    cgall{i}(abs(cgall{i}(:,3)) > 100,:) = [];
end

% Get cable displacement and forces
U = d(:,71 - 2:71 + 15 - 2);
P = d(:,8 - 2:4:8 + 15*4 - 2);

% Geometry
% Calculate R, theta and z
R = cell(size(cgall));
theta = cell(size(cgall));
z = cell(size(cgall));
gamma = cell(size(cgall));
for j = 1:size(cgall,1)
    R{j} = hypot(cgall{j}(:,1),cgall{j}(:,2));
    theta{j} = atan2(cgall{j}(:,2),cgall{j}(:,1));
    z{j} = cgall{j}(:,3);
    
    gamma{j} = cgall{j}(:,5);
    
    % Arrange theta values as 0-2pi
    theta{j}(theta{j} < 0) = theta{j}(theta{j} < 0) + 2*pi;
end

% Reinterpolate geometry
n = 500;
cg_cyl = zeros(n,3,size(cgall,1));
cg = zeros(n,3,size(cgall,1));
gamma_int = zeros(n,size(cgall,1));
for k = 1:size(cgall,1)
    % In cylindrical coordinates
    th = linspace(theta{k}(1),theta{k}(end),n)';
    cg_cyl(:,1,k) = interp1(theta{k},R{k},th)';
    cg_cyl(:,2,k) = th;
    cg_cyl(:,3,k) = interp1(theta{k},z{k},th)';
    
    % In cartesian
    cg(:,1,k) = cg_cyl(:,1,k).*cos(th);
    cg(:,2,k) = cg_cyl(:,1,k).*sin(th);
    cg(:,3,k) = cg_cyl(:,3,k);
    
    % Twist of cross section
    gamma_int(:,k) = interp1(theta{k},gamma{k},th)';
%     gamma_int(:,k) = gamma_int(:,k) - gamma_int(:,1);
end


end

