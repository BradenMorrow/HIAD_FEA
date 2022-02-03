% Driver for parameterized HIAD analyses
% August 9, 2016
clear

%% USER INPUT
% Define centerbody tieback location and torus centers
% [X Z] locations
C = [170.22695601602 78.8978503484703 % Location of tieback to centerbody
    185.185453 84.342298 % T1 center
	213.724769 94.729760 % T2 center
	242.558759 105.224474 % T3 center
	271.650278 115.812921 % T4 center
	300.963157 126.481936 % T5 center
	322.382105 124.113612]; % T6 center

r = [31.837/2 % Minor radii of tori, T1
    31.837/2 % T2
    31.837/2 % T3
    31.837/2 % T4
    31.837/2 % T5
    12.735/2]; % T6

alpha_cone = 70; % HIAD angle with vertical

% Define torus connectivities
Ccon = [1 2 % Centerbody to T1
    2 3 % T1 to T2
    3 4 % T2 to T3
    4 5 % T3 to T4
    5 6 % T4 to T5
    6 7]; % T5 to T6

% Define torus properties
tor = define_tor(C,r);

% Define strap sets
straps = define_straps(C,r,alpha_cone);
% straps = define_straps_alt1_16SEP16(C,r,alpha_cone);
% straps = define_straps_alt2_16SEP16(C,r,alpha_cone);

% Define HIAD loading
% Total Z direction reaction
Rz = 375000; % lbf % 375; % 

load = define_press(C,r,alpha_cone,Rz);

% END USER INPUT


%% BUILD MODEL
% Assemble torus elements
[FEM, theta] = build_tor(C,tor,straps,load);

% Assemble interaction elements
pre_str = [0 0 0 0 0 0]'; % Interaction element prestrain
[FEM] = build_int(FEM,theta,C,tor,pre_str);

% Assemble link and strap elements
[FEM] = build_links_straps(FEM,theta,C,tor,straps);

% Modeling controlls
FEM.ANALYSIS = FE_controls0;
FEM.PLOT = plot_controls0;

% % % FE_plot(FEM)
% % % post_proc_driver1

% END BUILD MODEL


%% RUN ANALYSIS
[FEM_out] = increment_FE(FEM);

% END RUN ANALYSIS


%% POST PROCESS RESULTS
[k] = plot_inc(FEM_out)

% END POST PROCESS RESULTS














