


it = 100;
n = 1000;
tic

parfor i = 1:it
    a = rand(n);
    b = zeros(it,1);
    b(i) = det(a);
end

toc

