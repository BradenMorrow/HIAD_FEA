%% Loading Cable Internal Force
for i = 1:size(FEM_out2.OUT.Uinc,2)
    oneCableForce(i) = FEM_out2.OUT.Uinc(5,i);
end

step = [1:size(FEM_out2.OUT.Uinc,2)];
fig = figure('Name','Tori Rotation About Centerline');
plot(step,oneCableForce)
title('Tori Rotation About Centerline')
xlabel('Iteration');
ylabel('Rotation About Centerline (rad)')
hold on
for i = 1:size(FEM_out2.OUT.Uinc,2)
    oneCableForce(i) = FEM_out2.OUT.Uinc(size(theta,1)*6+5,i);
end

step = [1:size(FEM_out2.OUT.Uinc,2)];
plot(step,oneCableForce)
hold off
axis tight
ax = gca;
ax.YAxis.Exponent = 0;
legend('T4','T5',Location='northeast')

% saveas(fig,"SingleLoadingCableInternalForces.fig")