function [straps] = define_straps_WT(C,r,alpha_cone)
% Strap sets input deck
% User must create a strap set structure for each strap set.  Includes 
% information used to define the properties of the straps.

alpha = 90 - alpha_cone;

num_straps = 28; % Divisible by 4
num_strap_sets = 27;

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


%% Strap set 1 - Loop set 1, aft 1
S = 1; % Strap number
straps(S).con = [0 1]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) C(1,1)*tand(alpha) + 2*r(1)/cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,1000000,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 11 - Loop set 2, aft 3'; % Name of strap set


%% Strap set 12 - Loop set 2, aft 4
S = S + 1; % Strap number
straps(S).con = [7 8]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 12 - Loop set 2, aft 4'; % Name of strap set


%% Strap set 13 - Loop set 2, fore 1
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 13 - Loop set 2, fore 1'; % Name of strap set


%% Strap set 14 - Loop set 2, fore 2
S = S + 1; % Strap number
straps(S).con = [3 4]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 14 - Loop set 2, fore 2'; % Name of strap set


%% Strap set 15 - Loop set 2, fore 3
S = S + 1; % Strap number
straps(S).con = [5 6]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 15 - Loop set 2, fore 3'; % Name of strap set


%% Strap set 16 - Loop set 2, fore 4
S = S + 1; % Strap number
straps(S).con = [7 8]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 16 - Loop set 2, fore 4'; % Name of strap set


%% Strap set 17 - Chevron CCW1, aft
S = S + 1; % Strap number
straps(S).con = [6 7]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,70400,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 2*pi/num_straps/4/2; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 17 - Chevron CCW1, aft'; % Name of strap set


%% Strap set 18 - Chevron CW1, aft
S = S + 1; % Strap number
straps(S).con = [6 7]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,70400,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = -2*pi/num_straps/4/2; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 18 - Chevron CW1, aft'; % Name of strap set


%% Strap set 19 - Chevron CCW2, aft
S = S + 1; % Strap number
straps(S).con = [5 6]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,70400,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 2*pi/num_straps/4/2; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 19 - Chevron CCW2, aft'; % Name of strap set


%% Strap set 20 - Chevron CW2, aft
S = S + 1; % Strap number
straps(S).con = [5 6]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,70400,70400,1);

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = -2*pi/num_straps/4/2; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 20 - Chevron CW2, aft'; % Name of strap set


%% Strap set 21 - Radial, fore
S = S + 1; % Strap number
straps(S).con = [0 0]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) C(1,1)*tand(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = [((C(4,1) + C(5,1))/2 + r(2)*sind(alpha)), ((C(4,2) + C(5,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 1 0]; %% Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 200; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,74375,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 21 - Radial, fore'; % Name of strap set


%% Strap set 22 - Chevron CCW1, fore
S = S + 1; % Strap number
straps(S).con = [0 7]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(4,1) + C(5,1))/2 + r(2)*sind(alpha)), ((C(4,2) + C(5,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 21]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 0; % 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,70400,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 22 - Chevron CCW1, fore'; % Name of strap set


%% Strap set 23 - Chevron CW1, fore
S = S + 1; % Strap number
straps(S).con = [0 7]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(4,1) + C(5,1))/2 + r(2)*sind(alpha)), ((C(4,2) + C(5,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 21]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 0; % 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,70400,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = -2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 23 - Chevron CW1, fore'; % Name of strap set


%% Strap set 24 - Chevron CCW2, fore
S = S + 1; % Strap number
straps(S).con = [0 6]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(4,1) + C(5,1))/2 + r(2)*sind(alpha)), ((C(4,2) + C(5,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 21]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 0; % 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,70400,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 24 - Chevron CCW2, fore'; % Name of strap set


%% Strap set 25 - Chevron CW2, fore
S = S + 1; % Strap number
straps(S).con = [0 6]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(4,1) + C(5,1))/2 + r(2)*sind(alpha)), ((C(4,2) + C(5,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 21]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 0; % 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,70400,70400,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = -2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 25 - Chevron CW2, fore'; % Name of strap set


%% Strap set 26 - Chevron rad 1, fore
S = S + 1; % Strap number
straps(S).con = [0 7]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(4,1) + C(5,1))/2 + r(2)*sind(alpha)), ((C(4,2) + C(5,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 21]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 0; % 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,74375,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 26 - Chevron rad1, fore'; % Name of strap set


%% Strap set 27 - Chevron rad 2, fore
S = S + 1; % Strap number
straps(S).con = [0 5]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(4,1) + C(5,1))/2 + r(2)*sind(alpha)), ((C(4,2) + C(5,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 21]; % Join strap node to other straps, [node1 node2 masterID]
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 0; % 50; % Level of strap pretension
[straps(S).axial,straps(S).axial_k,straps(S).mat,straps(S).geom,straps(S).eps0] = bilin_strap(straps(S).PT,10,74375,1);

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 27 - Chevron CW, fore'; % Name of strap set




end

