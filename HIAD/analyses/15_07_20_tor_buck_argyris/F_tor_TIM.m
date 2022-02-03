% Update the force vector

U = FEM.OUT.U;
P_vec = FEM.ANALYSIS.P_vec;
F1 = F - F_old;
ind = size(FEM.EL,1);

U2 = zeros(length(U)/6,6);
F2 = zeros(length(F1)/6,6);
for i = 1:6
    U2(:,i) = U(i:6:length(U));
    F2(:,i) = F1(i:6:length(F));
end

% F2(1,:) = F2(1,:)/2;
% F2(end,:) = F2(end,:)/2;


F3 = zeros(size(U2));
for j = 1:ind
    P = norm(F2(j,:));
    
    theta0 = atan2(P_vec(j,2),P_vec(j,1));
    theta = theta0 + U2(j,6)*1;
    
    F3(j,1) = P*cos(theta);
    F3(j,2) = P*sin(theta);
end

F_inc = F3';
F_inc = F_inc(:);

% FEM.BOUND.F = F_inc;
% FE_plot(FEM)



