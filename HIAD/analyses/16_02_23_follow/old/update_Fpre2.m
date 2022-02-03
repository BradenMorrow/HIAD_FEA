% Update the force vector

U = FEM.OUT.U;

% Fext = zeros(size(U));

x = size(U,1) - 5;
y = size(U,1) - 4;
theta = size(U,1);

Ppre = norm(Fpre);
Fpre([x y]) = -Ppre*[sin(-U(theta)) cos(-U(theta))]';


% disp([P norm(Fext) norm(FEM.PASS.Fint(61:62))])