function[FEM] =sym_var
% repackages FEM variables for symmetry
clear
out=load('output_15JUL15.mat');
FEM=out.out(48);

% CONNECT
% 1st half of matrix
Connect = FEM.GEOM.connect;

size_connect = size(Connect,1);

% 2nd half of matrix, column 1
for i = 1:size_connect+1
Connect(size_connect+i,1) = size_connect+i;
Connect(size_connect+i,2) = size_connect+i+1;
end

%2nd half of matrix, columns 2 and 3
Connect(size_connect+1:end,3) = ones*5;
Connect(size_connect+1:end,4) = ones;

% Save variable 
FEM.GEOM.connect = Connect;


% NODES
nodes1 = FEM.GEOM.nodes;
size_nodes = size(nodes1,1);
difn2 = flipud(diff(nodes1));

%initialize nodes
nodes = zeros(2*size_nodes-1,3);

% 1st half of nodes
nodes(1:size_nodes,1:3) = nodes1;

%Makes last entry of first half the 1st entry of the second half
nodes(size_nodes+1,1) = nodes1(end,1);

% 2nd half of nodes
for i=2:size_nodes
   nodes(size_nodes+i,1) = nodes(size_nodes+(i-1),1)+difn2(i-1,1);
end

%save variable
FEM.GEOM.nodes = nodes;

% ORIENT
orient1 = FEM.GEOM.orientation;
size_orient = size(orient1,1);

%Initialize orient
orient = zeros(2*size_orient-1,3);

difo2 = flipud(diff(orient1));

%1st half of orient
orient(1:size_orient,1:3) = orient1;

% Makes last entry of 1st half 1st entry of 2nd half
orient(size_orient+1,1) = orient1(end,1);

% 2nd half of matrix, column 1
for i=2:size_orient
   orient(size_orient+i,1) = orient(size_orient+(i-1),1)+difo2(i-1,1);
end

%2nd half of matrix, column 2
orient(:,2) = ones;

%Save variable
FEM.GEOM.orientation = orient;

% F
DOF = FEM.ANALYSIS.DOF;
F1 = FEM.BOUND.F;
%initialize F2
F2 = zeros(length(F1)/DOF,DOF);

%1st half of F2
for i = 1:DOF
    F2(:,i) = F1(i:DOF:length(F1));
end

% All of F2
F2 = [F2; flipud(F2)];

% Column format(F)
F = F2';
FEM.BOUND.F = F(:);

% U
Uinc = FEM.OUT.Uinc;
U1 = Uinc(:,36);
%Initialize U2
U2 = zeros(length(U1)/DOF,DOF);

%1st half of U2
for i  =1:DOF
    U2(:,i) = U1(i:DOF:length(U1));
end

% All of U2
U2 = [U2;flipud(U2)];
% Make 2nd half x deflections be -
U2(18:end,1) = -U2(18:end,1);
% convert to column (U)
U2 = U2';
FEM.OUT.U = U2(:);

%Run post proc
post_proc_driver