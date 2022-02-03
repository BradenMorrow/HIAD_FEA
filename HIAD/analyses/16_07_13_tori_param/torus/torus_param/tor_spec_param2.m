function [tor_nodes0,Rave0,U0,Rave,tor_nodes_cyl] = tor_spec_param2(theta,tor_test)
% Preprocess the torus test output for use with FE model

% Load test output
cg_test = tor_test.cg_test;
cg_test_cyl = zeros(size(cg_test));
dR = tor_test.dR;

% Preallocate
tor_nodes = zeros(size(theta,1),3,size(cg_test,3));
tor_nodes_cyl = zeros(size(theta,1),3,size(cg_test,3));
Rave = zeros(size(cg_test,3),1);

% Number of waves in Fourier expansion
n = 100;

% Theta for interpolation
th0 = linspace(0,2*pi,size(cg_test,1))';
for i = 1:size(cg_test,3)
    % Measured from specimen
    r = hypot(cg_test(:,1,i),cg_test(:,2,i));
    th = atan2(cg_test(:,2,i),cg_test(:,1,i));
    th(th < 0) = th(th < 0) + 2*pi;
    z = cg_test(:,3,i);
    z = z - mean(z);
    
    % Makesure theta is monotonically increasing
    mono_check = th(2:end) - th(1:end - 1) <= 0;
    r(mono_check) = [];
    th(mono_check) = [];
    z(mono_check) = [];
    
    % Re-interpolate test data
    r0 = interp1(th,r,th0,'linear','extrap');
    z0 = interp1(th,z,th0,'linear','extrap');
    cg_test_cyl(:,:,i) = [r0 th0 z0];
    
    % R-theta location of nodes from Fourier expansion
    [R] = fourier_expansion(th0,r0,n,theta);
    Rave(i) = mean(R);
    [Z] = fourier_expansion(th0,z0,n,theta);
    
    % Location of nodes in cartesian and cylindrical coordinates
    tor_nodes(:,:,i) = [(R + dR).*cos(theta) R.*sin(theta) Z];
    tor_nodes_cyl(:,:,i) = [(R + dR) theta Z];
end


%%
% XYZ location of nodes and displacement from perfect geometry
Rave0 = Rave(1);
% tor_nodes0 = [Rave0*cos(theta) Rave0*sin(theta) zeros(size(theta))]; % Perfect geometry
tor_nodes0 = tor_nodes(:,:,1);
tor_nodes1 = tor_nodes(:,:,1);
U0 = [tor_nodes1 - tor_nodes0 zeros(size(tor_nodes0))];
U0 = U0';
U0 = U0(:);




%% Plotting
step = 1;

% Test data
r = cg_test_cyl(:,1,step);
th = cg_test_cyl(:,2,step);
z = cg_test_cyl(:,3,step);

% Model
R = tor_nodes_cyl(:,1,step);
Z = tor_nodes_cyl(:,3,step);

theta(theta > 2*pi) = theta(theta > 2*pi) - 2*pi;
[theta,I] = sort(theta);


%%
figure(3)
% clf

subplot(2,1,1)
box on
hold on
plot(th*180/pi,r,'b')
plot(theta*180/pi,R(I),'r-','linewidth',2)
xlim([0 360])

subplot(2,1,2)
box on
hold on
plot(th*180/pi,z,'b')
plot(theta*180/pi,Z(I),'r-','linewidth',2)
xlim([0 360])

% % % figure(3)
% % % clf
% % % axis off
% % % hold on
% % % xlim([0 360])
% % % for i = 1:size(tor_nodes,3)
% % %     plot(theta*180/pi,tor_nodes1(:,1,i))
% % % end

end

