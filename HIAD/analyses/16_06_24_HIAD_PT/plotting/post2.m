function post2(FEM,L)
% Plot analysis
FEM_out = FEM;
theta = FEM_out.MODEL.theta_ind(1).ind;
% Post processing
% March 01, 2016

%%
% Get Z direction reactio force
RZ_ind = (3:6:size(FEM_out.OUT.Fext_inc,1))';
Ry = sum(FEM_out.OUT.Fext_inc(RZ_ind - 1,:))';
Rz = sum(FEM_out.OUT.Fext_inc(RZ_ind,:))';
Ryz = (Ry.^2 + Rz.^2).^.5;
Rd = Ryz*cosd(20.739); % Rz; %

% Calculate total drag load
r1 = 657.5/2; % Outside radius (in)
r0 = 340/2; % Centerbody radius (in)

Atot = pi*r1^2; % Total area
Acb = pi*r0^2; % Centerbody area
Ainf = Atot - Acb; % Inflatable area
Finf = Rd/.8*Atot/Ainf; % Vertical force on inflatable

% Z direction displacement
indU0 = size(theta,1)*6*4 + 3;
indU90 = size(theta,1)*6*4 + 3 + size(theta,1)/4*6;
indU270 = size(theta,1)*6*4 + 3 + size(theta,1)*3/4*6;
Ui0 = FEM_out.OUT.Uinc(indU0,:)';
Ui90 = FEM_out.OUT.Uinc(indU90,:)';
Ui270 = FEM_out.OUT.Uinc(indU270,:)';

U0 = [0; Ui0 - Ui0(1)*0];
U90 = [0; Ui90 - Ui90(1)*0];
U270 = [0; Ui270 - Ui270(1)*0];
F = [0; Finf];
F2 = [0; Rz];

U0(1:2) = [];
U90(1:2) = [];
U270(1:2) = [];
F(1:2) = [];
F2(1:2) = [];

% Plot load vertical displacement
figure(12)
% clf
box on
hold on

U1 = (U90 - U90(1))*25.4;
U = linspace(U1(1),U1(end),50)';
F3 = F2*4.448222/1000;
F3 = interp1(U1,F3,U);

if size(U,1) == size(F3,1)
    plot(U,F3,L)
end

xlim([0 500])
ylim([0 1400])

xlabel('Z disp (mm)')
ylabel('Vertical reaction (kN)')

% disp(F3(end))
drawnow

end
