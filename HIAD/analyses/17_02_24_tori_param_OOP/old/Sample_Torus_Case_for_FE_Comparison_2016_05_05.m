% Torus processing code folder (does include some junk as well)
addpath('\\storage-01\Temporary Projects\Projects\1115 NASA HypersonicInflatableDevices\Experimental\Single Torus Testing\Buckling Test Results\JDC Torus Test Matlab 2016-01-07');
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
load('\\storage-01\Temporary Projects\Projects\1115 NASA HypersonicInflatableDevices\Experimental\Single Torus Testing\Buckling Test Results\Data\2016-02-08\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1\cgall.mat')
% torus_pts =  = size {m}(n,3)
% transformed, but otherwise raw Pontos dot coordinates  (in)
% transforming involves rigid body motion correction assuming the test
% fixture to be rigid as well as transformation to FE coordinate system
% (i.e. origin at center of torus with Z = 0 being nominal mid-height of
% cross-section)
load('\\storage-01\Temporary Projects\Projects\1115 NASA HypersonicInflatableDevices\Experimental\Single Torus Testing\Buckling Test Results\Data\2016-02-08\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1\torus_pts.mat')

%%
stage = 1;
data = load('\\storage-01\Temporary Projects\Projects\1115 NASA HypersonicInflatableDevices\Experimental\Single Torus Testing\Buckling Test Results\Data\2016-02-08\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1\2016-02-08_13.45.36_T4AP-1_Buckling_20psi_1_Mat.txt');
forces = sum(data(:,7:4:69),2); % LC 1 bottom 11.25 deg counter-clockwise

F = data(:,7:4:69);
U = data(:,70:85);

loadpts = pi/180*(11.25:45:326.25); % counter-clockise, 1-8 bot., 9-16 top
between = loadpts + 22.5*pi/180;
% stringpots are columns 70-85 corresponding to above respective LCs
% distances are already pre-corrected for diagonal measurement and cable
% sag to end up being the desired radial deflection. This file has some 
% zeros which indicates a problem (i.e. stringpot fully retracted), which
% we should ask Dan about, but it only occurs are very low loads.

for i = 1 : length(cgall)
    [theta,ind] = atan2pos(cgall{i}(:,:));
    % add last and first points for interpolating
    theta = [theta(end)-2*pi;theta;theta(1)+2*pi];
    cgi = [cgall{i}(end,:);cgall{i}(ind,:);cgall{i}(1,:)];
    
    R = sqrt(cgi(:,1).^2+cgi(:,2).^2);
    
    Ravg(i) = mean(interp1(theta,R,loadpts));
    Rbet(i) = mean(interp1(theta,R,between));
    
%     plot3(cgall{i}(:,1),cgall{i}(:,2),cgall{i}(:,3),'b-');
%     plot3(torus_pts{i}(:,1),torus_pts{i}(:,2),torus_pts{i}(:,3),'ro')
end

hold on; box on;
plot(-(Ravg-Ravg(1)),forces,'k')


%% I left this but it may not be of any use
[theta,ind] = atan2pos(cgall{stage}(:,:));
theta = [theta(end)-2*pi;theta;theta(1)+2*pi];
cgi = [cgall{stage}(end,:);cgall{stage}(ind,:);cgall{stage}(1,:)];
R = sqrt(cgi(:,1).^2+cgi(:,2).^2);
Ravg = mean(R(1:end-1));
els = pi/180*[0:11.25:350];
Rall = interp1(theta,R,els);
zall = interp1(theta,cgi(:,3),els);
T4AP_1(:,1) = Rall.*cos(els);
T4AP_1(:,2) = Rall.*sin(els);
T4AP_1(:,3) = zall;