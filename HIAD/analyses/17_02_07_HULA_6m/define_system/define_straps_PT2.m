function [straps] = define_straps_PT2(C,r,alpha_cone)
% Strap sets input deck
% User must create a strap set structure for each strap set.  Includes 
% information used to define the properties of the straps.

alpha = 90 - alpha_cone;

num_straps = 32; % Divisible by 4
num_strap_sets = 20;

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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 100; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 200; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .05; % Strain level to begin linear tension stiffness
% % k_ten = 1.8315e+05; % 150400; % Tension stiffness of straps (lbf/strain)
% % k_com = 100; % Compression stiffness of straps (lbf/strain)
% % F0 = 130; % 5300; % Load level to begin linear tension stiffness
% % eps0 = .001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 0; % 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 3200; % Tension stiffness of straps (lbf/strain)
% % % k_com = 3200; % Compression stiffness of straps (lbf/strain)
% % % [axial,axial_k] = strap_response_22SEP16(k_ten,k_com,0,k_ten,1);
% k_ten = 150400; % Tension stiffness of straps (lbf/strain)
% k_com = 100; % Compression stiffness of straps (lbf/strain)
% F0 = 5300; % Load level to begin linear tension stiffness
% eps0 = 0.09375; % Strain level to begin linear tension stiffness
k_ten = 150400; % 1.8315e+05; % *2; % Tension stiffness of straps (lbf/strain)
k_com = 150400; % 1.8315e+05; % *2; % 100; % Compression stiffness of straps (lbf/strain)
F0 = 36.63/2; % 5300; % Load level to begin linear tension stiffness
eps0 = .0001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).theta_sweep = 2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 0; % 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 3200; % Tension stiffness of straps (lbf/strain)
% % % k_com = 3200; % Compression stiffness of straps (lbf/strain)
% % % [axial,axial_k] = strap_response_22SEP16(k_ten,k_com,0,k_ten,1);
% k_ten = 150400; % Tension stiffness of straps (lbf/strain)
% k_com = 100; % Compression stiffness of straps (lbf/strain)
% F0 = 5300; % Load level to begin linear tension stiffness
% eps0 = 0.09375; % Strain level to begin linear tension stiffness
k_ten = 150400; % 1.8315e+05; % *2; % Tension stiffness of straps (lbf/strain)
k_com = 150400; % 1.8315e+05; % *2; % 100; % Compression stiffness of straps (lbf/strain)
F0 = 36.63/2; % 5300; % Load level to begin linear tension stiffness
eps0 = .0001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).theta_sweep = -2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 200; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% k_ten = 150400; % Tension stiffness of straps (lbf/strain)
% k_com = 100; % Compression stiffness of straps (lbf/strain)
% F0 = 5300; % Load level to begin linear tension stiffness
% eps0 = .05; % 0.09375; % Strain level to begin linear tension stiffness
k_ten = 150400; % 1.8315e+05; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % 130; % Load level to begin linear tension stiffness
eps0 = 0.09375; % .001; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).PT = 0; % 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 3200; % Tension stiffness of straps (lbf/strain)
% % % k_com = 3200; % Compression stiffness of straps (lbf/strain)
% % % [axial,axial_k] = strap_response_22SEP16(k_ten,k_com,0,k_ten,1);
% k_ten = 150400; % Tension stiffness of straps (lbf/strain)
% k_com = 100; % Compression stiffness of straps (lbf/strain)
% F0 = 5300; % Load level to begin linear tension stiffness
% eps0 = 0.09375; % Strain level to begin linear tension stiffness
k_ten = 150400; % 1.8315e+05; % *2; % Tension stiffness of straps (lbf/strain)
k_com = 150400; % 1.8315e+05; % *2; % 100; % Compression stiffness of straps (lbf/strain)
F0 = 36.63/2; % 5300; % Load level to begin linear tension stiffness
eps0 = .0001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).theta_sweep = 2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

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
straps(S).PT = 0; % 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
% % % k_ten = 3200; % Tension stiffness of straps (lbf/strain)
% % % k_com = 3200; % Compression stiffness of straps (lbf/strain)
% % % [axial,axial_k] = strap_response_22SEP16(k_ten,k_com,0,k_ten,1);
% k_ten = 150400; % Tension stiffness of straps (lbf/strain)
% k_com = 100; % Compression stiffness of straps (lbf/strain)
% F0 = 5300; % Load level to begin linear tension stiffness
% eps0 = 0.09375; % Strain level to begin linear tension stiffness
k_ten = 150400; % 1.8315e+05; % *2; % Tension stiffness of straps (lbf/strain)
k_com = 150400; % 1.8315e+05; % *2; % 100; % Compression stiffness of straps (lbf/strain)
F0 = 36.63/2; % 5300; % Load level to begin linear tension stiffness
eps0 = .0001; % 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response_22SEP16(k_ten,k_com,straps(S).PT,F0,eps0);
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
straps(S).theta_sweep = -2*pi/num_straps/4; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 20 - Chevron CW, fore'; % Name of strap set




end

