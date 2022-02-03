
load('pp.mat')

strain = linspace(0,20e-3,100)';

figure(1)
clf
box on
hold on
xlabel('Strain')
ylabel('Force (lb)')

figure(2)
clf
box on
hold on
xlabel('Strain')
ylabel('Stiffness (lb/strain)')

for i = 1:size(pp,2)
    figure(1)
    di = ppval(pp(i).d,strain);
    plot(strain,di)
    
    figure(2)
    ki = ppval(pp(i).k,strain);
    plot(strain,ki)
end
