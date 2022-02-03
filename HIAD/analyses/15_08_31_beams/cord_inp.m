% Cord hysteresis preprocessor
% May 12, 2015

for i = 1:n % Loop through elements
    element(i).eps0 = eps0*ones(size(alpha,1),2);
    element(i).eps = zeros(size(alpha,1),2);
    element(i).f0 = Fc*ones(size(alpha,1),2);
    element(i).f = zeros(size(alpha,1),2);
    for j = 1:2 % Loop through each node
        for k = 1:length(alpha) % Loop through cords in an element
            element(i).nodes(j).cords(k).unload_point = [0 0
                2500 .0263];
            element(i).nodes(j).cords(k).load_point = [0 0
                50 .01235];
            element(i).nodes(j).cords(k).eps_rate = 1;
%             element(i).nodes(j).cords(k).eps0 = 0;
%             element(i).nodes(j).cords(k).eps = 0;
        end
    end
end


