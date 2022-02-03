function [con] = get_con_07MAR17(k)
% Calculate constraint violation

k_min = 5000; % lbf/in
% k = analysis.k_0;

if k < k_min
    con = (k_min - k)^2*100;
else
    con = 0;
end

end

