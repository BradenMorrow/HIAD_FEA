function [KL,P,el_out] = get_KL_P_flex_shear(el_in)
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
beta = el_in.beta;

EL = el_in.propsLH(1); % Longitudinal modulus
GLH = el_in.propsLH(3); % Inplane shear modulus
t = 3*el_in.propsLH(5); % Shell thickness

A = 2*pi*R*t; % Shell area
I = pi*R^3*t; % Shell moment of inertia

% State determination variables
K = el_in.flex.K; % Element stiffness
D = el_in.flex.D; % Section forces
Q = el_in.flex.Q; % Element forces
f = el_in.flex.f; % Section compliance matrices
d = el_in.flex.d; % Section deformations
e = el_in.flex.e; % Section fiber strains

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
r = zeros(5,n); % Residual deformations
de = zeros(size(l,1),n); % Fiber strain increments

sig = zeros(size(l,1),n); % Fiber force
EA = zeros(size(l,1),n); % Fiber stiffness
k = zeros(5,5,n); % Section stiffness matrix
Dr = zeros(5,n); % Section resisting forces
Du = zeros(5,n); % Section unbalanced forces
Fi = zeros(5,5,n); % Element flexibility matrix at section
F = zeros(5); % Element flexibility matrix
s = zeros(5,1); % Residual element deformations

% Gauss-Lobatto integration constants
[xi,wi] = get_GL(n);

% Fiber beam element state determination (Taucer et al. 1991, pg 59)
% (1) Solve global system of equations and update structure displacements
% Global

% (2) Update element deformations, q, (D in corotational formulation)
dq = el_in.dD(1:5); % Taucer notation

% (3) Start fiber beam-column element state determination
j = 0;

conv = 1;
tol = 1e-6;
tol_D = zeros(size(D));
EC = 5*n;

max_iter = 20;
while conv ~= EC && j < max_iter
    j = j + 1;

    % (4) Compute the element force increments
    dQ = K*dq; % Change in element forces

    % (5) Update the element forces
    Q = Q + dQ; % New element forces

    % Loop through sections
    for i = 1:n
        x = L/2*xi(i) + L/2;

        % Force interpolation at sections
        b(:,:,i) = [1 0 0 0 0 % [axial Mz My Vz Vy]'
            0 (x/L - 1) (x/L) 0 0
            0 0 0 (x/L - 1) (x/L)
            0 -1/L -1/L 0 0
            0 0 0 1/L 1/L];

        % (6) Compute the section force increments
        % Section force increment
        dD(:,i) = b(:,:,i)*dQ;
        D(:,i) = D(:,i) + dD(:,i);

        % (7) Compute the section deformation increments
        dd(:,i) = f(:,:,i)*dD(:,i) + r(:,i);
        d(:,i) = d(:,i) + dd(:,i);

        % (8) Compute the fiber deformation increments
        de(:,i) = l(:,:,i)*dd(1:3,i);
        e(:,i) = e(:,i) + de(:,i);

        % (9) Compute fiber stresses and tangent moduli
        % Determine current fiber force and stiffness
        interp_meth = 'linear'; % 'spline'; % 'pchip'; % 
        tol1 = 1e-10;
        for m = 1:size(alpha,1) % Fibers
            % Extract cord force - strain relationship
            axial = cords(i).cords(m).axial;

            % Calculate cord stiffness
            force = interp1(axial(:,2),axial(:,1),e(m,i),interp_meth);
            sig(m,i) = force;

            force_up = interp1(axial(:,2),axial(:,1),e(m,i) + tol1,interp_meth);
            EA(m,i) = (force_up - force)/tol1;
        end

        % (10) Compute the section tangent stiffness and flexibility matrices
        % Tangent stiffness
        k(:,:,i) = zeros(5);
        k(1:3,1:3,i) = l(:,:,i)'*diag(EA(:,i))*l(:,:,i);
        
        % Including elastic shell, with work done by pressure due to shear deformation induced volume change
        k_shell = diag([EL*A EL*I EL*I (GLH*A/2 + p*pi*R^2) (GLH*A/2 + p*pi*R^2)]');        k(:,:,i) = k(:,:,i) + k_shell;

        % Tangent flexibility
        f(:,:,i) = k(:,:,i)\eye(5);

        % (11) Compute the section resisting forces
        % Reordered DOFs [axial Mz My Vz Vy]'
        Dr(:,i) = [sum(sig(:,i))  + p*pi*R^2*2*cotd(beta)^2 + EL*A*d(1,i) - p*pi*R^2
            sum(sig(:,i).*l(:,2,i))
            sum(sig(:,i).*l(:,3,i))
            0
            0] + k_shell*d(:,i).*[0 1 1 1 1]'; % Includes axial prestress and shell forces

        % (12) Compute the section unbalanced forces
        Du(:,i) = D(:,i) - Dr(:,i);

        % (13) Compute the residual section deformations
        r(:,i) = f(:,:,i)*Du(:,i);

        % (14) Compute the element flexibility matrix
        % Flexibility matrix at section
        Fi(:,:,i) = b(:,:,i)'*f(:,:,i)*b(:,:,i);

        % Integrate b(x)'*f(x)*b(x) over the element length to obtain the element
        % flexibility matrix, sum products of function evaluations and weights
        F = F + L/2*wi(i)*Fi(:,:,i);

        % (15) Compute the residual element deformations
        si = b(:,:,i)'*r(:,i);
        s = s + L/2*wi(i)*si;
    end

    % (14 continued) Compute the element stiffness matrix
    % Inverse of the element flexibility matrix is the element stiffness
    % matrix, K = F^-1
    K = F\eye(5);

    % (15 continued) Check for element convergence
    % Absolute criteria
    tol_a = [tol*ones(1,n)
        tol*L*ones(2,n)
        tol*ones(2,n)];

    % Relative criteria
    tol_b = abs(D*tol);

    % Maximum of criteria
    tol_ind = 0 < (tol_a - tol_b);
    tol_D(tol_ind) = tol_a(tol_ind);
    tol_D(~tol_ind) = tol_b(~tol_ind);

    % Number of converged DOFs
    conv = sum(sum(abs(Du) < tol_D));

    % Update element deformations for next iteration
    dq = -s;
end

% If state determination process has not converged, cutback Newton
% iteration
if j == max_iter && conv ~= EC
    warning('State determination cutback')
    el_out.break = 1;
else
    el_out.break = 0;
end

% (16) Assemble structure resisting forces and structural stiffness matrix
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
el_out.K = K; % Element stiffness
el_out.D = D; % Section forces
el_out.Q = Q; % Element forces
el_out.f = f; % Section compliance matrices
el_out.d = d; % Section deformations
el_out.e = e; % Section fiber strains


% (p*R/t*cotd(beta)^2 - EL*d(2,end)*R + EL*d(1,end))*(2*pi*R*t/15)
% (-EL*d(2,end)*R + EL*d(1,end))*(2*pi*R*t/15)
% -d(2,end)*R + d(1,end)
% d(1:2,end)


eps_c = .00441268524598038;
EH = el_in.propsLH(2);
nuyx = el_in.propsLH(4);
nuxy = nuyx*EL/EH;
eps_ax = d(1,end);

R1 = -R*(eps_c*nuxy + eps_ax*nuxy - 1) - (p*R^2*(nuxy*nuyx - 1))/(EH*t);
disp([R R1])
end




















