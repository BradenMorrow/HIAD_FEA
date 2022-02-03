function [nodes,R,U0,Rave,cyl_nodes,pp] = tor_param(theta,R,n_cable)
% Parameterized perfect geometry

Rave = R*ones(size(theta));
nodes = [R*cos(theta) R*sin(theta) theta*0];
cyl_nodes = [R*ones(size(theta)) theta theta*0];

U0 = theta*0;

pp(n_cable*2).d = [];
pp(n_cable*2).k = [];

for i = 1:n_cable*2
    pp(i).d = spline([0 1],[0 29e6]);
    pp(i).k = spline([0 1],[29e6 29e6]);
end

end

