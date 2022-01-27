function [KL,P,el_out] = get_KL_P_flex_shear_noniter_P_delta(el_in)
%GET_KL_P_FLEX
%   Calculate the element stiffness matrix and element forces using the
%   flexibility method.  Following Taucer et al. (1991), A Fiber
%   Beam-Column Element...
%   Shear deformability from Marini and Spacone (2006), Analysis of
%   Reinforced Concrete Elemnents Including Shear Effects

% Extract variables
L = el_in.L; % Element length
R = el_in.r; % Radius of tube
cords = el_in.nodes; % Fiber constitutive relationships
p = el_in.p; % Internal pressure
beta = el_in.beta; % Braid angle

EL = el_in.propsLH(1); % Longitudinal modulus
GLH = el_in.propsLH(3); % Inplane shear modulus
t = 3*el_in.propsLH(5); % Shell thickness

A = 2*pi*R*t; % Shell area
I = pi*R^3*t; % Shell moment of inertia

% State determination variables
K = el_in.flex.K; % Element stiffness
D = el_in.flex.D; % Section forces
Du = el_in.flex.Du; % Section forces
Q = el_in.flex.Q; % Element forces
f = el_in.flex.f; % Section compliance matrices
d = el_in.flex.d; % Section deformations
e = el_in.flex.e; % Section fiber strains

r = el_in.flex.r; % Residual element displacements
v = el_in.flex.v; % Integration point deflections

% Number of integration points
n = el_in.n;

% Initialize
alpha = el_in.alpha; % Location of fibers
l = zeros(size(alpha,1),3,n);
for i = 1:n
    l(:,:,i) = [ones(size(alpha,1),1) -R*cosd(alpha(:,i)) R*sind(alpha(:,i))]; % Location of fibers (cartesian)
end

% Initialize
b = zeros(5,5,n); % Force interpolation functions
dD = zeros(5,n); % Section force increment
dd = zeros(5,n); % Section deformation increment
rho = zeros(5,n); % Residual deformations
de = zeros(size(l,1),n); % Fiber strain increments

sig = zeros(size(l,1),n); % Fiber force
EA = zeros(size(l,1),n); % Fiber stiffness
k = zeros(5,5,n); % Section stiffness matrix
Dr = zeros(5,n); % Section resisting forces
Fi = zeros(5,5,n); % Element flexibility matrix at section
F = zeros(5); % Element flexibility matrix
% r = zeros(5,1); % Residual element deformations

% Gauss-Lobatto integration constants
[xi,wi] = get_GL(n);

dq = el_in.dD(1:5); % Taucer notation

% Fiber beam element, non-iterative state determination, Neuenhofer and Filippou (1997)
% (1) Compute the nodal force increments
dQ = K*(dq + r); % Change in element forces
Q = Q + dQ;

% Loop through sections
for i = 1:n
    x = L/2*xi(i) + L/2;
    
    % Force interpolation at sections
    b(:,:,i) = [1 0 0 0 0 % [axial Mz My Vz Vy]'
        v(1,i) (x/L - 1) (x/L) 0 0
        -v(2,i) 0 0 (x/L - 1) (x/L)
        0 -1/L -1/L 0 0
        0 0 0 1/L 1/L];
    
    % (2) Compute the section force increments
    % Section force increment
    dD(:,i) = b(:,:,i)*dQ + Du(:,i);
    
    % (3) Compute the section deformation increments
    dd(:,i) = f(:,:,i)*dD(:,i);
    d(:,i) = d(:,i) + dd(:,i);
    
    % (4) Compute section resisting forces
    % Compute the fiber deformation increments
    de(:,i) = l(:,:,i)*dd(1:3,i);
    e(:,i) = e(:,i) + de(:,i);
    
    % Compute fiber stresses and tangent moduli
    % Determine current fiber force and stiffness
    interp_meth = 'linear'; % 'spline'; % 'pchip'; %
    tol1 = 1e-10;
    for m = 1:size(alpha,1) % Fibers
        % Extract cord force - strain relationship
        axial = cords(i).cords(m).axial;
        
        % Calculate cord stiffness
        force = interp1(axial(:,2),axial(:,1),[e(m,i) e(m,i) + tol1]',interp_meth,'extrap');
        sig(m,i) = force(1);
        
        % force_up = interp1(axial(:,2),axial(:,1),e(m,i) + tol1,interp_meth);
        EA(m,i) = (force(2) - force(1))/tol1;
    end
    
    % (6) Compute the section tangent stiffness matrix
    % Tangent stiffness
    k(:,:,i) = zeros(5);
    k(1:3,1:3,i) = l(:,:,i)'*diag(EA(:,i))*l(:,:,i);
    
    % Including elastic shell, with work done by pressure due to shear deformation induced volume change
    k_shell = diag([EL*A EL*I EL*I (GLH*A/2 + p*pi*R^2) (GLH*A/2 + p*pi*R^2)]');
    k(:,:,i) = k(:,:,i) + k_shell;
    
    % (7) Section tangent flexibility matrix
    f(:,:,i) = k(:,:,i)\eye(5);
    
    % Reordered DOFs [axial Mz My Vz Vy]'
    Dr(:,i) = [sum(sig(:,i))  + p*pi*R^2*2*cotd(beta)^2 + EL*A*d(1,i) - p*pi*R^2
        sum(sig(:,i).*l(:,2,i))
        sum(sig(:,i).*l(:,3,i))
        0
        0] + k_shell*d(:,i).*[0 1 1 1 1]'; % Includes axial prestress and shell forces
    
    % (8) Compute the element flexibility matrix
    % Flexibility matrix at section
    Fi(:,:,i) = b(:,:,i)'*f(:,:,i)*b(:,:,i);
    
    % Integrate b(x)'*f(x)*b(x) over the element length to obtain the element
    % flexibility matrix, sum products of function evaluations and weights
    F = F + L/2*wi(i)*Fi(:,:,i);
    
    % (9) Compute the element stiffness matrix - BELOW
    
    % (10) Compute the residual section deformations
    rho(:,i) = f(:,:,i)*(D(:,i) + dD(:,i) - Dr(:,i));
    
    
    % (11) Compute the residual element displacements
    ri = b(:,:,i)'*rho(:,i);
    r = r + L/2*wi(i)*ri;
end

% (9) Compute the element stiffness matrix
% Inverse of the element flexibility matrix is the element stiffness
% matrix, K = F^-1
K = F\eye(5);

% (12) Element resisting forces
Q = Q + dQ - K*r; % New element forces

% (13) Unbalanced section forces
for i = 1:n
    Du(:,i) = b(:,:,i)*Q - Dr(:,i);
end

% For passing back to corotational formulation
J = 2*pi*R^3*t;

% Element forces for corotational formulation (including linear torsion)
P = [Q; el_in.D(6)*GLH*J/L];

% Element stiffness matrix for corotational formulation (including linear
% torsion)
KL = zeros(6);
KL(6,6) = GLH*J/L;
KL(1:5,1:5) = K;

% Store variables for future iterations
el_out.break = 0;
el_out.K = K; % Element stiffness
el_out.D = Dr; % Section forces
el_out.Du = Du; % Unbalanced section forces
el_out.Q = Q; % Element forces
el_out.f = f; % Section compliance matrices
el_out.d = d; % Section deformations
el_out.e = e; % Section fiber strains


el_out.r = r; % Residual element displacments

% % % % Plot strain at end of beam
% % % if el_in.el == 3;
% % %     plot_strain
% % % end
% % %
% % % % For tracking change in volume
% % % dV_L = L/2*wi'*(pi*R^2*d(1,:)');
% % % dV_H = L/2*wi'*(pi*R^2*d(1,:)*nuLH.*(d(1,:)*nuLH - 2))';
% % % dV = pi*R^2*(1 - 2*nuLH)*L/2*wi'*d(1,:)';
% % %
% % % el_out.dV_L = dV_L;
% % % el_out.dV_H = dV_H;
% % % el_out.dV = dV;

end



