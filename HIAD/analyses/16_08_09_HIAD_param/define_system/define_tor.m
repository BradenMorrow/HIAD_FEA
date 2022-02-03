function [tor] = define_tor(r)
% Tori input deck
% User must create a torus structure for each torus.  Includes information
% used to define the properties of the tori.

run_get_stiffness = false; % Switch to run torus cross section stiffness model

%% Preallocate - analysis requires the following fields
tor(6,1).r = []; % Torus minor radius (in)
tor(6,1).p = []; % Internal inflation pressure (psi)
tor(6,1).alpha = []; % Location of cords (deg, CW, from top of torus, +z)
tor(6,1).beta = []; % Braid angle (deg)
tor(6,1).ELong = []; % Gross axial stiffness (lb/in)
tor(6,1).GLH = []; % Shell shear stiffness (lbf/in)
tor(6,1).Nint = []; % Number of integration points
tor(6,1).d = []; % Cord response [load strain] [lbf in/in]
tor(6,1).Fc = []; % Force in one cord after inflation (lb)
tor(6,1).eps0 = []; % Initial cord strain
tor(6,1).K_ax = []; % Axial stiffness of interaction elements
tor(6,1).K_shear = []; % Shear stiffness of interaction elements


%% T1
T = 1; % Torus number
tor(T).r = r(1); % Torus minor radius (in)
tor(T).p = 20; % Internal inflation pressure (psi)
tor(T).alpha = [210 330]'; % Location of cords (deg, CW, from top of torus, +z)
tor(T).beta = 71; % Braid angle (deg)
ELong = 90; % Shell longitudinal stiffness (lbf/in)
tor(T).ELong = get_beam_EL(tor(T).beta,tor(T).p,tor(T).r,ELong); % Gross axial stiffness (lb/in)
tor(T).GLH = 4000; % Shell shear stiffness (lbf/in)
tor(T).Nint = 3; % Number of integration points
d = load('zylon_axial_table'); % Cord response [load strain] [lbf in/in]
d(:,1) = d(:,1)*2;
tor(T).d = d;
tor(T).Fc = tor(T).p*pi*tor(T).r^2/length(tor(T).alpha)*(1 - 2*cotd(tor(T).beta)^2); % Force in one cord after inflation (lb)
tor(T).eps0 = interp1(d(:,1),d(:,2),tor(T).Fc); % Initial cord strain

if run_get_stiffness == true;
    [tor(T).K_ax,tor(T).K_shear] = get_Stiffness(tor(T).r,tor(T).p); % Axial and shear stiffness of interaction elements
else
    tor(T).K_ax = 31.91;
    tor(T).K_shear = 42.918;
end


%% T2
T = 2; % Torus number
tor(T).r = r(2); % Torus minor radius (in)
tor(T).p = 20; % Internal inflation pressure (psi)
tor(T).alpha = [210 330]'; % Location of cords (deg, CW, from top of torus, +z)
tor(T).beta = 71; % Braid angle (deg)
ELong = 90; % Shell longitudinal stiffness (lbf/in)
tor(T).ELong = get_beam_EL(tor(T).beta,tor(T).p,tor(T).r,ELong); % Gross axial stiffness (lb/in)
tor(T).GLH = 4000; % Shell shear stiffness (lbf/in)
tor(T).Nint = 3; % Number of integration points
d = load('zylon_axial_table'); % Cord response [load strain] [lbf in/in]
d(:,2) = d(:,2)*2;
tor(T).d = d;
tor(T).Fc = tor(T).p*pi*tor(T).r^2/length(tor(T).alpha)*(1 - 2*cotd(tor(T).beta)^2); % Force in one cord after inflation (lb)
tor(T).eps0 = interp1(d(:,1),d(:,2),tor(T).Fc); % Initial cord strain

if run_get_stiffness == true;
    [tor(T).K_ax,tor(T).K_shear] = get_Stiffness(tor(T).r,tor(T).p); % Axial and shear stiffness of interaction elements
else
    tor(T).K_ax = 31.91;
    tor(T).K_shear = 42.918;
end


%% T3
T = 3; % Torus number
tor(T).r = r(3); % Torus minor radius (in)
tor(T).p = 20; % Internal inflation pressure (psi)
tor(T).alpha = [210 330]'; % Location of cords (deg, CW, from top of torus, +z)
tor(T).beta = 71; % Braid angle (deg)
ELong = 90; % Shell longitudinal stiffness (lbf/in)
tor(T).ELong = get_beam_EL(tor(T).beta,tor(T).p,tor(T).r,ELong); % Gross axial stiffness (lb/in)
tor(T).GLH = 4000; % Shell shear stiffness (lbf/in)
tor(T).Nint = 3; % Number of integration points
d = load('zylon_axial_table'); % Cord response [load strain] [lbf in/in]
d(:,1) = d(:,1)*2;
tor(T).d = d;
tor(T).Fc = tor(T).p*pi*tor(T).r^2/length(tor(T).alpha)*(1 - 2*cotd(tor(T).beta)^2); % Force in one cord after inflation (lb)
tor(T).eps0 = interp1(d(:,1),d(:,2),tor(T).Fc); % Initial cord strain

if run_get_stiffness == true;
    [tor(T).K_ax,tor(T).K_shear] = get_Stiffness(tor(T).r,tor(T).p); % Axial and shear stiffness of interaction elements
else
    tor(T).K_ax = 31.91;
    tor(T).K_shear = 42.918;
end


%% T4
T = 4; % Torus number
tor(T).r = r(4); % Torus minor radius (in)
tor(T).p = 20; % Internal inflation pressure (psi)
tor(T).alpha = [210 330]'; % Location of cords (deg, CW, from top of torus, +z)
tor(T).beta = 71; % Braid angle (deg)
ELong = 90; % Shell longitudinal stiffness (lbf/in)
tor(T).ELong = get_beam_EL(tor(T).beta,tor(T).p,tor(T).r,ELong); % Gross axial stiffness (lb/in)
tor(T).GLH = 4000; % Shell shear stiffness (lbf/in)
tor(T).Nint = 3; % Number of integration points
d = load('zylon_axial_table'); % Cord response [load strain] [lbf in/in]
d(:,1) = d(:,1)*2;
tor(T).d = d;
tor(T).Fc = tor(T).p*pi*tor(T).r^2/length(tor(T).alpha)*(1 - 2*cotd(tor(T).beta)^2); % Force in one cord after inflation (lb)
tor(T).eps0 = interp1(d(:,1),d(:,2),tor(T).Fc); % Initial cord strain

if run_get_stiffness == true;
    [tor(T).K_ax,tor(T).K_shear] = get_Stiffness(tor(T).r,tor(T).p); % Axial and shear stiffness of interaction elements
else
    tor(T).K_ax = 31.91;
    tor(T).K_shear = 42.918;
end


%% T5
T = 5; % Torus number
tor(T).r = r(5); % Torus minor radius (in)
tor(T).p = 20; % Internal inflation pressure (psi)
tor(T).alpha = [210 330]'; % Location of cords (deg, CW, from top of torus, +z)
tor(T).beta = 71; % Braid angle (deg)
ELong = 90; % Shell longitudinal stiffness (lbf/in)
tor(T).ELong = get_beam_EL(tor(T).beta,tor(T).p,tor(T).r,ELong); % Gross axial stiffness (lb/in)
tor(T).GLH = 4000; % Shell shear stiffness (lbf/in)
tor(T).Nint = 3; % Number of integration points
d = load('zylon_axial_table'); % Cord response [load strain] [lbf in/in]
d(:,1) = d(:,1)*2;
tor(T).d = d;
tor(T).Fc = tor(T).p*pi*tor(T).r^2/length(tor(T).alpha)*(1 - 2*cotd(tor(T).beta)^2); % Force in one cord after inflation (lb)
tor(T).eps0 = interp1(d(:,1),d(:,2),tor(T).Fc); % Initial cord strain

if run_get_stiffness == true;
    [tor(T).K_ax,tor(T).K_shear] = get_Stiffness(tor(T).r,tor(T).p); % Axial and shear stiffness of interaction elements
else
    tor(T).K_ax = 31.91;
    tor(T).K_shear = 42.918;
end


%% T6
T = 6; % Torus number
tor(T).r = r(6); % Torus minor radius (in)
tor(T).p = 20; % Internal inflation pressure (psi)
tor(T).alpha = [210 330]'; % Location of cords (deg, CW, from top of torus, +z)
tor(T).beta = 71; % Braid angle (deg)
ELong = 90; % Shell longitudinal stiffness (lbf/in)
tor(T).ELong = get_beam_EL(tor(T).beta,tor(T).p,tor(T).r,ELong); % Gross axial stiffness (lb/in)
tor(T).GLH = 4000; % Shell shear stiffness (lbf/in)
tor(T).Nint = 3; % Number of integration points
d = load('zylon_axial_table'); % Cord response [load strain] [lbf in/in]
tor(T).d = d;
tor(T).Fc = tor(T).p*pi*tor(T).r^2/length(tor(T).alpha)*(1 - 2*cotd(tor(T).beta)^2); % Force in one cord after inflation (lb)
tor(T).eps0 = interp1(d(:,1),d(:,2),tor(T).Fc); % Initial cord strain

if run_get_stiffness == true;
    [tor(T).K_ax,tor(T).K_shear] = get_Stiffness(tor(T).r,tor(T).p); % Axial and shear stiffness of interaction elements
else
    tor(T).K_ax = 53.286;
    tor(T).K_shear = 43.782;
end


end








