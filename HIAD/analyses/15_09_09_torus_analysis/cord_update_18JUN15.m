
Fc = p*pi*r^2/length(alpha)*(1 - 2*cot(beta*pi/180)^2);
eps0 = interp1(d_LOAD(:,1),d_LOAD(:,2),Fc);
eps_rate = -1;
load_point = [0 0];
unload_point = [0 0
    Fc eps0];

[d] = cord_model_27MAY15(eps0,Fc,load_point,unload_point,d_LOAD,d_UNLOAD,eps_rate);



c_max = zeros(size(FEM.CONFIG(1).element,2),2);
c_min = c_max;

for i = 1:FEM.CONFIG.ind(end) % Loop through each element
    FEM.CONFIG.element(i).eps0 = eps0*ones(size(alpha,1),2);
    FEM.CONFIG.element(i).eps = eps0*ones(size(alpha,1),2);
    FEM.CONFIG.element(i).f0 = Fc*ones(size(alpha,1),2);
    FEM.CONFIG.element(i).f = Fc*ones(size(alpha,1),2);
    FEM.CONFIG.element(i).f_shell0 = [0 0]';
    FEM.CONFIG.element(i).f_shell = [0 0]';
    
%     FEM_out_shape.CONFIG(1).element(i).eps0 = FEM_out_shape.CONFIG(1).element(i).eps;
%     FEM_in_shape.CONFIG(1).element(i).eps0 = FEM_out_shape.CONFIG(1).element(i).eps;
%     FEM_in_shape.CONFIG(1).element(i).eps = FEM_out_shape.CONFIG(1).element(i).eps;
%     FEM_in_shape.CONFIG(1).element(i).f0 = FEM_in_shape.CONFIG(1).element(i).f0;

    eps = FEM_out_shape.CONFIG(1).element(i).eps;
    f = FEM_out_shape.CONFIG(1).element(i).f;
%     disp(eps)
    c_max(i,:) = [max(max(eps)) max(max(f))];
    c_min(i,:) = [min(min(eps)) min(min(f))];
    for j = 1:2 % Loop through each node
        for k = 1:length(alpha) % Loop through each cord
            FEM.CONFIG.element(i).nodes(j).cords(k).axial = d;
            FEM.CONFIG.element(i).nodes(j).cords(k).load_point = load_point;
            FEM.CONFIG.element(i).nodes(j).cords(k).unload_point = unload_point;
            FEM.CONFIG.element(i).nodes(j).cords(k).eps_rate = eps_rate;
            FEM.CONFIG.element(i).nodes(j).cords(k).d_LOAD = d_LOAD;
            FEM.CONFIG.element(i).nodes(j).cords(k).d_UNLOAD = d_UNLOAD;
        end
    end
end

% C_max = max(c_max)
% C_min = min(c_min)


% FEM_in_shape.ANALYSIS.d_inc = 1;


figure(111)
clf
box on
hold on
plot(d_LOAD(:,2),d_LOAD(:,1))
xlim([0 .03])
ylim([0 3000])


a = 1;




