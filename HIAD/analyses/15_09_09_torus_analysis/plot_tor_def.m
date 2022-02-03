function plot_tor_def(FEM)

% Current step
U = FEM.OUT.U;
U2 = zeros(length(U)/6,6);
for i = 1:6
    U2(:,i) = U(i:6:length(U));
end
ui = mean(sum(U2(:,1:3).^2,2).^.5); % Torus displacement

strap_ind = FEM.SPRING(2).ind;
fi = sum(sum(FEM.OUT.fint_el(7:9,strap_ind,end).^2).^.5);% Internal strap forces



% Loading history
Uinc2 = [zeros(size(FEM.OUT.U,1),1) FEM.OUT.Uinc];

u_inc = zeros(size(Uinc2,2),1);
tor_ind = FEM.CONFIG.ind;
for j = 1:size(Uinc2,2)
    Uinc = Uinc2(:,j);
    U2 = zeros(length(Uinc)/6,6);
    for k = 1:6
        U2(:,k) = Uinc(k:6:length(Uinc));
    end

    u2 = sum(U2(tor_ind,1:2).^2,2).^.5; % Average displacement vector magnitude
    u_inc(j) = mean(u2);
end





% Internal strap forces
F = zeros(size(FEM.OUT.fint_el,3),1);
for i = 2:size(FEM.OUT.fint_el,3)
    F(i) = sum(sum(FEM.OUT.fint_el(7:9,strap_ind,i).^2).^.5); % sum(FEM.OUT.fint_el(7,strap_ind,i));
end

a = size(F,1);
b = size(u_inc,1);
while a > b
    F(end) = [];
    a = size(F,1);
end

while b > a
    u_inc(end) = [];
    b = size(u_inc,1);
end


% u_inc = zeros(size(FEM.OUT.Uinc,2) + 1,1);
% for j = 1:size(FEM.OUT.Uinc,2)
%     Uinc = FEM.OUT.Uinc(:,j);
%     U2 = zeros(length(Uinc)/6,6);
%     for k = 1:6
%         U2(:,k) = Uinc(k:6:length(Uinc));
%     end
% 
%     u2 = sum(U2(:,1:3).^2,2).^.5; % Average displacement vector magnitude
%     ind = FEM.CONFIG.ind;
%     u3 = u2(ind);
%     u_inc(j + 1) = mean(u3);
% end


% Linear solution
EA = 496636.913209813; % 241442.929073828;

R = 66.3985882748306;
k = 2*pi*EA/R;


% Maximum compressive load
Fext = 2*pi*(pi*FEM.CONFIG.r^2*20*(1 - 2*cotd(71)^2));




% Plotting
figure(4)
clf
box on
hold on
xlim([0 2])
ylim([0 15000])
plot([0 1],[0 k*1],'k--','linewidth',1)
plot([0 10],[Fext Fext],'k--','linewidth',1)

plot([0; ui],[0; fi],'mo','markersize',5,'linewidth',1) % Single DOF
plot(u_inc,F,'bo-','markersize',2) % Vector displacement and internal force;



% Format plot
xlabel('Displacement (in)')
ylabel('Total Cable Load (lbf)')
% xlim([0 1])
% ylim([0 7000])


end

