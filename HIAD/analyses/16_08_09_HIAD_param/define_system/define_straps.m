function [straps] = define_straps(C,r,alpha_cone)
% Strap sets input deck
% User must create a strap set structure for each strap set.  Includes 
% information used to define the properties of the straps.

alpha = 90 - alpha_cone;
N = 148; % Number of radial strap sets

%% Preallocate - analysis requires the following fields
straps(18,1).con = []; % Torus connectivities (0 for node)
straps(18,1).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(18,1).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(18,1).bound1 = []; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(18,1).bound2 = []; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(18,1).join = []; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(18,1).side = []; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(18,1).PT = []; % Level of strap pretension
straps(18,1).axial = []; % Strap response piecewise polynomial
straps(18,1).axial_k = []; % Strap stiffness piecewise polynomial
straps(18,1).mat = []; % Material properties [E nu]
straps(18,1).geom = []; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]

straps(18,1).theta0 = []; % Location of first strap
straps(18,1).num_straps = []; % Number of straps around HIAD
straps(18,1).theta_sweep = []; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 1 - Loop set 1, aft 1
S = 1; % Strap number
straps(S).con = [0 1]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) - r(1)*sind(alpha) C(1,2) + r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 2 - Loop set 1, aft 2
S = 2; % Strap number
straps(S).con = [2 3]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 3 -Loop set 1, aft 3
S = 3; % Strap number
straps(S).con = [4 5]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 4 - Loop set 1, fore 1
S = 4; % Strap number
straps(S).con = [0 1]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) + r(1)*sind(alpha) C(1,2) - r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 5 - Loop set 1, fore 2
S = 5; % Strap number
straps(S).con = [2 3]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 6 - Loop set 1, fore 3
S = 6; % Strap number
straps(S).con = [4 5]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 7 - Loop set 2, aft 1
S = 7; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 360/N/2; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 8 - Loop set 2, aft 2
S = 8; % Strap number
straps(S).con = [3 4]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 360/N/2; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 9 - Loop set 2, aft 3
S = 9; % Strap number
straps(S).con = [5 6]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 360/N/2; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 10 - Loop set 2, fore 1
S = 10; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 360/N/2; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 11 - Loop set 2, fore 2
S = 11; % Strap number
straps(S).con = [3 4]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 360/N/2; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 12 - Loop set 2, fore 3
S = 12; % Strap number
straps(S).con = [5 6]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = []; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 360/N/2; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 13 - Radial, aft
S = 13; % Strap number
straps(S).con = [0 0]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) - r(1)*sind(alpha) C(1,2) + r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 1]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 14 - Chevron CCW, aft
S = 14; % Strap number
straps(S).con = [0 4]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 360/N/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 15 - Chevron CW, aft
S = 15; % Strap number
straps(S).con = [0 4]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 - r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 + r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 0; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = -360/N/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 16 - Radial, fore
S = 16; % Strap number
straps(S).con = [0 0]; % Torus connectivities (0 for node)
straps(S).node1 = [C(1,1) + r(1)*sind(alpha) C(1,2) - r(1)*cosd(alpha)]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 1; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 1]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 360/N/2; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 17 - Chevron CCW, fore
S = 17; % Strap number
straps(S).con = [0 4]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 360/N/2; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = 360/N/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+


%% Strap set 18 - Chevron CW, fore
S = 18; % Strap number
straps(S).con = [0 4]; % Torus connectivities (0 for node)
straps(S).node1 = [((C(3,1) + C(4,1))/2 + r(2)*sind(alpha)), ((C(3,2) + C(4,2))/2 - r(2)*cosd(alpha))]; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = []; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [1 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
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

straps(S).theta0 = 360/N/2; % Location of first strap
straps(S).num_straps = N; % Number of straps around HIAD
straps(S).theta_sweep = -360/N/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+




end

