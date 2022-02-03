cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = true; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if(add_path)
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\axial
    addpath ./analyses\15_09_30_follow_ten
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\axial
    rmpath ./analyses\15_09_30_follow_ten
end