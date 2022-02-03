r = 6.6725;
p = 0;
beta = 71;
alpha = [60 180 300]'; % [45 225]'; % [90 270]'; % [90 270 0]'; % [0 180 270]'; % [30 150 270]'; % 

% axial = load('axial_table_test');
% Fc = p*pi*r^2/length(alpha)*(1 - 2*cot(beta*pi/180)^2);
axial_table = 'bilinear'; % 'ax_test'; % 'axial_table_11'; % 

Fc = p*pi*r^2/length(alpha)*(1 - 2*cot(beta*pi/180)^2); % Force in cord after inflation (lb)
axial = load(axial_table); % Cord force - strain lookup table
axial1 = [(interp1(axial(:,2),axial(:,1),axial(:,2) + 1e-6) - axial(:,1))/1e-6 axial(:,2)];
axial1(end,:) = [];

% axial = [-10 -10;
%     0 0
%     10 10];
eps0 = interp1(axial(:,1),axial(:,2),Fc); %interp1(axial(:,1),axial(:,2),Fc);
% % % axial = [axial(:,1) - Fc axial(:,2) - eps0];
% % % Fc = 0;
% % % eps0 = 0;


axial_0 = pchip(axial(:,2),axial(:,1));
axial_1 = fnder(axial_0);



propsLH = [0
    0
    1.1154e+07
    0.3
    0.033333];

EI0 = [3.458e+06    3.458e+06];
EA0 = 1.4957e+05;

D = [.001
    -.0001
    .0001
    0
    0
    0];

L = 1;
L0 = 1;
y_bar0 = [0 0]';



element_in.r = r;
element_in.alpha = alpha;
element_in.axial = axial;
element_in.axial1 = axial1;
element_in.axial_0 = axial_0;
element_in.axial_1 = axial_1;
element_in.eps0 = eps0;
element_in.Fc = Fc;
element_in.propsLH = propsLH;
element_in.EI0 = EI0;
element_in.EA0 = EA0;
element_in.coro.D = D;
element_in.coro.L = L;
element_in.coro.L0 = L0;
element_in.y_bar0 = y_bar0;
element_in.i = 1;
element_in.connect = [1     2     5     1];



[KL,P,y_bar,EI,DEBUG] = get_KL_P(element_in);


P
y_bar





