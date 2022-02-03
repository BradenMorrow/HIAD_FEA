% Test driver for preloading HIAD model
% June 15, 2016

global Cout

% % % % Strain test input
% % % X0 = [-.000951      % Loop1, aft1
% % %     .0018878        % Loop1, aft2
% % %     .019478         % Loop1, aft3
% % %     .027945         % Loop1, fore1
% % %     .0079268        % Loop1, fore2
% % %     .004279         % Loop1, fore3
% % %     .0025387        % Loop2, aft1
% % %     .020998         % Loop2, aft2
% % %     .030854         % Loop2, aft3
% % %     .018836         % Loop2, fore1
% % %     .041048         % Loop2, fore2
% % %     .027682         % Loop2, fore3
% % %     -.0078438       % Radial, aft
% % %     .034198         % Chevron, aft
% % %     .0022528        % Radial, fore
% % %     .050442];       % Chevron, fore

X0 = [-0.0413583102103508
    0.0438965719702499
    0.0075617450411709
    0.0508019227189263
    0.050353440687263
    -0.0196103026832716
    0.0211866316985072
    0.094752560094688
    0.0649733485203258
    0.0591918282264388
    0.0806845832996047
    0.057955253675411
    0.000410278863645145
    0.0890587353016462
    0.0128955554172369
    0.123798602226613
    -5.32247220972647];

% Apply pretension to straps and analyze
[obj] = apply_preten_cone(X0);






%% Plotting
% HIAD geometry
C = [185.185453 84.342298
	213.724769 94.729760
	242.558759 105.224474
	271.650278 115.812921
	300.963157 126.481936
	322.382105 124.113612];
r = [31.837/2 % Minor radii of tori
    31.837/2
    31.837/2
    31.837/2
    31.837/2
    12.735/2];

theta = linspace(0,2*pi,20)';


[Crot] = rot_HIAD(X0(end),C);

figure(11)
clf
box on
hold on
axis equal
axis off
% xlim([0 350])
% ylim([0 160])
for i = 1:size(r,1)
    plot(C(i,1),C(i,2),'b.')
    plot(r(i)*cos(theta) + C(i,1),r(i)*sin(theta) + C(i,2),'b-')
    
    plot(Cout(i,1),Cout(i,2),'k.')
    plot(r(i)*cos(theta) + Cout(i,1),r(i)*sin(theta) + Cout(i,2),'k--')
    
%     plot(Crot(i,1),Crot(i,2),'g.')
%     plot(r(i)*cos(theta) + Crot(i,1),r(i)*sin(theta) + Crot(i,2),'g-')

end



% x = linspace(165,325,110)';
% plot(x,tand(20)*x + r(1)/cosd(20),'b-')










