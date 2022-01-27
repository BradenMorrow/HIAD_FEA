function [c,ceq] = mycon(x)

x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);
x5 = x(5);
x6 = x(6);
x7 = x(7);

g1 = -(127-2*x1^2-3*x2^4-x3-4*x4^2-5*x5);
g2 = -(282-7*x1-3*x2-10*x3^2-x4+x5);
g3 = -(196-23*x1-x2^2-6*x6^2+8*x7);
g4 = -(-4*x1^2-x2^2+3*x1*x2-2*x3^2-5*x6+11*x7);

c = 0;

if (g1 > 0)
    c = c + g1;
end;

if (g2 > 0)
    c = c + g2;
end;

if (g3 > 0)
    c = c + g3;
end;

if (g4 > 0)
    c = c + g4;
end



ceq = [];


% pause(.1)