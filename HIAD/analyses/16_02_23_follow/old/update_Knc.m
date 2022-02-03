% Update the load correction matrix

Knc = zeros(size(FEM.PASS.K));
P = norm(FEM.MODEL.F)*lambda;

x = size(U,1) - 5;
y = size(U,1) - 4;
theta = size(U,1);

Knc([x y],theta) = P*[cos(-U(theta)) -sin(-U(theta))]';

% P*[cos(-U(theta)) -sin(-U(theta))]'