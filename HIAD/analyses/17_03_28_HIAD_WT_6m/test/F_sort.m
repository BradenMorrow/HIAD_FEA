function [f] = F_sort(I0,TH0,F0,R0,X0,Y0,Z0,ux0,uy0,uz0,theta)


% Sort forces
[TH1,I1] = sort(TH0(I0));
F1 = F0(I0);
F1 = F1(I1);
R1 = R0(I0);
R1 = R1(I1);
X1 = X0(I0);
X1 = X1(I1);
Y1 = Y0(I0);
Y1 = Y1(I1);
Z1 = Z0(I0);
Z1 = Z1(I1);
ux1 = ux0(I0);
ux1 = ux1(I1);
uy1 = uy0(I0);
uy1 = uy1(I1);
uz1 = uz0(I0);
uz1 = uz1(I1);


% Theta tributary width
th1 = [theta(end) - 2*pi; theta];
th2 = [theta; theta(1) + 2*pi];
trib_theta = (th1 + th2)/2;


% Collect loads
f = zeros(size(theta,1),3);
for i = 1:size(theta,1)
    I_temp = (TH1 >= trib_theta(i) | TH1 < trib_theta(i + 1) - 2*pi) & (TH1 < trib_theta(i + 1) | TH1 >= trib_theta(i) + 2*pi);
    ux_temp = ux1(I_temp);
    uy_temp = uy1(I_temp);
    uz_temp = uz1(I_temp);
    F_temp = F1(I_temp);
    
    f(i,:) = sum([F_temp.*ux_temp F_temp.*uy_temp F_temp.*uz_temp]);
end



f(:,1) = f(:,1)*1.2305;


end

