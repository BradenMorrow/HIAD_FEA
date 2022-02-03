function [con] = get_con_17MAR17(k,FU)
% Calculate constraint violation

%%
k_min = 5000; % lbf/in

if k < k_min
    con = (k_min - k)^2;
else
    con = 0;
end


%%
F = 25000;
U_lin = F/k_min;
delta_U = interp1(FU(:,1),FU(:,2),F,'linear') - U_lin;


if isnan(delta_U)
    con = con + 1e6;
elseif delta_U > 1
    con = con + delta_U^2*1000;
end

% % % figure(2)
% % % hold on
% % % plot([0 U_lin],[0 FU(end,1)],'k--')


% % % if F < F_min
% % %     con = con + (F - F_min)^2;
% % % end



end

