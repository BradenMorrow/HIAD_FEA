function [p] = get_p(Pin,loc,tol)
% Interpolate to get the pressure distribution on the HIAD
% Pin is the input matrix, [X Y Z P]
% loc is the location of interest [x y z]
% tol is the size of the square to sample (+/- tol)
% p is the pressure output value

% Points
x = loc(1);
y = loc(2);
z = loc(3);

X = Pin(:,1);
Y = Pin(:,2);
Z = Pin(:,3);
P = Pin(:,4);

% Grab indices
ind = X > x - tol & X < x + tol & ...
    Y > y - tol & Y < y + tol & ...
    Z > z - tol & Z < z + tol;

p = mean(P(ind));


% % % %%
% % % figure(10)
% % % clf
% % % box off
% % % axis off
% % % axis equal
% % % hold on
% % % 
% % % xlim([min(X) max(X)])
% % % ylim([min(Y) max(Y)])
% % % zlim([min(Z) max(Z)])
% % % 
% % % plot3(x,y,z,'ko')
% % % scatter3(X(ind),Y(ind),Z(ind),[],P(ind),'filled')
% % % 
% % % % colorbar
% % % % colormap('jet')
% % % 
% % % view(2)
% % % % % % view(0,0)
% % % % % % xlabel('X')
% % % % % % ylabel('Y')
% % % % % % zlabel('Z')
% % % 
% % % drawnow
% % % % % % disp(p)


end

