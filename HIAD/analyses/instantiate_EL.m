function el_in0 = instantiate_EL()
%% This script will instantiate all the objects of each element
% All parts of each element must be instatiated to use a mex file for
% faster execution

%% EL 4
EL.el_in0.break = 0;
EL.el_in0.mat = [0 0];
EL.el_in0.geom = [0 0 0 0 0];

EL.el_in0.axial.form = 'aa';
EL.el_in0.axial.breaks = zeros(1,10);
EL.el_in0.axial.coefs = zeros(5,5);
EL.el_in0.axial.pieces = 0;
EL.el_in0.axial.order = 0;
EL.el_in0.axial.dim = 0;

EL.el_in0.axial_k.form = 'aa';
EL.el_in0.axial_k.breaks = zeros(1,10);
EL.el_in0.axial_k.coefs = zeros(5,5);
EL.el_in0.axial_k.pieces = 0;
EL.el_in0.axial_k.order = 0;
EL.el_in0.axial_k.dim = 0;

EL.el_in0.eps0 = 0;

%% EL 3
% Special element input
EL.el_in0.K0 = zeros(6,6);
EL.el_in0.p = 0;
EL.el_in0.r = 0;
EL.el_in0.alpha = zeros(2,10);
EL.el_in0.beta = 0;

EL.el_in0.eps = zeros(1,2);
EL.el_in0.f = zeros(1,2);

% Cord input
EL.el_in0.nodes(1).cords(1).axial = zeros(10,2);

EL.el_in0.propsLH = [0 0 0 0 1]'; % [ELong EHoop GLH nuHL 1]'; % Shell properties

EL.el_in0.D0 = [0 0 0 0 0 0]';
EL.el_in0.P0 = [0 0 0 0 0 0]';

EL.el_in0.n = 0;

% Initialize stored variables for fiber model
EL.el_in0.flex.break = 0;
EL.el_in0.flex.K = zeros(5); % Element stiffness
EL.el_in0.flex.D = zeros(5,1); % Section forces
EL.el_in0.flex.Du = zeros(5,1); % Unbalanced section forces
EL.el_in0.flex.Q = zeros(5,1); % Element forces
EL.el_in0.flex.f = zeros(5,5,1); % Section compliance matrices
EL.el_in0.flex.d = zeros(5,1); % Section deformations
EL.el_in0.flex.e = zeros(2,2); % Section fiber strains

% Iterative or non-iterative state determination procedure
EL.el_in0.state_it = false;

el_in0 = EL.el_in0;
end
