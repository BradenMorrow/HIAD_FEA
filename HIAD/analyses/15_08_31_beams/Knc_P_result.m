% Update the load correction matrix

Knc = zeros(size(FEM.PASS.K));
P = -FEM.EL(2,1).el_in0.p*pi*FEM.EL(2,1).el_in0.r^2;

theta = U(12);


% % % x = size(U,1) - 5;
% % % y = size(U,1) - 4;
% % % theta = size(U,1);


F_pre([7 8]) = P*[cos(theta) sin(theta)]';
Knc([7 8],12) = P*[-sin(theta) cos(theta)]';
% F_pre([7 8]) = P*[cos(theta) 0]';
% Knc([7 8],12) = P*[-sin(theta) 0]';



a = 1;