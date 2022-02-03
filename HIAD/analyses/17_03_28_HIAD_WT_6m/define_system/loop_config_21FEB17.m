function [axial,axial_k,mat,geom,eps0] = loop_config_21FEB17(PT,k_fac)
% Hard-wired strap response


k_com = 10; % Compression stiffness (lbf/in)
tangent = .11; % Strain level to start tangent stiffness

% Make polynomials
x = linspace(-.1,.2,1000)';

x0 = linspace(-.1,0,10)'; % Linear in compression range
y0 = k_com*x0;

x1 = linspace(0,tangent,10)'; % Quadratic in tensile, low strain range
y1 = 100000*1.7*x1.^2;

x2 = linspace(tangent,.2,10)'; % Linear in tensile, high strain range
y2 = 2*100000*1.7*tangent*x2 - 100000*1.7*tangent^2;

k_ten = 2*100000*1.7*tangent; % Tension stiffness in linear range (lbf/in)

x0(end) = [];
y0(end) = [];
x2(1) = [];
y2(1) = [];

XY = [x0 y0
    x1 y1
    x2 y2];

% Scale strap stiffness
XY(XY(:,1) > 0,1) = XY(XY(:,1) > 0,1)/k_fac;

eps_PT = pchip(XY(:,2),XY(:,1),PT); % Prestress strain level

XY = [XY; [eps_PT PT]]; % Include in table
XY(:,1) = sort(XY(:,1));
XY(:,2) = sort(XY(:,2));

XY(:,1) = XY(:,1) - eps_PT; % Shift curve
XY(:,2) = XY(:,2) - PT;

% Make polynomials
axial = spline(XY(:,1),XY(:,2));
axial_k = fndir(axial,1);


% Linear FE input properties
mat = [k_ten .3]; % Material properties [E nu]
t = .0285; % Strap thickness (in)
w = 2*k_fac; % Strap width (in)
geom = [t*w w*t^3/12 w^3*t/12 0 .312*w*t^3]; % Element geometry, local z perpendicular to global theta [A Izz Iyy ky J]
eps0 = 0; % Strap prestrain (with shifted curve)


% % % % Plot force-strain response
% % % figure(1)
% % % % clf
% % % box on
% % % hold on
% % % 
% % % % % % plot(x0,y0,'r--','linewidth',3)
% % % % % % plot(x1,y1,'k--','linewidth',3)
% % % % % % plot(x2,y2,'b--','linewidth',3)
% % % % % % plot(XY(:,1),XY(:,2),'k-','linewidth',1)
% % % plot(x,ppval(axial,x)','r-','linewidth',1)
% % % % % % plot(eps_PT,PT,'rx','linewidth',3,'markersize',15)
% % % % % % plot(0,0,'bx','linewidth',3,'markersize',15)
% % % 
% % % % Plot stiffness-strain response
% % % figure(2)
% % % clf
% % % box on
% % % hold on
% % % 
% % % plot(x,ppval(axial_k,x))





end




