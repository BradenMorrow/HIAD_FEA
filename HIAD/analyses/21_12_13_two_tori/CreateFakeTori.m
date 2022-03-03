min_nodes = 20;

theta = linspace(0,2*pi,min_nodes+1)';
x = 69*cos(theta);
y = 69*sin(theta);
z = 6*ones(size(theta));
tori1 = [x y z];
tori1 = tori1(1:min_nodes,:);
save("tori1.mat","tori1");

min_nodes = 20;

x = 79*cos(theta);
y = 79*sin(theta);
z = zeros(size(theta));
tori2 = [x y z];
tori2 = tori2(1:min_nodes,:);
save("tori2.mat","tori2");