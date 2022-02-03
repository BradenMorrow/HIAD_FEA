function check_EQ(FEM)
% Check/compare equilibrium of beam and shell FE models

%% SHELL FEM
f1 = csvread('Nodal_Forces.csv',1,0);
m1 = csvread('Nodal_Moments.csv',1,0);
nodes1 = f1(:,[2 4 3]);
F1 = zeros(size(f1,1),3);
FM1 = zeros(size(f1,1),3);
M1 = zeros(size(m1,1),3);
R = hypot(nodes1(:,1),nodes1(:,2));



for i = 1:size(f1)
    F1(i,:) = f1(i,5)*f1(i,[6 8 7]);
    FM1(i,:) = cross(nodes1(i,:),F1(i,:));
    M1(i,:) = m1(i,5)*m1(i,[6 8 7]);
end

Rmin = 32;
F1(R < Rmin,:) = [];
FM1(R < Rmin,:) = [];
M1(R < Rmin,:) = [];

sumF1 = sum(F1);
sumM1 = sum(FM1 + M1);



%% BEAM FEM
[f2] = reorg_vec(FEM.MODEL.F_pt(:,2));
nodes2 = FEM.MODEL.nodes;
F2 = f2(:,1:3);
% % % F2(:,1) = F2(:,1); % *1.2305;
% % % F2(:,2) = F2(:,2)*1;
% % % F2(:,3) = F2(:,3)*1;

M2 = f2(:,4:6);
% % % M2(:,1) = M2(:,1)*1;
% % % M2(:,2) = M2(:,2)*1;
% % % M2(:,3) = M2(:,3)*1;


FM2 = cross(nodes2,F2);

sumF2 = sum(F2);
sumM2 = sum(FM2 + M2);


disp([sumF1; sumF2])
disp((abs(sumF2) - abs(sumF1))./sumF1)
disp([sumM1; sumM2])
disp((abs(sumM2) - abs(sumM1))./sumM1)

end

