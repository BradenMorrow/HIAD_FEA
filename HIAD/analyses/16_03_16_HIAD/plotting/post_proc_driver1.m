cd ..
cd .\post_proc

%% Color Plot
plot_tor(1).n = 0; % Number of slats on cross section, 0 for no plot
plot_tor(1).LS = 44; % load step plotted
plot_tor(1).PF = 1; % plot forces?
plot_tor(1).plot_type = 1; % 1 = DCP, 2 = DF, 3 = UF, 4 = DWF, 5 = UWF 
plot_tor(1).def = 1;
plot_tor(1).fig = 1; %figure number
plot_tor(1).u_comp = 4; % U_component = 1 for x, 2 for y, 3 for z, 4 for magnitude
plot_tor(1).auto_scale = 1; % auto color scale switch 
plot_tor(1).caxis = [0 5]; % Min and max displacement scale
plot_tor(1).color = 'k'; % color  of fill or wireframe
plot_tor(1).view = 6; % TF = 1 for Bottom View, 
    % TF = 2 for Top View
    % TF = 3 for Right View
    % TF = 4 for Left View
    % TF = 5 for Back View
    % TF = 6 for Front View
    % TF = 7 for Isometric View
plot_tor(1).el_type = [2 4]; % plotting elements other than 5 
plot_tor(1).scale = 1; % scale of deformation
plot_tor(1).triad = 0; % triad switch
plot_tor(1).triad_loc = [0 0 0]'; % triad location
plot_tor(1).axis = 0; % axis switch

%% Deformed with Fill
plot_tor(2).n = 0; % Number of slats on cross section, 0 for no plot
plot_tor(2).LS = 36; % load step plotted
plot_tor(2).PF = 1; % plot forces?
plot_tor(2).plot_type = 2; % 1 = DCP, 2 = DF, 3 = UF, 4 = DWF, 5 = UWF 
plot_tor(2).def=1;
plot_tor(2).fig = 2; %figure number
plot_tor(2).u_comp = 4; % U_component = 1 for x, 2 for y, 3 for z, 4 for magnitude
plot_tor(2).auto_scale = 0; % auto color scale switch 
plot_tor(2).caxis = [0,5]; % Min and max displacement scale
plot_tor(2).color = 'g'; % color  of fill or wireframe
plot_tor(2).view = 6; % TF = 1 for Bottom View, 
    % TF = 2 for Top View
    % TF = 3 for Right View
    % TF = 4 for Left View
    % TF = 5 for Back View
    % TF = 6 for Front View
    % TF = 7 for Isometric View
plot_tor(2).el_type = 4; % plotting elements other than 5 
plot_tor(2).scale = 1; % scale of deformation
plot_tor(2).triad = 0; % triad switch
plot_tor(2).triad_loc = [0 0 0]'; % triad location
plot_tor(2).axis = 0; % axis switch

%% Undeformed with Fill
plot_tor(3).n = 20; % Number of slats on cross section, 0 for no plot
plot_tor(3).LS = 1; % load step plotted
plot_tor(3).PF = 0; % plot forces?
plot_tor(3).plot_type = 3; % 1 = DCP, 2 = DF, 3 = UF, 4 = DWF, 5 = UWF 
plot_tor(3).def = 0; % is the torus deformed?
plot_tor(3).fig = 2; %figure number
plot_tor(3).u_comp = 4; % U_component = 1 for x, 2 for y, 3 for z, 4 for magnitude
plot_tor(3).auto_scale = 1; % auto color scale switch 
plot_tor(3).caxis = [0,5]; % Min and max displacement scale
plot_tor(3).color = [.7 .7 .7]; % color  of fill or wireframe
plot_tor(3).view = 7; % TF = 1 +Y, Z vert
                      % TF = 2 -Y, Z vert
                      % TF = 3 -X, Y vert
                      % TF = 4 +X, Y vert
                      % TF = 5 +Z, Y vert
                      % TF = 6 -Z, Y vert
                      % TF = 7 ISO
plot_tor(3).el_type = [2 4]; % plotting elements other than 5 
plot_tor(3).scale = 1; % scale of deformation
plot_tor(3).triad = 0; % triad switch
plot_tor(3).triad_loc = [0 0 0]'; % triad location
plot_tor(3).axis = 0; % axis switch

%% Deformed Wireframe
plot_tor(4).n = 0; % Number of slats on cross section, 0 for no plot
plot_tor(4).LS = 36; % load step plotted
plot_tor(4).PF = 1; % plot forces?
plot_tor(4).plot_type = 4; % 1 = DCP, 2 = DF, 3 = UF, 4 = DWF, 5 = UWF 
plot_tor(4).def=1;
plot_tor(4).fig = 4; %figure number
plot_tor(4).u_comp = 4; % U_component = 1 for x, 2 for y, 3 for z, 4 for magnitude
plot_tor(4).auto_scale = 1; % auto color scale switch 
plot_tor(4).caxis = [0,5]; % Min and max displacement scale
plot_tor(4).color = 'k'; % color  of fill or wireframe
plot_tor(4).view = 6; % TF = 1 for Bottom View, 
    % TF = 2 for Top View
    % TF = 3 for Right View
    % TF = 4 for Left View
    % TF = 5 for Back View
    % TF = 6 for Front View
    % TF = 7 for Isometric View
plot_tor(4).el_type = 4; % plotting elements other than 5 
plot_tor(4).scale = 1; % scale of deformation
plot_tor(4).triad = 0; % triad switch
plot_tor(4).triad_loc = [0 0 0]'; % triad location
plot_tor(4).axis = 0; % axis switch

%% Undeformed Wireframe
plot_tor(5).n = 0; % Number of slats on cross section, 0 for no plot
plot_tor(5).LS = 1; % load step plotted
plot_tor(5).PF = 0; % plot forces?
plot_tor(5).plot_type = 5; % 1 = DCP, 2 = DF, 3 = UF, 4 = DWF, 5 = UWF 
plot_tor(5).def = 0;
plot_tor(5).fig = 2; % figure number
plot_tor(5).u_comp = 4; % U_component = 1 for x, 2 for y, 3 for z, 4 for magnitude
plot_tor(5).auto_scale = 0; % auto color scale switch 
plot_tor(5).caxis = [0,5]; % Min and max displacement scale
plot_tor(5).color = 'k'; % [.1 .1 .1]; % color  of fill or wireframe
plot_tor(5).view = 7; % TF = 1 for Bottom View, 
    % TF = 2 for Top View
    % TF = 3 for Right View
    % TF = 4 for Left View
    % TF = 5 for Back View
    % TF = 6 for Front View
    % TF = 7 for Isometric View
plot_tor(5).el_type = []; % plotting elements other than 5 
plot_tor(5).scale = 1; % scale of deformation
plot_tor(5).triad = 0; % triad switch
plot_tor(5).triad_loc = [0 0 0]'; % triad location
plot_tor(5).axis = 0; % axis switch


%% Run function
for i = 1:size(plot_tor,2)
    if plot_tor(i).n > 0
        figure(plot_tor(i).fig)
        clf
    end
end

post_proc(FEM,plot_tor)

cd(dir0)