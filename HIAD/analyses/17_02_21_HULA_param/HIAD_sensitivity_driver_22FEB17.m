% Driver script for parameterized HIAD analysis
% February 21, 2017

%% SENSITIVITY
dX = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.01,0.01,0.01,0.01,0.01,0.01,0.01,1,1,1,1,1,1,1,4,1,1,1,1,1,1,1,2,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01]';
X0 = [15,15,15,15,15,15,15,71,71,71,71,71,71,71,60,60,60,60,60,60,60,1,1,1,1,1,1,1,32,32,32,32,32,32,32,32,100,100,100,100,100,100,100,200,1,1,1,1,1,1,1,1,1]';

[param0] = build_param(X0);
[out0] = HIAD_param_21FEB17(param0);
disp('0')


%% JACOBIAN
% Preallocate
out(size(X0,1),1).mass = [];
out(size(X0,1),1).k_0 = [];
out(size(X0,1),1).k_end = [];
out(size(X0,1),1).F_soft = [];
out(size(X0,1),1).FEM_out = [];

tic
parfor i = 1:size(dX,1)
    Xi = X0;
    Xi(i) = X0(i) + dX(i); % New X
    
    parami = build_param(Xi);
    
    % Analyze
    [out(i)] = HIAD_param_21FEB17(parami);
    
    disp(num2str(i))

end
toc
% save('JAC_out','out0','out')



%%
J = zeros(4,size(X0,1));

for i = 1:size(X0,1)
    J(1,i) = (out(i).mass - out0.mass)/dX(i);
    J(2,i) = (out(i).k_0 - out0.k_0)/dX(i);
    J(3,i) = (out(i).k_end - out0.k_end)/dX(i);
    J(4,i) = (out(i).F_soft - out0.F_soft)/dX(i);
end

a(4).val = [];
a(4).I = [];
a(4).param = [];
val = zeros(size(X0,1),4);
paramI = cell(size(X0,1),4);

org_out = cell(size(X0,1),8);
for i = 1:4
    J(i,:) = J(i,:)/max(J(i,:));
    [a(i).val,a(i).I] = sort(J(i,:)',1,'descend');
    a(i).param = param0.label(a(i).I);
    
    val(:,i) = a(i).val;
    paramI(:,i) = a(i).param;
    
end

org_out = cell(53,8);
org_out = [paramI(:,1) num2cell(val(:,1)) paramI(:,2) num2cell(val(:,2)) paramI(:,3) num2cell(val(:,3)) paramI(:,4) num2cell(val(:,4))];


%%
a1(4).val = [];
a1(4).I = [];
a1(4).param = [];
val1 = zeros(size(X0,1),4);
paramI1 = cell(size(X0,1),4);
for i = 1:4
    J(i,:) = abs(J(i,:)/max(J(i,:)));
    [a1(i).val,a1(i).I] = sort(J(i,:)',1,'descend');
    a1(i).param = param0.label(a1(i).I);
    
    val1(:,i) = a1(i).val;
    paramI1(:,i) = a1(i).param;
end

org_out1 = cell(53,8);
org_out1 = [paramI1(:,1) num2cell(val1(:,1)) paramI1(:,2) num2cell(val1(:,2)) paramI1(:,3) num2cell(val1(:,3)) paramI1(:,4) num2cell(val1(:,4))];

% % % %% ANALYSIS
% % % % Run analysis
% % % [out] = HIAD_param_21FEB17(in);






