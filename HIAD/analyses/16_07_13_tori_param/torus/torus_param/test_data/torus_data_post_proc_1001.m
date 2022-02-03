% Script for post processing torus data
% June 23, 2016

% Set directory
dir0 = 'C:\Users\donald.bistri\Desktop\andy';
dir_working = '\\storage-01.umcomposites.umaine.edu\Projects\1115 NASA HypersonicInflatableDevices\Experimental\Single Torus Testing\Buckling Test Results\Data\\2016-02-08\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1';
mat_file_ID = 1001;
csv_file_ID = '2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1.csv';
 
%  Specify indices of interest
ind = (92:330)';
 
% Go to analysis directory
cd(dir_working)
 
% Load data
d = csvread(csv_file_ID);
 
% Get cable displacement
U = d(ind,71:71 + 15);
 
% Get cable forces
P = d(ind,8:4:8 + 15*4);
 
% Load torus shape
load('cgall.mat')
cg = zeros(312,3,size(cgall,2)); % Indices are hard-wired, will need to modify
for i = 1:size(cgall,2)
    cg(:,:,i) = cgall{i}(1:312,:);
end
 
cg0 = cg(:,:,1);
cg_test = cg(:,:,ind);
 
% Save data
cd(dir0)
save(sprintf('torus_%g',mat_file_ID),'U','P','cg','cg_test');
  
% Plotting displacement
figure(1)
clf
box on
hold on
plot(U,'x-')
title('Cable end displacement')
ylabel('Displacement')
xlabel('Points of interest')

% Checking on displacement for linear portion
for i= 71:(71+15)
    displ(i-70) = (d(92,i)-d(330,i));
end
 
%Plotting force
figure(2)
clf
box on
hold on
plot(P)
title('Cable Force')
ylabel('Force')
xlabel('Points of interest')

% Calculating R and theta for points of interest
R = zeros(size(cg_test,1),size(cg_test,3));
theta = zeros(size(cg_test,1),size(cg_test,3));
for i = 1:size(R,2)
    R(:,i) = hypot(cg_test(:,1,i),cg_test(:,2,i));
    theta(:,i) = atan2(cg_test(:,2,i),cg_test(:,1,i));
end

% Arrange theta values as 0-2pi
theta(theta < 0) = theta(theta < 0) + 2*pi;
 
figure(3)
clf

% Plotting r vs theta.
subplot(2,1,1)
xlim([0 2*pi])
hold on
for i = 1:size(R,2)
    plot(theta(:,i),R(:,i))
end
title('r vs theta')
xlabel('theta')
ylabel('radius')

% Plotting z vs theta.
subplot(2,1,2)
xlim([0 2*pi])
hold on
for i = 1:size(R,2)
    plot(theta(:,i),cg_test(:,3,i))
end
title('z vs theta')
xlabel('theta')
ylabel('elevation')
 
 
 
 
 


