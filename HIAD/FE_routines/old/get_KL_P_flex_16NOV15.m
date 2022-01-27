function [KL,P,el_out] = get_KL_P_flex(el_in)
%GET_KL_P_FLEX
%   Calculate the element stiffness matrix and element forces using the
%   flexibility method.  Following Taucer et al. (1991), A Fiber
%   Beam-Column Element...

% Extract variables
L = el_in.L; % Element length
radius = el_in.r; % Radius of tube
cords = el_in.nodes; % Fiber constitutive relationships

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
    l(:,:,i) = [ones(size(alpha)) -radius*cosd(alpha) radius*sind(alpha)]; % Location of fibers (cartesian)
end

% Initialize
b = zeros(3,5,n); % Force interpolation functions
dD = zeros(3,n); % Section force increment
dd = zeros(3,n); % Section deformation increment
r = zeros(3,n); % Residual deformations
de = zeros(size(l,1),n); % Fiber strain increments

sig = zeros(size(l,1),n); % Fiber force
EA = zeros(size(l,1),n); % Fiber stiffness
k = zeros(3,3,n); % Section stiffness matrix
Dr = zeros(3,n); % Section resisting forces
Du = zeros(3,n); % Section unbalanced forces
Fi = zeros(5,5,n); % Element flexibility matrix at section
F = zeros(5); % Element flexibility matrix
s = zeros(5,1); % Residual element deformations

% Gauss-Lobatto integration
% Constants for varying numbers of integration points
if n == 3
    wi = [1/3 4/3 1/3]';
elseif n == 4
    wi = [1/6 5/6 5/6 1/6]';
elseif n == 5
    wi = [1/10 49/90 32/45 49/90 1/10]';
end

% Fiber beam element state determination (Taucer et al. 1991, pg 59)
% (1) Solve global system of equations and update structure displacements
% Global

% (2) Update element deformations, q, (D in corotational formulation)
dq = el_in.dD(1:5); % Taucer notation

% (3) Start fiber beam-column element state determination
j = 0;

conv = 1;
tol = 1e-4;
while conv > tol
    j = j + 1;
    
    % (4) Compute the element force increments
    dQ = K*dq; % Change in element forces

    % (5) Update the element forces
    Q = Q + dQ; % New element forces

    % Loop through sections
    for i = 1:n
        x = (i - 1)*L/(n - 1);

        % Force interpolation at sections
        % b(:,:,i) = [(x/L - 1) (x/L) 0 0 0
        %     0 0 (x/L - 1) (x/L) 0
        %     0 0 0 0 1];
        b(:,:,i) = [1 0 0 0 0 % Reordered DOFs [axial Mz My]'
            0 (x/L - 1) (x/L) 0 0
            0 0 0 (x/L - 1) (x/L)];

        % (6) Compute the section force increments
        % Section force increment
        dD(:,i) = b(:,:,i)*dQ;
        D(:,i) = D(:,i) + dD(:,i);

        % (7) Compute the section deformation increments
        dd(:,i) = f(:,:,i)*dD(:,i) + r(:,i);
        d(:,i) = d(:,i) + dd(:,i);

        % (8) Compute the fiber deformation increments
        de(:,i) = l(:,:,i)*dd(:,i);
        e(:,i) = e(:,i) + de(:,i);

        % (9) Compute fiber stresses and tangent moduli
        % Determine current fiber force and stiffness
        interp_meth = 'linear'; % 'spline'; % 'pchip'; % 
        tol1 = 1e-4;
        for m = 1:length(alpha) % Fibers
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
        k(:,:,i) = l(:,:,i)'*diag(EA(:,i))*l(:,:,i);
        
        % Tangent flexibility
        f(:,:,i) = k(:,:,i)\eye(3);

        % (11) Compute the section resisting forces
        %  Dr(:,i) = [-sum(sig(:,i).*l(:,1,i))
        %     sum(sig(:,i).*l(:,2,i))
        %     sum(sig(:,i))];
        Dr(:,i) = [sum(sig(:,i)) % Reordered DOFs [axial Mz My]'
            sum(sig(:,i).*l(:,2,i))
            sum(sig(:,i).*l(:,3,i))];
        
% % %         % Account for prestress due to inflation pressure
% % %         Dr(3,i) = Dr(3,i)  + p*pi*r^2*2*cotd(beta)^2 + 2*pi*r*t*EL*d(3,i) - p*pi*r^2;

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
    conv = norm(Du);
    
    % Update element deformations
    dq = -s;
end

% (16) Assemble structure resisting forces and structural stiffness matrix
% For passing back to corotational formulation
G = el_in.propsLH(3);
t = 3* el_in.propsLH(5);
J = 2*pi*radius^3*t;

% Element forces for corotational formulation (including linear torsion)
P = [Q; el_in.D(6)*G*J/L];

% Element stiffness matrix for corotational formulation (including linear
% torsion)
KL = zeros(6);
KL(6,6) = G*J/L;
KL(1:5,1:5) = K;

% Store variables for future iterations
el_out.K = K; % Element stiffness
el_out.D = D; % Section forces
el_out.Q = Q; % Element forces
el_out.f = f; % Section compliance matrices
el_out.d = d; % Section deformations
el_out.e = e; % Section fiber strains

end


































