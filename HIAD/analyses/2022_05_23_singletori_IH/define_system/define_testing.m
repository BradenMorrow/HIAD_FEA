function [testing] = define_testing()

testing(1).node1 = []; % Nodal location of strap end 1 in (X, Z) space (if not connected to a torus)
testing(1).node2 = []; % Nodal location of strap end 2 in (X, Z) space (if not connected to a torus)
testing(1).axial = []; % Strap response piecewise polynomial
testing(1).axial_k = []; % Strap stiffness piecewise polynomial
testing(1).mat = []; % Material properties [E nu]
testing(1).geom = []; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
testing(1).theta0 = []; % offset of first strap
testing(1).num_straps = []; % Number of straps around HIAD
testing(1).strap_ID = []; % Name of strap set