function plot_tor_shape_post(tor_test,FEM,th_sup)
% Plot torus shape, test and model

fig = 1000;
figure(fig)
clf


%% Test
% Load test data
ind = (1:590)';
plot_ind = [ind(1) ind(end)]';
cg_cyl = tor_test.cg_cyl;


% Plotting r vs theta.
subplot(2,1,1)
box on
hold on
for i = 1:size(plot_ind,1)
    plot(cg_cyl(:,2,plot_ind(i))*180/pi,cg_cyl(:,1,plot_ind(i)),'-','linewidth',1)
end

% Plotting z vs theta.
z_bar = 0; % mean(cg_cyl(:,3,plot_ind(1))); % -.35; % 
subplot(2,1,2)
box on
hold on
for i = 1:size(plot_ind,1)
    plot(cg_cyl(:,2,plot_ind(i))*180/pi,cg_cyl(:,3,plot_ind(i)) - z_bar,'-','linewidth',1)
end







% Model
FEM.PLOT.fig = fig;
plot_tor_shape_09DEC16(FEM)


%% Format
figure(fig)
subplot(2,1,1)
xlim([0 360])
ylim([55 60.5])
subplot(2,1,2)
xlim([0 360])
ylim([-1.2 1.2])

% Supports
for j = 1:2
    subplot(2,1,j)
    plot(th_sup([1 1])*180/pi,[-100 100],'k--')
    plot(th_sup([2 2])*180/pi,[-100 100],'k--')
    plot(th_sup([3 3])*180/pi,[-100 100],'k--')
    plot(th_sup([4 4])*180/pi,[-100 100],'k--')
    plot(th_sup([5 5])*180/pi,[-100 100],'k--')
    plot(th_sup([6 6])*180/pi,[-100 100],'k--')
    plot(th_sup([7 7])*180/pi,[-100 100],'k--')
    plot(th_sup([8 8])*180/pi,[-100 100],'k--')
end

% Legend
subplot(2,1,1)
leg(1) = plot([-1 -1],[0 0],'b-');
leg(2) = plot([-1 -1],[0 0],'r-');
leg(3) = plot([-1 -1],[0 0],'g-');
leg(4) = plot([-1 -1],[0 0],'k--');

legend(leg,'Initial',...
    'Test final',...
    'Model final',...
    'Support locations',...
    'location','southeast')


end

