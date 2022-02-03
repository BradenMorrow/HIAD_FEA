function [straps] = define_straps_param(C,r,alpha_cone,param)
% Strap sets input deck
% User must create a strap set structure for each strap set.  Includes 
% information used to define the properties of the straps.

alpha = 90 - alpha_cone;

% n_straps = 32; % Number of radial straps per set, divisible by 4
num_strap_sets = 20; % Number of strap sets

%% Extract parameterized inputs and reorganize
p_tor = param.p_i;
n_loop1 = param.n_loop1;
n_loop2 = param.n_loop2;
n_rad = param.n_rad;
PT_loop1 = param.PT_loop1;
PT_loop2 = param.PT_loop2;
PT_rad = param.PT_rad;
k_loop1_fac = param.k_loop1_fac;
k_loop2_fac = param.k_loop2_fac;
k_rad_fore_fac = param.k_rad_fore_fac;
k_rad_aft_fac = param.k_rad_aft_fac;

n_straps = [n_loop1
    n_loop1
    n_loop2
    n_loop2
    n_rad
    n_rad
    n_rad
    n_rad
    n_rad
    n_rad];

PT = [PT_loop1
    PT_loop1
    PT_loop2
    PT_loop2
    PT_rad
    PT_rad/2
    PT_rad/2
    PT_rad
    PT_rad/2
    PT_rad/2];

k_fac = [k_loop1_fac
    k_loop1_fac
    k_loop2_fac
    k_loop2_fac
    k_rad_aft_fac
    1
    1
    k_rad_fore_fac
    1
    1];


%% Preallocate - analysis requires the following fields
straps(num_strap_sets,1).con = []; % Torus connectivities (0 for node)
straps(num_strap_sets,1).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(num_strap_sets,1).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(num_strap_sets,1).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(num_strap_sets,1).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(num_strap_sets,1).join = []; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(num_strap_sets,1).side = []; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(num_strap_sets,1).PT = []; % Level of strap pretension
straps(num_strap_sets,1).axial = []; % Strap response piecewise polynomial
straps(num_strap_sets,1).axial_k = []; % Strap stiffness piecewise polynomial
straps(num_strap_sets,1).mat = []; % Material properties [E nu]
straps(num_strap_sets,1).geom = []; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(num_strap_sets,1).eps0 = []; % Strap prestrain
straps(num_strap_sets,1).maxF = []; % Maximum allowable strap load

straps(num_strap_sets,1).theta0 = []; % Location of first strap
straps(num_strap_sets,1).num_straps = []; % Number of straps around HIAD
straps(num_strap_sets,1).theta_sweep = []; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(num_strap_sets,1).rho = []; % Unit mass of strap (mass/length)
straps(num_strap_sets,1).strap_ID = []; % Name of strap set


%% Strap set 1 - Loop set 1, aft 1
S = 1; % Strap number
straps(S).con = [0 1]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) C(1,1)*tand(alpha) + 2*r(1)/cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 1 - Loop set 1, aft 1'; % Name of strap set


%% Strap set 2 - Loop set 1, aft 2
S = S + 1; % Strap number
straps(S).con = [2 3]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 2 - Loop set 1, aft 2'; % Name of strap set


%% Strap set 3 - Loop set 1, aft 3
S = S + 1; % Strap number
straps(S).con = [4 5]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 3 - Loop set 1, aft 3'; % Name of strap set


%% Strap set 4 - Loop set 1, aft 4
S = S + 1; % Strap number
straps(S).con = [6 7]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 4 - Loop set 1, aft 4'; % Name of strap set


%% Strap set 5 - Loop set 1, fore 1
S = S + 1; % Strap number
straps(S).con = [0 1]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) C(1,1)*tand(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 5 - Loop set 1, fore 1'; % Name of strap set


%% Strap set 6 - Loop set 1, fore 2
S = S + 1; % Strap number
straps(S).con = [2 3]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 6 - Loop set 1, fore 2'; % Name of strap set


%% Strap set 7 - Loop set 1, fore 3
S = S + 1; % Strap number
straps(S).con = [4 5]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 7 - Loop set 1, fore 3'; % Name of strap set


%% Strap set 8 - Loop set 1, fore 4
S = S + 1; % Strap number
straps(S).con = [6 7]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 8 - Loop set 1, fore 4'; % Name of strap set


%% Strap set 9 - Loop set 2, aft 1
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 9 - Loop set 2, aft 1'; % Name of strap set


%% Strap set 10 - Loop set 2, aft 2
S = S + 1; % Strap number
straps(S).con = [3 4]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 10 - Loop set 2, aft 2'; % Name of strap set


%% Strap set 11 - Loop set 2, aft 3
S = S + 1; % Strap number
straps(S).con = [5 6]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 11 - Loop set 2, aft 3'; % Name of strap set


%% Strap set 12 - Loop set 2, fore 1
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 12 - Loop set 2, fore 1'; % Name of strap set


%% Strap set 13 - Loop set 2, fore 2
S = S + 1; % Strap number
straps(S).con = [3 4]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 13 - Loop set 2, fore 2'; % Name of strap set


%% Strap set 14 - Loop set 2, fore 3
S = S + 1; % Strap number
straps(S).con = [5 6]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 14 - Loop set 2, fore 3'; % Name of strap set


%% Strap set 15 - Radial, aft
S = S + 1; % Strap number
straps(S).con = [0 0]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) C(1,1)*tand(alpha) + 2*r(1)/cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 1 0]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 100; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 15 - Radial, aft'; % Name of strap set


%% Strap set 16 - Chevron CCW, aft
S = S + 1; % Strap number
straps(S).con = [0 5]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 15]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 0; % 50; % Level of strap pretension
% [straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = chev_config_21FEB17(straps(S).PT,k_fac(S));
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 2*pi/n_straps(S)/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 16 - Chevron CCW, aft'; % Name of strap set


%% Strap set 17 - Chevron CW, aft
S = S + 1; % Strap number
straps(S).con = [0 5]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 15]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 0; % 50; % Level of strap pretension
% [straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = chev_config_21FEB17(straps(S).PT,k_fac(S));
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = -2*pi/n_straps(S)/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 17 - Chevron CW, aft'; % Name of strap set


%% Strap set 18 - Radial, fore
S = S + 1; % Strap number
straps(S).con = [0 0]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) C(1,1)*tand(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 1 0]; %% Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 200; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 18 - Radial, fore'; % Name of strap set


%% Strap set 19 - Chevron CCW, fore
S = S + 1; % Strap number
straps(S).con = [0 5]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 18]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 0; % 50; % Level of strap pretension
% [straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = chev_config_21FEB17(straps(S).PT,k_fac(S));
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = 2*pi/n_straps(S)/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 19 - Chevron CCW, fore'; % Name of strap set


%% Strap set 20 - Chevron CW, fore
S = S + 1; % Strap number
straps(S).con = [0 5]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 18]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = PT(S); % 0; % 50; % Level of strap pretension
% [straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = chev_config_21FEB17(straps(S).PT,k_fac(S));
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = loop_config_21FEB17(straps(S).PT,k_fac(S));
straps(S).maxF = 2*k_fac(S)*70/2*max(p_tor(straps(S).con(straps(S).con > 0))) + 450; % Maximum allowable strap load 

straps(S).theta0 = 2*pi/n_straps(S)/2; % Location of first strap
straps(S).num_straps = n_straps(S); % Number of straps around HIAD
straps(S).theta_sweep = -2*pi/n_straps(S)/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).rho = .0014822*k_fac(S); % Unit mass of strap (mass/length)
straps(S).strap_ID = 'Strap set 20 - Chevron CW, fore'; % Name of strap set




end

