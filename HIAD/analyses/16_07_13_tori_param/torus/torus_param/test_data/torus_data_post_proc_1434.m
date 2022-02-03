% Script for post processing torus data
% June 23, 2016

% Set directory
dir0 = 'C:\Users\irja.hepler\Desktop\andy';
dir_working = '\\storage-01.umcomposites.umaine.edu\Projects\1115 NASA HypersonicInflatableDevices\Torus Data\2016-04-22\2016-04-22_02.12.55_T3AP-1-4Cord_Buckling_20psi_1';
mat_file_ID = 1434;
csv_file_ID = '2016-04-22_02.12.55_T3AP-1-4Cord_Buckling_20psi_1_Mat.txt';

% Specify indices of interest
ind_interest = (95:386)';

% Go to analysis directory
cd(dir_working)

% Load data
d = dlmread(csv_file_ID,',',1,1);

% Get cable displacement
U = d(ind_interest,69:69 + 15);

% Get cable forces
P = d(ind_interest,6:4:6 + 15*4);

% Load torus shape
 load('cgall.mat')
 cgall=cgall';
cg = zeros(86,3,size(cgall,2)); % Indices are hard-wired, will need to modify
for i = 1:size(cgall,2)
    cg(:,:,i) = cgall{i}(1:86,1:3);
end

cg0 = cg(:,:,1);
cg_test = cg(:,:,ind_interest);

% Calculate radius and theta values for points of interest.
R = zeros(size(cg_test,1),size(cg_test,3));
theta = zeros(size(cg_test,1),size(cg_test,3));
for i = 1:size(R,2)
    R(:,i) = hypot(cg_test(:,1,i),cg_test(:,2,i));
    theta(:,i) = atan2(cg_test(:,2,i),cg_test(:,1,i));
end

% Arrange theta values so they go from 0-2pi
theta(theta < 0) = theta(theta < 0) + 2*pi;
% Sorting theta in increasing order and recording indices.
[theta,ind]=sort(theta);

%Assigning R values to corresponding theta values.
for i = 1:size(R,2)
 R1=R(:,i);
 ind1=ind(:,i);
 R1=R1(ind1);
 R(:,i) = R1;
end

% Assigning x,y,z to corresponding theta.
for i=1:size(cg_test,3)
    ind1=ind(:,i);
    cg_test1=cg_test(:,:,i);
    cg_test1(:,1)=cg_test1(ind1,1);
    cg_test1(:,2)=cg_test1(ind1,2);
    cg_test1(:,3)=cg_test1(ind1,3);
    cg_test(:,:,i)=cg_test1;
end

% Save data
cd(dir0)
save(sprintf('torus_%g',mat_file_ID),'U','P','cg','cg_test');

% Displacement plot
figure(1)
clf
box on
hold on
plot(U,'x-')
title('Cable end displacement')
ylabel('Displacement')
xlabel('Points of interest')

% Checking on displacement for linear portion
for i= 69:(69+15)
    displ(i-68) = (d(95,i)-d(386,i));
end
 
% Force plot
figure(2)
clf
box on
hold on
plot(P)
title('Cable Force')
ylabel('Force')
xlabel('Points of interest')

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







