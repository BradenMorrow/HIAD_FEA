function [tor] = define_tor(C,r)
% Tori input deck
% User must create a torus structure for each torus.  Includes information
% used to define the properties of the tori.


%% Preallocate - analysis requires the following fields
N = 2;
tor(N,1).r = []; % Torus minor radius (in)
tor(N,1).C = []; % Location of torus in x, z space
tor(N,1).C_tie = [];
tor(N,1).p = []; % Internal inflation pressure (psi)
tor(N,1).alpha = []; % Location of cords (deg, CW, from top of torus, +z)
tor(N,1).beta = []; % Braid angle (deg)
tor(N,1).ELong = []; % Gross axial stiffness (lb/in)
tor(N,1).GLH = []; % Shell shear stiffness (lbf/in)
tor(N,1).Nint = []; % Number of integration points
tor(N,1).d = []; % Cord response [load strain] [lbf in/in]
tor(N,1).Fc = []; % Force in one cord after inflation (lb)
tor(N,1).eps0 = []; % Initial cord strain
tor(N,1).K_ax = []; % Axial stiffness of interaction elements
tor(N,1).K_shear = []; % Shear stiffness of interaction elements
tor(N,1).load = []; % Line load applied to torus
tor(N,1).state_it = []; % Iterative or non-iterative state determination procedure


%% T1
T = 1; % Torus number
tor(T).r = r(T); % Torus minor radius (in)
tor(T).C = C(1,:); % Location of torus in x, z space
% tor(T).C_tie = C(1,:);
tor(T).p = 12; % Internal inflation pressure (psi)
tor(T).alpha = [210 330]'; % Location of cords (deg, CW, from top of torus, +z)
tor(T).beta = 71; % 69; % Braid angle (deg)
ELong = 90; % 0; % Shell longitudinal stiffness (lbf/in)
tor(T).ELong = get_beam_EL(tor(T).beta,tor(T).p,tor(T).r,ELong); % Gross axial stiffness (lb/in)
tor(T).GLH = 4000; % Shell shear stiffness (lbf/in)
tor(T).Nint = 3; % Number of integration points
d = load('zylon_axial_table_update_06OCT16'); % Cord response [load strain] [lbf in/in]
% % % d = load('zylon_axial_table_update_06OCT16'); % Cord response [load strain] [lbf in/in]
tor(T).d = d;
tor(T).Fc = tor(T).p*pi*tor(T).r^2/length(tor(T).alpha)*(1 - 2*cotd(tor(T).beta)^2); % Force in one cord after inflation (lb)
tor(T).eps0 = interp1(d(:,1),d(:,2),tor(T).Fc); % Initial cord strain
tor(T).load = false; % Line load applied to torus
tor(T).state_it = false; % Iterative or non-iterative state determination procedure
tor(T).K_ax = .35*pi*tor(T).p*1; % lb/in/in
tor(T).K_shear = .72*pi*tor(T).p*1; % lb/in/in


%% T2
T = T + 1; % Torus number
tor(T).r = r(T); % Torus minor radius (in)
tor(T).C = C(2,:); % Location of torus in x, z space
tor(T).p = 12; % Internal inflation pressure (psi)
tor(T).alpha = [210 330]'; % Location of cords (deg, CW, from top of torus, +z)
tor(T).beta = 71; % 69; % Braid angle (deg)
ELong = 90; % Shell longitudinal stiffness (lbf/in)
tor(T).ELong = get_beam_EL(tor(T).beta,tor(T).p,tor(T).r,ELong); % Gross axial stiffness (lb/in)
tor(T).GLH = 4000; % Shell shear stiffness (lbf/in)
tor(T).Nint = 3; % Number of integration points
d = load('zylon_axial_table_update_06OCT16'); % Cord response [load strain] [lbf in/in]
% % % d = load('zylon_axial_table_update_06OCT16'); % Cord response [load strain] [lbf in/in]
tor(T).d = d;
tor(T).Fc = tor(T).p*pi*tor(T).r^2/length(tor(T).alpha)*(1 - 2*cotd(tor(T).beta)^2); % Force in one cord after inflation (lb)
tor(T).eps0 = interp1(d(:,1),d(:,2),tor(T).Fc); % Initial cord strain
tor(T).load = false; % Line load applied to torus
tor(T).state_it = false; % Iterative or non-iterative state determination procedure
tor(T).K_ax = .35*pi*tor(T).p*1; % lb/in/in
tor(T).K_shear = .72*pi*tor(T).p*1; % lb/in/in


end