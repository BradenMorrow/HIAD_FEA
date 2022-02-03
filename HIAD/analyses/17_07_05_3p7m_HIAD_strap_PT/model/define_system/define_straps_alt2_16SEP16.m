function [straps] = define_straps_alt2_16SEP16(C,r,alpha_cone)
% Staggered loop straps, chevron to T4
% Strap sets input deck
% User must create a strap set structure for each strap set.  Includes 
% information used to define the properties of the straps.

alpha = 90 - alpha_cone;
num_straps = 96; % Divisible by 4


%% Preallocate - analysis requires the following fields
num_strap_sets = 24;
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


%% Strap 1 - Loop set 1, aft
S = 1; % Strap number
straps(S).con = [0 1]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) - r(1)*sind(alpha) C(1,2) + r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 2 - Loop set 2, aft
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*1*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 3 - Loop set 3, aft
S = S + 1; % Strap number
straps(S).con = [2 3]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*2*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 4 - Loop set 4, aft
S = S + 1; % Strap number
straps(S).con = [3 4]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*3*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 5 - Loop set 5, aft
S = S + 1; % Strap number
straps(S).con = [4 5]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*4*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 6 - Loop set 6, aft
S = S + 1; % Strap number
straps(S).con = [3 4]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*5*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 7 - Loop set 7, aft
S = S + 1; % Strap number
straps(S).con = [2 3]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*6*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 8 - Loop set 8, aft
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*7*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 9 - Loop set 9, aft
S = S + 1; % Strap number
straps(S).con = [5 6]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 10 - Loop set 1, fore
S = S + 1; % Strap number
straps(S).con = [0 1]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) + r(1)*sind(alpha) C(1,2) - r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 11 - Loop set 2, fore
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*1*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 12 - Loop set 3, fore
S = S + 1; % Strap number
straps(S).con = [2 3]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*2*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 13 - Loop set 4, fore
S = S + 1; % Strap number
straps(S).con = [3 4]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*3*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 14 - Loop set 5, fore
S = S + 1; % Strap number
straps(S).con = [4 5]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*4*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 15 - Loop set 6, fore
S = S + 1; % Strap number
straps(S).con = [3 4]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*5*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 16 - Loop set 7, fore
S = S + 1; % Strap number
straps(S).con = [2 3]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*6*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 17 - Loop set 8, fore
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 360/num_straps/8*7*pi/180; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 18 - Loop set 9, fore
S = S + 1; % Strap number
straps(S).con = [5 6]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 19 - Radial, aft
S = S + 1; % Strap number
straps(S).con = [0 0]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) - r(1)*sind(alpha) C(1,2) + r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 1 0]; % Join strap node to other straps, use unique number for each node to be joined
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 99751; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 20 - Chevron CCW, aft
S = S + 1; % Strap number
straps(S).con = [0 4]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 13]; % Join strap node to other straps, use unique number for each node to be joined
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 114000; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 360/num_straps/4*pi/180; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 21 - Chevron CW, aft
S = S + 1; % Strap number
straps(S).con = [0 4]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0 13]; % Join strap node to other straps, use unique number for each node to be joined
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 114000; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = -360/num_straps/4*pi/180; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 22 - Radial, fore
S = S + 1; % Strap number
straps(S).con = [0 0]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) + r(1)*sind(alpha) C(1,2) - r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 2 0]; %% Join strap node to other straps, use unique number for each node to be joined
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 99751; % Tension stiffness of straps (lbf/in)
k_com = 100; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 23 - Chevron CCW, fore
S = S + 1; % Strap number
straps(S).con = [0 4]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [2 0 16]; % Join strap node to other straps, use unique number for each node to be joined
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 114000; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 360/num_straps/4*pi/180; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap 24 - Chevron CW, fore
S = S + 1; % Strap number
straps(S).con = [0 4]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [2 0 16]; % Join strap node to other straps, use unique number for each node to be joined
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 114000; % Tension stiffness of straps (lbf/in)
k_com = 114000; % Compression stiffness of straps (lbf/in)
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
if ~PT_analysis
    axial.breaks = axial.breaks - axial.breaks(3);
    axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
    axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
end

straps(S).axial = axial; % Strap response piecewise polynomial
straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
straps(S).mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
straps(S).eps0 = 0; % Strap prestrain

straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = -360/num_straps/4*pi/180; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+














%%
% % % %% Strap set 3 - Loop set 1, aft 3
% % % S = S + 1; % Strap number
% % % straps(S).con = [4 5]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 4 - Loop set 1, fore 1
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 1]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [C(1,1) + r(1)*sind(alpha) C(1,2) - r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 5 - Loop set 1, fore 2
% % % S = S + 1; % Strap number
% % % straps(S).con = [2 3]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 6 - Loop set 1, fore 3
% % % S = S + 1; % Strap number
% % % straps(S).con = [4 5]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 7 - Loop set 2, aft 1
% % % S = S + 1; % Strap number
% % % straps(S).con = [1 2]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 8 - Loop set 2, aft 2
% % % S = S + 1; % Strap number
% % % straps(S).con = [3 4]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 9 - Loop set 2, aft 3
% % % S = S + 1; % Strap number
% % % straps(S).con = [5 6]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 10 - Loop set 2, fore 1
% % % S = S + 1; % Strap number
% % % straps(S).con = [1 2]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 11 - Loop set 2, fore 2
% % % S = S + 1; % Strap number
% % % straps(S).con = [3 4]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 12 - Loop set 2, fore 3
% % % S = S + 1; % Strap number
% % % straps(S).con = [5 6]; % Torus connectivities (0 for node)
% % % straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 13 - Radial, aft
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 0]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [C(1,1) - r(1)*sind(alpha) C(1,2) + r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 1 0]; % Join strap node to other straps, use unique number for each node to be joined
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 100; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 99751; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 14 - Chevron CCW, aft
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 4]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [1 0 13]; % Join strap node to other straps, use unique number for each node to be joined
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 114000; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 15 - Chevron CW, aft
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 4]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [1 0 13]; % Join strap node to other straps, use unique number for each node to be joined
% % % straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 114000; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 0; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = -2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 16 - Radial, fore
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 0]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [C(1,1) + r(1)*sind(alpha) C(1,2) - r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [0 2 0]; %% Join strap node to other straps, use unique number for each node to be joined
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 100; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 99751; % Tension stiffness of straps (lbf/in)
% % % k_com = 100; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 17 - Chevron CCW, fore
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 4]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [2 0 16]; % Join strap node to other straps, use unique number for each node to be joined
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 114000; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = 2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+
% % % 
% % % 
% % % %% Strap set 18 - Chevron CW, fore
% % % S = S + 1; % Strap number
% % % straps(S).con = [0 4]; % Torus connectivities (0 for node)
% % % straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
% % % straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
% % % straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
% % % straps(S).join = [2 0 16]; % Join strap node to other straps, use unique number for each node to be joined
% % % straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
% % % straps(S).PT = 50; % Level of strap pretension
% % % PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 114000; % Tension stiffness of straps (lbf/in)
% % % k_com = 114000; % Compression stiffness of straps (lbf/in)
% % % [axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,PT_analysis);
% % % if ~PT_analysis
% % %     axial.breaks = axial.breaks - axial.breaks(3);
% % %     axial.coefs(:,4) = axial.coefs(:,4) - straps(S).PT;
% % %     axial_k.breaks = axial_k.breaks - axial_k.breaks(3);
% % % end
% % % 
% % % straps(S).axial = axial; % Strap response piecewise polynomial
% % % straps(S).axial_k = axial_k; % Strap stiffness piecewise polynomial
% % % straps(S).mat = [k_ten .3]; % Material properties [E nu]
% % % t = .0285; % Strap thickness (in)
% % % w = 2; % Strap width (in)
% % % straps(S).geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
% % % straps(S).eps0 = 0; % Strap prestrain
% % % 
% % % straps(S).theta0 = 2*pi/num_straps/2; % Location of first strap
% % % straps(S).num_straps = num_straps; % Number of straps around HIAD
% % % straps(S).theta_sweep = -2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+




end

