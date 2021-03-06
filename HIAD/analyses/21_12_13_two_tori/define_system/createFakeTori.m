function [] = createFakeTori()

min_nodes = 400;

theta = linspace(0,2*pi,min_nodes+1)';
x = 69*cos(theta);
y = 69*sin(theta);
z = 6*ones(size(theta));
tori1 = [x y z];
tori1 = tori1(1:min_nodes,:);
save("T4.mat","tori1");

min_nodes = 400;

x = 79*cos(theta);
y = 79*sin(theta);
z = zeros(size(theta));
tori2 = [x y z];
tori2 = tori2(1:min_nodes,:);
save("T5.mat","tori2");
plot3(x,y,z)
