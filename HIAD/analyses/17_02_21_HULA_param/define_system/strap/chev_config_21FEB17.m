function [axial,axial_k,mat,geom,eps0] = chev_config_21FEB17(PT,k_fac)
% Hard-wired strap response (BILINEAR)


%%
% PT = 0;
k_com = 2*100000*1.7*.11; % 300; % Compression stiffness (lbf/in)
k_ten = 2*100000*1.7*.11; % Tension stiffness in linear range (lbf/in)


% Make polynomials
x0 = linspace(-.1,0,10)'; % Linear in compression range
y0 = k_com*x0;

x1 = linspace(0,.1,10)'; % Quadratic in tensile, low strain range
y1 = k_ten*x1;

x0(end) = [];
y0(end) = [];

XY = [x0 y0
    x1 y1];

% Scale strap stiffness
XY(XY(:,1) > 0,1) = XY(XY(:,1) > 0,1)/k_fac;

eps_PT = interp1(XY(:,2),XY(:,1),PT); % Prestress strain level

XY = [XY; [eps_PT PT]]; % Include in table
% XY(:,1) = XY(:,1));
% XY(:,2) = unique(XY(:,2));

XY(:,1) = XY(:,1) - eps_PT; % Shift curve
XY(:,2) = XY(:,2) - PT;

XY = [unique(XY(:,1)) unique(XY(:,2))];

% Make polynomials
axial = interp1(XY(:,1),XY(:,2),'linear','pp');
axial = rmfield(axial,'orient');
% axial = griddedInterpolant(XY(:,1),XY(:,2),'linear');

axial_k = fndir(axial,1);

% griddedInterpolant
% Linear FE input properties
mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2; % Strap width (in)
geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
eps0 = 0; % Strap prestrain (with shifted curve)


% Plot force-strain response
x = linspace(-.1,.2,1000)';

figure(2)
clf
box on
hold on

plot(x0,y0,'r--','linewidth',3)
plot(x1,y1,'k--','linewidth',3)
plot(XY(:,1),XY(:,2),'k-','linewidth',1)
plot(x,ppval(axial,x)','r-','linewidth',1)
plot(eps_PT,PT,'rx','linewidth',3,'markersize',15)
plot(0,0,'bx','linewidth',3,'markersize',15)

% % % % Plot stiffness-strain response
% % % figure(2)
% % % clf
% % % box on
% % % hold on
% % % 
% % % plot(x,ppval(axial_k,x))



%%

end




