


nodes = [0     0     0
    1     0     0];

orient = [0     1     0
    1     1     0];

U_eb = [0            0            0            0            0            0
    0   -0.0002927            0            0            0  -0.00043905];

U = [0	0	0	0	0	0
    0	-5.736895419956186e-02	0	0	0	-4.390481188741942e-04];

D = [1.644246679404483e-03
    5.730614068378738e-02
    5.686709256491319e-02
    0
    0
    0];

scale = 1;
nodes2 = nodes + U(:,1:3)*scale;

r = 5;

alpha = [60 180 300]';

axial = [0.0001         -100
    0.0001          100];

eps0 = 0;

propsLH = [2.9e+07
    2.9e+07
    1.1154e+07
    0.3
    0.033333];

y_bar0 = [0 0]';

EI0 = [1.138827336926300e+09 1.138827336926300e+09 1.138827336926300e+09 1.138827336926300e+09];

L = 1;
EI = EI0(1);
G = propsLH(3);
t = propsLH(5)*3;
A = 2*pi*r*t;
k = 2.0;

phi = (12*EI*k)/(G*A*L^2);
u = [U(1,2) U(1,6) U(2,2) U(2,6)]';
u_cr = [0 D(2) 0 D(3)]';
u_eb = [U_eb(1,2) U_eb(1,6) U_eb(2,2) U_eb(2,6)]';

x = (0:.1:L)';
V_eb = zeros(size(x));
Vp_eb = zeros(size(x));
Vpp_eb = zeros(size(x));

V_eb1 = zeros(size(x));
Vp_eb1 = zeros(size(x));
Vpp_eb1 = zeros(size(x));

V = zeros(size(x));
Vp = zeros(size(x));
Vpp = zeros(size(x));

V_cr = zeros(size(x));
Vp_cr = zeros(size(x));
Vpp_cr = zeros(size(x));

gamma = zeros(size(x));

for i = 1:length(x)
    [V_eb1(i),Vp_eb1(i),Vpp_eb1(i)] = shape2(x(i),L,u_eb);
    [V_eb(i),Vp_eb(i),Vpp_eb(i)] = shape2(x(i),L,u);
    [V(i),Vp(i),Vpp(i)] = shape3(x(i),L,u,phi);
    [V_cr(i),Vp_cr(i),Vpp_cr(i)] = shape3(x(i),L,u_cr,phi);
    
    
    [gamma(i)] = shape4(x(i),L,u,phi);

end

figure(1)
clf
subplot(2,1,1)
box on
hold on
% axis equal
plot(nodes(:,1),nodes(:,2),'kx-')
plot(nodes2(:,1),nodes2(:,2),'bo-')
plot(x,V_eb,'r--')
plot(x,V_eb1,'m--')
plot(x,V,'g--')


xlim([-.1 1.1])
ylim([-.07 .01])


subplot(2,1,2)
box on
hold on
plot(x,Vpp_eb1,'mx-')
% plot(x,Vpp_eb,'r--')
plot(x,Vpp,'gs--')
plot(x,Vpp_cr,'co:')
plot([-1 2],[0 0],'k')

xlim([-.1 1.1])



[Kel,Fint_i,fint_i,y_bar,EI,DEBUG] = element_5(nodes,orient,U,r,alpha,axial,eps0,propsLH,y_bar0,EI0);




Vpp_eb1([1 end])
Vpp_cr([1 end])



gamma_i = shape4(0,L,u,phi)
gamma_j = shape4(L,L,u,phi)

gamma_i_cr = shape4(0,L,u_cr,phi)

