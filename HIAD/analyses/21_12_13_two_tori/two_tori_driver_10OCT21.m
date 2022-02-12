clear
close all

%% USER INPUT
% Define inboard torus major radius to estimate bench node spacing
r_major = 30;

% Minor radius of tori
r_minor = [10
          10]/2;

% Minimum number of torus nodes
min_nodes = 10;

% number of loop straps in strap sets
num_straps = 6;

% number of test benches located radially around the tori
num_bench = 2;

% Half of size of bench (half of bench length, offset on either side of center)
bench_length = 2;

% Location of first bench
b_theta0 = 0*pi/180;

% number of test straps located radially around the tori
num_teststraps = 4;

% Location of first strap
ts_theta0 = 15*pi/180;

% load to be applied to testing straps
load = 10;

% Location of testing strap end in Radius-Z space
test_rad = 20;
test_z = 5;

% END USER INPUT

%% Define Model Inputs
% Torus centers

% User defined torus properties
tor = define_tor(r_minor);

% User defined strap properties and configuration
straps = define_straps(r_minor,num_straps);

%% BUILD MODEL
% Assemble torus elements
[FEM, theta, th_bench, th_tst, C] = DIC_build_tori(tor,straps,min_nodes,num_bench,num_teststraps,b_theta0,ts_theta0,r_major,bench_length);

% Assemble interaction elements
pre_str = zeros(size(tor,1),1); % Interaction element prestrain
[FEM, K_shear] = build_int(FEM,theta,C,tor,pre_str);

% Assemble link and strap elements
[FEM,strap_type,strap_EL_1] = build_links_straps(FEM,theta,tor,straps);

% Assemble testing bench elements
[FEM] = build_bench(FEM,tor,theta,th_bench, K_shear);

% Assemble testing link and strap elements
[FEM, rebound, test_theta] = build_testing_links_straps(FEM,tor,straps,load,theta,th_tst,test_rad,test_z);

%Plot initial FEM
FEM.PLOT = plot_controls;
FEM_plot(FEM)

% Initialize cord force arrays
FEM.OUT.cord_f = zeros(50,7);
th = size(FEM.MODEL.theta,1);
for i = 1:2
    FEM.OUT.cord_f(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(1);
end

FEM.OUT.cord_f2 = zeros(50,7);
th = size(FEM.MODEL.theta,1);
for i = 1:3
    FEM.OUT.cord_f2(1,i) = FEM.EL((i - 1)*th + 1).el_in0.f(2);
end

% END BUILD MODEL

%% RUN ANALYSIS
tic
t = cputime;

% Force based analysis
FEM.ANALYSIS = FE_controls1;
[FEM_out] = increment_FE(FEM);

[FEM_out] = bound_displace_strap(FEM_out, rebound, test_theta, C, tor);

% Displacement based analysis
FEM_out.ANALYSIS = FE_controls2;
[FEM_out2] = increment_FE(FEM_out);

cpu_run_time = cputime - t;
toc

%% POST PROCESS RESULTS
% % To be added
% FE_plot(FEM_out2)
% 
% save('FEM_out')
% % END POST PROCESS RESULTS



