% Compare components of work
% December 4, 2015

% Load beam analysis
% load('C:\Users\andrew.young\Desktop\FE_code\flex_06NOV15\analysis\15_08_31_beams\plotting\work_04DEC15.mat')

u_mid = [0 -FEM_out.OUT.Uinc(20,:)]'; % Midpan deflection
u_end = [0 FEM_out.OUT.Uinc(7,:)]'; % End deflection
u_load = [0 -FEM_out.OUT.Uinc(14,:)]'; % Load point deflection
f = [0 -FEM_out.OUT.Finc(14,:)]'; % Load

% Interpolate to end displacement
u_load = interp1(u_mid,u_load,(0:.1:5)');
u_end = interp1(u_mid,u_end,(0:.1:5)');
f = interp1(u_mid,f,(0:.1:5)');

% Work done by external loads
w1 = sum((f(1:end - 1) + f(2:end))/2.*(u_load(2:end) - u_load(1:end - 1)));

% Work done by end pressure resultant
w2 = p*pi*r^2*u_end(end);

% Total work
W_beam = (w1 - w2)*2;



figure(100)
clf
box on
hold on
plot(u_load,f)



