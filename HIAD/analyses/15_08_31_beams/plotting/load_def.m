% Generic load deformation plot
% September 2, 2015
% Andy Young

%% DATA
u = [0
    0.021576
    0.043187
    0.064802
    0.086429
    0.10807
    0.12976
    0.15151
    0.17342
    0.19565
    0.2178
    0.23988
    0.2619
    0.28387
    0.30667
    0.32943
    0.35208
    0.37498
    0.39785
    0.4207
    0.44354
    0.46648
    0.48936
    0.51224
    0.5352
    0.55816
    0.58111
    0.60411
    0.62711
    0.65007
    0.67308
    0.69608
    0.71908
    0.74211
    0.76511
    0.78811
    0.81112
    0.83413
    0.85714
    0.88012
    0.90308
    0.92603
    0.94899
    0.97192
    0.99486
    1.0178];

f = [0
    6.1698
    13.588
    20.595
    27.273
    33.687
    39.655
    45.147
    49.795
    52.989
    56.066
    59.052
    61.979
    64.851
    65.774
    66.688
    67.56
    68.086
    68.607
    69.124
    69.641
    69.958
    70.269
    70.58
    70.813
    71.047
    71.28
    71.452
    71.624
    71.794
    71.933
    72.072
    72.211
    72.335
    72.458
    72.581
    72.686
    72.791
    72.895
    73.004
    73.113
    73.221
    73.326
    73.431
    73.536
    73.641];

%% PLOT
u = smooth(u);
f = smooth(f);

figure(1)
clf
% box on
% axis off
hold on
plot(u,f,'ko-','markersize',3)



xlim([0 .5])
ylim([0 80])

x = xlabel('\Delta');
y = ylabel('P','rot',0);

set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
set(gca,'xtick',[])
set(gca,'ytick',[])

set(x,'Position',get(x,'Position') + [.2 0 0])
set(y,'Position',get(y,'Position') + [-.01 30 0])
% set(y,'Position',get(y,'Position') + [0 35 0])

set(findall(gcf,'type','text'),'FontSize',11,'FontName','cambria','fontangle','italic')
set(findall(gcf,'type','axes'),'FontSize',11,'FontName','cambria','fontangle','italic')

set(gcf,'units','inches','Position',[8 3 3 2]);


% determine position of the axes
axp = get(gca,'Position');

% determine startpoint and endpoint for the arrows 
xs=axp(1);
xe=axp(1)+axp(3)+0.04;
ys=axp(2);
ye=axp(2)+axp(4)+0.05;

% make the arrows
annotation('arrow', [xs xe],[ys ys]);
annotation('arrow', [xs xs],[ys ye]);

set(gca,'YTick',[])
set(gca,'XTick',[])
% set(gca,'YColor',get(gca,'Color'))
% set(gca,'XColor',get(gca,'Color'))




