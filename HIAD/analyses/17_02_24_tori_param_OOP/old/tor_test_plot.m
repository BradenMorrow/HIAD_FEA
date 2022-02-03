function [F00] = tor_test_plot(theta)
% Create variables for plotting analysis output

% Torus processing code folder (does include some junk as well)
% addpath('\\storage-01\Temporary Projects\Projects\1115 NASA HypersonicInflatableDevices\Experimental\Single Torus Testing\Buckling Test Results\JDC Torus Test Matlab 2016-01-07');

%% Torus fitting outputs
% cgall = size {m}(n,6), m = num. of stages, n = number of points on torus
% n is a random number since points come and go at different points in time
% Columns are:
% 0 - Warning: we will be adding a new column with point ID number since ID
% numbers are no longer arbitrary (i.e. if coded, it is on the torus)
% 1 - X coordinate (in) of center of torus cross-section at theta(n)
% 2 - Y coordinate (in) of center of torus cross-section at theta(n)
% 3 - Z coordinate (in) of center of torus cross-section at theta(n)
% 4 - Actual minor radius (in at theta(n), not a precise meas. due to scale
% 5 - Angle from horizontal to Pontos point (rad)
% 6 - Calculated radius of curvature (in) at location
% Presently (2016-05-05) the 10 nearest points in each direction are used
% for a total of 21 to be used for local torus fitting
% cgall0 = load('\\storage-01\Temporary Projects\Projects\1115 NASA HypersonicInflatableDevices\Experimental\Single Torus Testing\Buckling Test Results\Data\2016-02-08\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1\cgall.mat');
cgall0 = load('cgall.mat');
cgall1 = cgall0.cgall';

%%
% data = load('\\storage-01\Temporary Projects\Projects\1115 NASA HypersonicInflatableDevices\Experimental\Single Torus Testing\Buckling Test Results\Data\2016-02-08\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1_Mat.txt');
data = load('2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1_Mat.txt');
mode = data(2:end,5) - data(1:end - 1,5);
modeI = (1:size(mode,1));
modeI = modeI(mode == 1);

shapeI = [1 modeI 329]';

% Cable forces and end displacements
F = data(:,7:4:69);
U = data(:,70:85);

F0 = F(shapeI(2):shapeI(3),:);
U00 = U(shapeI(2):shapeI(3),:);
U1 = U00(1,:);
for i = 1:size(U00,1)
    U00(i,:) = U00(i,:) - U1;
end

% stringpots are columns 70-85 corresponding to above respective LCs
% distances are already pre-corrected for diagonal measurement and cable
% sag to end up being the desired radial deflection. This file has some 
% zeros which indicates a problem (i.e. stringpot fully retracted), which
% we should ask Dan about, but it only occurs are very low loads.

% Convert to cylindrical coordinate system
% Preallocate
cgall2 = zeros(200,3,size(cgall1,1));
tor_nodes = zeros(size(theta,1),3,size(cgall1,1));
tor_nodes_rt = zeros(size(theta,1),3,size(cgall1,1));
Rave = zeros(size(cgall1,1),1);

% Number of waves
n = 100;

% Theta for interpolation
th0 = linspace(0,2*pi,200)';
for i = 1:size(cgall1)
    % Measured from specimen
    r = hypot(cgall1{i}(:,1),cgall1{i}(:,2));
    th = atan2(cgall1{i}(:,2),cgall1{i}(:,1));
    th(th < 0) = th(th < 0) + 2*pi;
    z = cgall1{i}(:,3);
    
    r0 = interp1(th,r,th0,'linear','extrap');
    z0 = interp1(th,z,th0,'linear','extrap');
    
    cgall2(:,:,i) = [r0 th0 z0];
    
    % R-theta location of nodes from Fourier expansion
    [R] = fourier_expansion(th0,r0,n,theta);
    Rave(i) = mean(R);
    [Z] = fourier_expansion(th0,z0,n,theta);
    
    tor_nodes(:,:,i) = [R.*cos(theta) R.*sin(theta) Z];
    tor_nodes_rt(:,:,i) = [R theta Z];
end

% XYZ location of nodes and displacement from perfect geometry
Rave0 = Rave(1);
tor_nodes0 = [Rave0*cos(theta) Rave0*sin(theta) zeros(size(theta))];
tor_nodes1 = tor_nodes(:,:,1);
U0 = [tor_nodes1 - tor_nodes0 zeros(size(tor_nodes0))];
U0 = U0';
U0 = U0(:);




%% Plotting
[R] = fourier_expansion(th0,r0,n,theta);
[Z] = fourier_expansion(th0,z0,n,theta);

% % % figure(100)
% % % clf
% % % box on
% % % hold on
% % % plot(th0*180/pi,r0,'b')
% % % plot(theta*180/pi,R,'rx-')
% % % xlim([0 360])
% % % 
% % % figure(101)
% % % clf
% % % box on
% % % hold on
% % % plot(th0*180/pi,z0,'b')
% % % plot(theta*180/pi,Z,'rx-')
% % % xlim([0 360])
% % % 
% % % figure(102)
% % % clf
% % % axis off
% % % hold on
% % % xlim([0 360])
% % % for i = 1:size(tor_nodes,3)
% % %     plot(theta*180/pi,tor_nodes_rt(:,1,i))
% % % end

%%
th0 = linspace(0,360,32)';
I = shapeI(3);

test_shape = zeros(size(th0,1),3,size(shapeI,1));


%%
% % % figure(103)
% % % clf
% % % hold on

for i = 1:3
    I = shapeI(i);
% % %     subplot(2,1,1)
% % %     box on
% % %     hold on
% % %     plot(th0*180/pi,interp1(cgall2(:,2,I),cgall2(:,1,I),th0),'bx')
% % %     plot(cgall2(:,2,I)*180/pi,cgall2(:,1,I),'b-')
% % %     xlim([0 360])
% % % 
% % %     subplot(2,1,2)
% % %     box on
% % %     hold on
% % %     plot(th0*180/pi,interp1(cgall2(:,2,I),cgall2(:,3,I),th0),'bx')
% % %     plot(cgall2(:,2,I)*180/pi,cgall2(:,3,I),'b-')
% % %     xlim([0 360])
    
    test_shape(:,:,i) = [interp1(cgall2(:,2,I),cgall2(:,1,I),th0*pi/180) th0 interp1(cgall2(:,2,I),cgall2(:,3,I),th0*pi/180)];
end

F_out = sum(F(shapeI,:),2);

save('.\analyses\16_07_13_tori_param\test_out','test_shape','F_out')


%%
figure(3)
clf
box on
hold on
plot(Rave(1:shapeI(end)),sum(F(1:shapeI(end),:),2),'r-')
% plot(Rave(1:end),sum(F(1:end,:),2),'r-')
xlim([69.75 69.95])
ylim([0 5000])

xlabel('Average radius (in)')
ylabel('Total load (lbf)')

leg(1) = plot([-1 -1],[-1 -1],'r-');
leg(2) = plot([-1 -1],[-1 -1],'bx');
legend(leg,'Test','Model')


%%
F00 = F0*0;
for i = 1:16
    F00(:,i) = smooth(F0(:,i),50);
end
F001 = F00(1,:);
for i = 1:size(F00,1)
    F00(i,:) = F00(i,:) - F001; % + 10;
end

figure(4)
clf
box on
hold on
plot(linspace(0,1,size(F00,1)'),F00 + 10,'b-','linewidth',2)

% xlim([0 1])
end

