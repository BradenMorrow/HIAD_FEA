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
    addpath ./analyses\test_functions\tor_buck_argyris
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\test_functions
    rmpath ./analyses\test_functions\tor_buck_argyris
end