function view_orient(TF)
% view_orient
% Changes the view of the plot 

if TF == 1
    % Bottom view
    view(0,0)
    camlight('right')

elseif TF == 2
    % Top View
    view(180,0)
    camlight('right')

elseif TF == 3
    % Right View
    view(90,0)
    camorbit(-90,0,'data',[1 0 0])
    camlight('right')

elseif TF == 4
    % Left View
    view(-90,0)
    camorbit(-90,0,'data',[1 0 0])
    camlight('right')

elseif TF == 5
    % Back View
    view(180,-90)
    camlight('right')

elseif TF == 6
    % Front View
    view(0,90)
    camlight('right')

elseif TF == 7
    % Isometric View
    view(3)
    camlight('right')

end
lighting gouraud
material shiny
end