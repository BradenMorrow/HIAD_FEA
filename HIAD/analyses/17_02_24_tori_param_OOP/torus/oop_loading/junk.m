

%%
no = FEM2.MODEL.nodes;
or = FEM2.MODEL.orientation;

id = (16:20)';


figure(200)
clf
box on
hold on
axis equal
plot3(no(id,1),no(id,2),no(id,3),'b-o')
plot3(or(id,1),or(id,2),or(id,3),'g-x')




%%

FEM_out1.PLOT.plot_iter = true;
FEM_out1.PLOT.number = false;
FEM_out1.PLOT.scale = 10;



















