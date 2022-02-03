% Update the force vector

U = FEM.OUT.U;
% P = -FEM.PASS.f_norm;
P = -norm(F - F_old);

F_inc = F; %zeros(size(U));

x = size(U,1) - 5;
y = size(U,1) - 4;
theta = size(U,1);
% F_inc([x y]) = LAMBDA0*P*[sin(-U(theta)) cos(-U(theta))]';
F_inc([x y]) = P*[sin(-U(theta)) cos(-U(theta))]';


% disp([P norm(F_inc) norm(FEM.PASS.Fint(61:62))])