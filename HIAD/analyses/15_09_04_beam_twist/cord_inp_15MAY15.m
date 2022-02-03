% Cord hysteresis preprocessor
% May 15, 2015


load_point = [0                         0
    44.000605817242        0.0124536982502145];
unload_point = [0                         0
    2713.42354898655        0.0277577649496151];
eps0 = (unload_point(2,2) - load_point(2,2))/(unload_point(2,1) - load_point(2,1))*(Fc - load_point(2,1)) + load_point(2,2);

d_LOAD = load('d_load.txt');
d_UNLOAD = load('d_unload.txt');

% [d] = cord_model_27MAY15(eps0,Fc,load_point,unload_point,d_LOAD,d_UNLOAD,1);
% d = load('axial_table_11');

d = load(axial_table);
eps0 = interp1(d(:,1),d(:,2),Fc);

for i = 1:size(beam_connect,1) % Loop through each element
    element(i).eps0 = eps0*ones(size(alpha,1),2);
    element(i).eps = eps0*ones(size(alpha,1),2);
    element(i).f0 = Fc*ones(size(alpha,1),2);
    element(i).f = Fc*ones(size(alpha,1),2);
    element(i).f_shell0 = [0 0]';
    element(i).f_shell = [0 0]';
    for j = 1:2 % Loop through each node
        for k = 1:length(alpha) % Loop through each cord
            element(i).nodes(j).cords(k).axial = d;
%             element(i).nodes(j).cords(k).axial1 = d1;
            element(i).nodes(j).cords(k).load_point = load_point;
            element(i).nodes(j).cords(k).unload_point = unload_point;
            element(i).nodes(j).cords(k).eps_rate = 1;
            
        end
    end
end


% figure(113)
% % clf
% % box on
% hold on
% plot(d(:,2),d(:,1),'gx-')
% xlim([0 .03])
% ylim([-50 3000])
