function [FEM] = bound_displace_strap(FEM,rebound)

final_size = size(FEM.MODEL.B,1)/6;

%% Boundary Conditions for Testing Straps
% Bench 
for i = rebound(1)+1:1:rebound(2)
    FEM.MODEL.B(i) = 1;
end

