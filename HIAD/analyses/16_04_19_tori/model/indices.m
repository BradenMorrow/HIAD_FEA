function [ind] = indices(theta,I_theta_cable,I_theta_support)
% Generate indices of element types

ind.ind1 = (1:size(theta,1))'; % Torus
ind.ind2 = (ind.ind1(end) + 1:ind.ind1(end) + size(I_theta_cable,1)*2)'; % Links
ind.ind3 = (ind.ind2(end) + 1:ind.ind2(end) + size(I_theta_cable,1)*2)'; % Cables
ind.ind4 = (ind.ind3(end) + 1:ind.ind3(end) + size(I_theta_support,1))'; % Vertical supports
ind.ind5 = (ind.ind4(end) + 1:ind.ind4(end) + size(I_theta_support,1))'; % Tangent supports
ind.ind6 = (ind.ind5(end) + 1:ind.ind5(end) + size(I_theta_support,1))'; % Radial supports
ind.ind7 = (ind.ind6(end) + 1:ind.ind6(end) + size(I_theta_cable,1)*2)'; % Radial cable supports
ind.ind8 = (ind.ind7(end) + 1:ind.ind7(end) + size(I_theta_cable,1)*2)'; % Vertical cable supports



