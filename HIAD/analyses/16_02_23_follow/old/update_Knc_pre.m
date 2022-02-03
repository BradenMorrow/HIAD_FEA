% Update the load correction matrix

Knc_pre = zeros(size(FEM.PASS.K));
% P = -norm(FEM.BOUND.F)*lambda;

x = size(U,1) - 5;
y = size(U,1) - 4;
theta = size(U,1);

Ppre = norm(Fpre);
Knc_pre([x y],theta) = Ppre*[cos(-U(theta)) -sin(-U(theta))]';

% P*[cos(-U(theta)) -sin(-U(theta))]'

Knc = Knc + Knc_pre;