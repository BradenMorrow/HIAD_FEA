function [d,k] = strap_PT(d0,PT)
% Add strap pretension to response

% Initial response
d = d0;

% Account for pretension
d.coefs(:,end) = d.coefs(:,end) - PT;

% Find root
e = fnzeros(d);

% Shift curve
d.breaks = d.breaks - e(1);

% Find stiffness
k = fnder(d);


% % % figure(1)
% % % clf
% % % box on
% % % hold on
% % % fnplt(d,'b-')
% % % xlim([0 .045])


end

