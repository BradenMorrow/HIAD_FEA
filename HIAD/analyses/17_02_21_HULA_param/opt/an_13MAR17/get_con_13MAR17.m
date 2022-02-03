function [con] = get_con_13MAR17(k,X)
% Calculate constraint violation

%%
k_min = 5000; % lbf/in

if k < k_min
    con = (k_min - k)^2*100;
else
    con = 0;
end


%%
F_min = 25000; % lbf

r = [7.6
    7.625
    7.65
    7.675
    7.7
    7.725
    3.25];

p = X(1:7)';
beta = X(8:14)';

F = sum(pi*p*pi.*r.^2.*(1 - 2*cotd(beta).^2).*(1:7)'/7);

if F < F_min
    con = con + (F - F_min)^2;
end



end

