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
    .0004386*2 % Loop2, aft2
    .0004386 % Loop2, aft3
    .0004386*2 % Loop2, fore1
    .0004386 % Loop2, fore2
    .0004386 % Loop2, fore3
    .0004386 % Radial, aft
    .0004386 % Chevron, aft
    .0004386*2 % Radial, fore
    .0004386*2]; % Chevron, fore

eps_in = [0.027077
    0.0090446
    0.09684
    0.060973
    0.030915
    0.025162
    0.073444
    0.0052832
    0.068687
    0.0031439
    0.087102
    0.077783
    0.023465
    -0.0078866
    0.06965
    -0.0035315];

eps_in = [-0.000951 % GA
    0.0018878
     0.019478
     0.027945
    0.0079268
     0.004279
    0.0025387
     0.020998
     0.030854
     0.018836
     0.041048
     0.027682
   -0.0078438
     0.034198
    0.0022528
     0.050442];

% Analysis
[strap_obj] = HIAD_PT0(eps_in)

% Objectives
def_con = get_def_con(eps_in)







