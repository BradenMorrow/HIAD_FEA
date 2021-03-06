function [straps] = define_straps(r_minor,num_straps)
% Strap sets input deck
% User must create a strap set structure for each strap set.  Includes 
% information used to define the properties of the straps.

num_strap_sets = 2;

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
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 1 - fixed, 0 - free (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 1; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,F0,eps0);
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

straps(S).theta0 = 11.25*(pi/180); % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 1 - Loop set 1, aft 1'; % Name of strap set


%% Strap set 2 - Loop set 1, fore 1
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,F0,eps0);
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

straps(S).theta0 = 11.25*(pi/180); % Location of first strap
straps(S).num_straps = num_straps; % Number of straps around HIAD
straps(S).theta_sweep = 0; % Skew strap, angle swept by strap, measured from connectivity 1 to 2, CCW+

straps(S).strap_ID = 'Strap set 2 - Loop set 1, fore 1'; % Name of strap set


%% Strap set 3 - Loading Strap Set 1
S = S + 1; % Strap number
straps(S).con = [1 2]; % Torus connectivities (0 for node)
straps(S).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
straps(S).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
straps(S).bound1 = 0; % Boundary conditions of node 1, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).bound2 = 0; % Boundary conditions of node 2, 0 - free, 1 - fixed (if not connected to a torus)
straps(S).join = [0 0 0]; % Join strap node to other straps, 0 - do not join or NA, 1 - join
straps(S).side = 0; % Side of HIAD strap is on (0 - fore, 1 - aft)
straps(S).PT = 50; % Level of strap pretension
PT_analysis = true; % Add pretension to strap response, false - no pretension, true - add pretension
k_ten = 150400; % Tension stiffness of straps (lbf/strain)
k_com = 100; % Compression stiffness of straps (lbf/strain)
F0 = 5300; % Load level to begin linear tension stiffness
eps0 = 0.09375; % Strain level to begin linear tension stiffness
[axial,axial_k] = strap_response(k_ten,k_com,straps(S).PT,F0,eps0);
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

straps(S).strap_ID = 'Strap set 2 - Loop set 1, fore 1'; % Name of strap set
end

