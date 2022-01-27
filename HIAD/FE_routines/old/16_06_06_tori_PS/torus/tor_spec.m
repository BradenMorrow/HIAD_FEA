function [tor_nodes0,Rave0,U0] = tor_spec(theta)
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
% % % data = load('\\storage-01\Temporary Projects\Projects\1115 NASA HypersonicInflatableDevices\Experimental\Single Torus Testing\Buckling Test Results\Data\2016-02-08\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1_Mat.txt');
% % % mode = data(2:end,5) - data(1:end - 1,5);
% % % modeI = (1:size(mode,1));
% % % modeI = modeI(mode == 1);
% % % 
% % % % Cable forces and end displacements
% % % F = data(:,7:4:69);
% % % U = data(:,70:85);
% % % 
% % % U = U(modeI:end,:);
% % % U1 = U(1,:);
% % % for i = 1:size(U,1)
% % %     U(i,:) = U(i,:) - U1;
% % % end

% stringpots are columns 70-85 corresponding to above respective LCs
% distances are already pre-corrected for diagonal measurement and cable
% sag to end up being the desired radial deflection. This file has some 
% zeros which indicates a problem (i.e. stringpot fully retracted), which
% we should ask Dan about, but it only occurs are very low loads.

% Convert to cylindrical coordinate system
% Preallocate
cgall2{size(cgall1,1),1} = [];
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
    
    cgall2{i} = [r0 th0 z0];
    
    % R-theta location of nodes from Fourier expansion
    [R] = fourier(th0,r0,n,theta);
    Rave(i) = mean(R);
    [Z] = fourier(th0,z0,n,theta);
    
    tor_nodes(:,:,i) = [R.*cos(theta) R.*sin(theta) Z];
    tor_nodes_rt(:,:,i) = [R theta Z];
end


%%
% XYZ location of nodes and displacement from perfect geometry
Rave0 = Rave(89);
tor_nodes0 = [Rave0*cos(theta) Rave0*sin(theta) zeros(size(theta))];
tor_nodes1 = tor_nodes(:,:,89);
U0 = [tor_nodes1 - tor_nodes0 zeros(size(tor_nodes0))];

% U0(:,3) = 0;

U0 = U0';
U0 = U0(:);




% tor_nodes1 = mean(tor_nodes_rt(:,1,89)) + .004;

% % % %% Plotting
% % % [R] = fourier(th0,r0,n,theta);
% % % [Z] = fourier(th0,z0,n,theta);
% % % 
% % % figure(1)
% % % clf
% % % box on
% % % hold on
% % % plot(th*180/pi,r,'b')
% % % plot(theta*180/pi,R,'rx-')
% % % xlim([0 360])
% % % 
% % % figure(2)
% % % clf
% % % box on
% % % hold on
% % % plot(th*180/pi,z,'b')
% % % plot(theta*180/pi,Z,'rx-')
% % % xlim([0 360])
% % % 
% % % figure(3)
% % % clf
% % % axis off
% % % hold on
% % % xlim([0 360])
% % % for i = 1:size(tor_nodes,3)
% % %     plot(theta*180/pi,tor_nodes1(:,1,i))
% % % end

end

