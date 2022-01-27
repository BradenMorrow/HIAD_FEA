% Driver function for prestrain analysis
% May 11, 2016

% Strap prestrain
eps_in = [.0004386 % Loop1, aft1
    .0004386 % Loop1, aft2
    .0004386 % Loop1, aft3
    .0004386 % Loop1, fore1
    .0004386 % Loop1, fore2
    .0004386 % Loop1, fore3
    .0004386 % Loop2, aft1
    .0004386 % Loop2, aft2
    .0004386 % Loop2, aft3
    .0004386 % Loop2, fore1
    .0004386 % Loop2, fore2
    .0004386 % Loop2, fore3
    .0004386 % Radial, aft
    .0004386 % Chevron, aft
    .0004386 % Radial, fore
    .0004386]; % Chevron, fore


% eps_in = [ 0.03611    0.038577    0.016704    0.013883    0.023069    0.030793    0.033003    0.019863    0.011046    0.038513    0.014901    0.025887    0.011734   0.0076609    0.040694   0.0099546 ]';

% Analysis
[strap_F,Cout] = HIAD_PT(eps_in);

% Objectives
strap_obj = get_strap_obj(strap_F)
def_con = get_def_con(Cout)







