% Update the load correction matrix

Knc_pre = zeros(size(FEM.PASS.K));

U = FEM.OUT.U;
P_vec = FEM.ANALYSIS.P_vec;
F1 = Fpre;
ind = size(FEM.EL,1);

U2 = zeros(length(U)/6,6);
F2 = zeros(length(F1)/6,6);
for i = 1:6
    U2(:,i) = U(i:6:length(U));
    F2(:,i) = F1(i:6:length(F));
end

% F2(1,:) = F2(1,:)/2;
% F2(end,:) = F2(end,:)/2;


P = sum(F2.^2,2).^.5;
theta0 = zeros(ind,1);
for j = 1:ind
    theta0(j) = atan2(P_vec(j,2),P_vec(j,1));
end
theta = theta0 + U2(1:ind,6);

count = 1;
l = 6;
for k = 1:6:ind*6
    Knc_pre(k,l) = -P(count)*sin(theta(count)*1);
    Knc_pre(k + 1,l) = P(count)*cos(theta(count)*1);

    count = count + 1;
    l = l + 6;
end


Knc = Knc + Knc_pre;









