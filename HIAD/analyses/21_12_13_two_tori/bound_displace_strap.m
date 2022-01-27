function [FEM] = bound_displace_strap(FEM,rebound,theta,C,tor)

final_size = size(FEM.MODEL.B,1)/6;

%% Boundary Conditions for Testing Straps
% Bench 
b1 = zeros(rebound(1,1),6);
b2 = ones(rebound(1,2) - rebound(1,1),6);
b5 = [b1; b2];
b6 = zeros(final_size - rebound(1,2),6);
b = [b5; b6];
b = b';
bound = b(:);
FEM.MODEL.B = bound;

%% Displacement U Vector for Testing Straps
half = ((rebound(1,2)-rebound(1,1))/2);
% May need to change for force analysis
% finding nodes to displace current location
nodes1 = FEM.MODEL.nodes(rebound(1,1)+1:rebound(1,1)+half,:);
nodes2 = FEM.MODEL.nodes(rebound(1,1)+half+1:rebound(1,2),:);
% generating displaced node position
x5 = (0.48*C(1,1))*cos(theta);
y5 = (0.48*C(1,1))*sin(theta);
z5 = C(1,2)*ones(size(theta))-tor(1).r;
nodes3 = [x5 y5 z5];
x6 = (0.48*C(2,1))*cos(theta);
y6 = (0.48*C(2,1))*sin(theta);
z6 = C(2,2)*ones(size(theta))+tor(1).r;
nodes4 = [x6 y6 z6];
% Finding dsiplacment needed
dispnodes1 = nodes1 - nodes3;
dispnodes2 = nodes2 - nodes4;
%% Applying displacement
u2 = [dispnodes1; dispnodes2];

u2(:,4:6) = 0;
% May need to change for force analysis (use U vector instead)
u1 = zeros(rebound(1,1),6);
u3 = zeros(final_size - rebound(1,2),6);
u =[u1; u2; u3];
u = u';
u_pt = u(:);
FEM.MODEL.U_pt = u_pt;

