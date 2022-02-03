function [param] = build_param(X)
% Construct parameterized input for analysis using X vector

X(29:36) = round(X(29:36));


%% INPUTS (53)
% Internal inflation pressure (psi)
param.p_i = [X(1)
    X(2)
    X(3)
    X(4)
    X(5)
    X(6)
    X(7)];

% Braid angle (deg)
param.beta_i = [X(8)
    X(9)
    X(10)
    X(11)
    X(12)
    X(13)
    X(14)];

% Location of cords on cross-section (deg)
param.alpha_i = 270 + [-X(15) X(15)
    -X(16) X(16)
    -X(17) X(17)
    -X(18) X(18)
    -X(19) X(19)
    -X(20) X(20)
    -X(21) X(21)];

% Cord stiffness factor
param.k_cord_fac_i = [X(22)
    X(23)
    X(24)
    X(25)
    X(26)
    X(27)
    X(28)];

% Number of loop straps (set 1)
param.n_loop1 = [X(29)
    X(30)
    X(31)
    X(32)];

% Number of loop straps (set 2)
param.n_loop2 = [X(33)
    X(34)
    X(35)];

% Number of radial strap sets
param.n_rad = X(36);

% Loop strap pretension (set 1)
param.PT_loop1 = [X(37)
    X(38)
    X(39)
    X(40)];

% Loop strap pretension (set 2)
param.PT_loop2 = [X(41)
    X(42)
    X(43)];

% Radial strap pretension
param.PT_rad = X(44);

% Strap stiffness factor (loop set 1)
param.k_loop1_fac = [X(45)
    X(46)
    X(47)
    X(48)];

% Strap stiffness factor (loop set 2)
param.k_loop2_fac = [X(49)
    X(50)
    X(51)];

% Strap stiffness factor (fore radials)
param.k_rad_fore_fac = X(52);

% Strap stiffness factor (aft radials)
param.k_rad_aft_fac = X(53);

param.label = {'p1'
    'p2'
    'p3'
    'p4'
    'p5'
    'p6'
    'p7'
    'beta1'
    'beta2'
    'beta3'
    'beta4'
    'beta5'
    'beta6'
    'beta7'
    'alpha1'
    'alpha2'
    'alpha3'
    'alpha4'
    'alpha5'
    'alpha6'
    'alpha7'
    'k_cord_fac1'
    'k_cord_fac2'
    'k_cord_fac3'
    'k_cord_fac4'
    'k_cord_fac5'
    'k_cord_fac6'
    'k_cord_fac7'
    'n_loop1_1'
    'n_loop1_2'
    'n_loop1_3'
    'n_loop1_4'
    'n_loop2_1'
    'n_loop2_2'
    'n_loop2_3'
    'n_rad'
    'PT_loop1_1'
    'PT_loop1_2'
    'PT_loop1_3'
    'PT_loop1_4'
    'PT_loop2_1'
    'PT_loop2_2'
    'PT_loop2_3'
    'PT_rad'
    'k_loop1_fac1'
    'k_loop1_fac2'
    'k_loop1_fac3'
    'k_loop1_fac4'
    'k_loop2_fac1'
    'k_loop2_fac2'
    'k_loop2_fac3'
    'k_rad_fore_fac'
    'k_rad_aft_fac'};

end