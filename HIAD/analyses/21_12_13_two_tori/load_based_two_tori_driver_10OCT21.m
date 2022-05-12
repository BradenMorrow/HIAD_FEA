clear
clc
close all

%% USER INPUT
% Define file paths to tori4 and tori5
files = ["T4.mat", "T5.mat"];

% Define inboard torus major radius to estimate bench node spacing
r_major = 79;

% Minor radius of tori
r_minor = [6.7
    6.7];

% Minimum number of torus nodes
min_nodes = 300;

% number of loop straps in strap sets
num_straps = 16;

% number of test benches located radially around the tori
num_bench = 4;

% Half of size of bench (half of bench length, offset on either side of center)
bench_length = 12;

% Location of first bench
b_theta0 = 0*pi/180;

% number of test straps located radially around the tori
num_teststraps = 16;

% Location of first strap
ts_theta0 = 0*pi/180;

% load to be applied to testing straps
total_load = 200; %lbf

%Location of cable end in Radius-Z space
cable_rad = 30;

%% Defined Model Inputs

% User defined torus properties
tor = define_tor(r_minor);

% User defined strap properties and configuration
straps = define_straps(r_minor,num_straps);

% END USER INPUT

%% BUILD MODEL
% Assemble torus elements
[FEM, theta, th_bench, th_tst, C, offset] = DIC_build_tori(tor,straps,min_nodes,num_bench,num_teststraps,b_theta0,ts_theta0,r_major,bench_length,files);

% Assemble interaction elements
pre_str = zeros(size(tor,1),1); % Interaction element prestrain
[FEM, K_shear] = build_int(FEM,theta,C,tor,pre_str);

% Assemble link and strap elements
[FEM,strap_type,strap_EL_1] = build_links_straps(FEM,theta,tor,straps, offset);

% Assemble testing bench elements
[FEM] = build_bench(FEM,tor,theta,th_bench);
 
% Assemble testing link and strap elements
[FEM, rebound, test_theta, cable_post,strap_post,new_F] = build_testing_links_straps_new(FEM,tor,straps,total_load,theta,th_tst,cable_rad,C);

% Initialize cord force arrays
FEM.OUT.cord_f = zeros(50,2);
th = size(FEM.MODEL.theta,1);
for i = 1:2
    FEM.OUT.cord_f(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(1);
end

FEM.OUT.cord_f2 = zeros(50,2);
th = size(FEM.MODEL.theta,1);
for i = 1:2
    FEM.OUT.cord_f2(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(2);
end

% END BUILD MODEL

%% RUN ANALYSIS
tic
t = cputime;

FEM.PLOT = plot_controls;

% Force based analysis

FEM.ANALYSIS = FE_controls1;
[FEM_out] = increment_FE(FEM);

FEM_out.MODEL.F_pre = FEM_out.OUT.Fext_inc(:,end);
FEM_out.MODEL.U0 = FEM_out.OUT.U;
FEM_out.MODEL.F = new_F;

FEM_out.ANALYSIS = FE_controls3;
[FEM_out2] = increment_FE(FEM_out);

disp('Loading Analysis Finished.')

cpu_run_time = cputime - t;
toc

% save("./results/Old Model/FEM.mat", "FEM");
% save("./results/Old Model/FEM_out.mat", "FEM_out");

% END ANALYSIS

%% POST PROCESS RESULTS
post_processing_loading(FEM,FEM_out2,cable_post,theta,rebound,strap_post);

% % END POST PROCESS RESULTS