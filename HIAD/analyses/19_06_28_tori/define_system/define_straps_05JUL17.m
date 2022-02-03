function [straps] = define_straps_05JUL17(C,r,alpha_cone,eps0)
% Strap sets input deck
% User must create a strap set structure for each strap set.  Includes 
% information used to define the properties of the straps.


%%
alpha = 90 - alpha_cone;
num_straps = 12; % Divisible by 4

num_strap_sets = 2;

load('strap_2in_loop.mat')
load('strap_2in_chev.mat')
load('strap_1p75in.mat')
[axial_2in_loop,axial_k_2in_loop] = strap_PT(cord_response_2in_loop,0);
[axial_2in_chev,axial_k_2in_chev] = strap_PT(cord_response_2in_chev,0);
[axial_1p75in,axial_k_1p75in] = strap_PT(cord_response_1p75in,0);


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

straps(num_strap_sets,1).theta0 = []; % Location of first strap
straps(num_strap_sets,1).num_straps = []; % Number of straps around HIAD
straps(num_strap_sets,1).theta_sweep = []; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(num_strap_sets,1).strap_ID = []; % Name of strap set


% % % %% Strap set 1 - Loop set 1, aft 1
% % % S = 1; % Strap number
% % % straps(S).con = [1 2]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [C(1,1) C(1,1)*tand(alpha) + 2*r(1)/cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 1; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 1 - Loop set 1, aft 1'; % Name of strap set


%% Strap set 2 - Loop set 1, aft 2
S = 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 0; % Level of strap pretension

straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial

straps(S).mat = [150400 .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = eps0(S); % Strap prestrain

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 2 - Loop set 1, aft 2'; % Name of strap set


% % % %% Strap set 3 - Loop set 1, aft 3
% % % S = S + 1; % Strap number
% % % straps(S).con = [4 5]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 3 - Loop set 1, aft 3'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 4 - Loop set 1, aft 4
% % % S = S + 1; % Strap number
% % % straps(S).con = [6 7]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 4 - Loop set 1, aft 4'; % Name of strap set
% % % 

%% Strap set 5 - Loop set 1, fore 1
% % % S = S + 1; % Strap number
% % % straps(S).con = [1 2]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [C(1,1) C(1,1)*tand(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 5 - Loop set 1, fore 1'; % Name of strap set


%% Strap set 6 - Loop set 1, fore 2
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 0; % Level of strap pretension

straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial

straps(S).mat = [150400 .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = eps0(S); % Strap prestrain

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 6 - Loop set 1, fore 2'; % Name of strap set


% % % %% Strap set 7 - Loop set 1, fore 3
% % % S = S + 1; % Strap number
% % % straps(S).con = [4 5]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 7 - Loop set 1, fore 3'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 8 - Loop set 1, fore 4
% % % S = S + 1; % Strap number
% % % straps(S).con = [6 7]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 8 - Loop set 1, fore 4'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 9 - Loop set 2, aft 1
% % % S = S + 1; % Strap number
% % % straps(S).con = [1 2]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 9 - Loop set 2, aft 1'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 10 - Loop set 2, aft 2
% % % S = S + 1; % Strap number
% % % straps(S).con = [3 4]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 10 - Loop set 2, aft 2'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 11 - Loop set 2, aft 3
% % % S = S + 1; % Strap number
% % % straps(S).con = [5 6]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 11 - Loop set 2, aft 3'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 12 - Loop set 2, fore 1
% % % S = S + 1; % Strap number
% % % straps(S).con = [1 2]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 12 - Loop set 2, fore 1'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 13 - Loop set 2, fore 2
% % % S = S + 1; % Strap number
% % % straps(S).con = [3 4]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 13 - Loop set 2, fore 2'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 14 - Loop set 2, fore 3
% % % S = S + 1; % Strap number
% % % straps(S).con = [5 6]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 14 - Loop set 2, fore 3'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 15 - Loop set 3, aft 1
% % % S = S + 1; % Strap number
% % % straps(S).con = [7 8]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/4; % Location of first strap
% % % straps(S).num_straps = num_straps*2; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 15 - Loop set 3, aft 1'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 16 - Loop set 3, fore 1
% % % S = S + 1; % Strap number
% % % straps(S).con = [7 8]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_loop; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_loop; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/4; % Location of first strap
% % % straps(S).num_straps = num_straps*2; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 16 - Loop set 3, fore 1'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 17 - Radial, aft
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 0]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [C(1,1) C(1,1)*tand(alpha) + 2*r(1)/cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 1 0]; % Join strap node to other straps, [node1 node2 masterID]
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_1p75in; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_1p75in; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S); % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 17 - Radial, aft'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 18 - Chevron CCW, aft
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 6]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [1 0 17]; % Join strap node to other straps, [node1 node2 masterID]
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_chev; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_chev; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 18 - Chevron CCW, aft'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 19 - Chevron CW, aft
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 6]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [1 0 17]; % Join strap node to other straps, [node1 node2 masterID]
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_chev; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_chev; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = -2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 19 - Chevron CW, aft'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 20 - Radial, fore
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 0]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [C(1,1) C(1,1)*tand(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 1 0]; %% Join strap node to other straps, [node1 node2 masterID]
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_1p75in; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_1p75in; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = eps0(S - 2); % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 20 - Radial, fore'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 21 - Chevron CCW, fore
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 6]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [1 0 20]; % Join strap node to other straps, [node1 node2 masterID]
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_chev; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_chev; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 21 - Chevron CCW, fore'; % Name of strap set
% % % 
% % % 
% % % %% Strap set 22 - Chevron CW, fore
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 6]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [1 0 20]; % Join strap node to other straps, [node1 node2 masterID]
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 0; % Level of strap pretension
% % % 
% % % straps(S).axial = axial_2in_chev; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k_2in_chev; % Strap stiffness piecewise polynomial
% % % 
% % % straps(S).mat = [150400 .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = -2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % straps(S).strap_ID = 'Strap set 22 - Chevron CW, fore'; % Name of strap set
% % % 



end

