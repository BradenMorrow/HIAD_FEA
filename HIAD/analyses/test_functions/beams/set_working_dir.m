cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..
cd ..

add_path = true; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if(add_path)
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\test_functions
    addpath ./analyses\test_functions\beams
    addpath ./analyses\test_functions\beams\axial
    addpath ./analyses\test_functions\beams\1el
    addpath ./analyses\test_functions\beams\const_M
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\test_functions
    rmpath ./analyses\test_functions\beams
    rmpath ./analyses\test_functions\beams\axial
    rmpath ./analyses\test_functions\beams\1el
    rmpath ./analyses\test_functions\beams\const_M
end