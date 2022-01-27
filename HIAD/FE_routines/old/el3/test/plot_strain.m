global Mi

% Plot the strain on the element cross section

% Strain due to inflation
eps_p = el_in.eps(1,2); % eps_cord_old(1,1);
eps_ax = d(1,end);
kappa = d(2,end);

% Plot
figure(101)
clf
box on
% axis off
hold on

plot([0 0],[-R R],'k-','linewidth',2) % Zero strain
plot([eps_p eps_p],[-R R],'k--','linewidth',2) % Strain due to inflation
plot(eps_p + [eps_ax eps_ax],[-R R],'b-.','linewidth',1) % Stain due to axial extension
plot(eps_p + eps_ax - kappa*[-R R],[-R R],'g--') % Strain due to bending

% Annotate
plot([-.001 .001],[R R],'k-','linewidth',2)
plot([-.001 .001],[0 0],'k-','linewidth',2)
plot([-.001 .001],[-R -R],'k-','linewidth',2)

text(-.0008,1.15*R,'\epsilon','fontsize',20)
% text(-.0012,-R*1.15,'0','fontsize',20)

text(eps_p - .001,R*1.115,'\epsilon_p','fontsize',20)
text(eps_ax + eps_p - .001,R*1.115,'\epsilon_{axial}','fontsize',20)
text(eps_ax + eps_p - .001 - kappa*R,R*1.115,'\epsilon_{bend}','fontsize',20)

text(-.004,R,'r','fontsize',15)
text(-.004,0,'0','fontsize',15)
text(-.0055,-R,'-r','fontsize',15)

% Scale plot
xlim([-.055 .015])
ylim([-R R]*1.25)


Mi = getframe;

