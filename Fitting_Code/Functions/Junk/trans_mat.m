function A = trans_mat(a1,a2)
A = [cos(a2),0,sin(a2);
    sin(a1)*sin(a2),cos(a1),-cos(a2)*sin(a1);
    -cos(a1)*sin(a2) sin(a1) cos(a1)*cos(a2)];
end