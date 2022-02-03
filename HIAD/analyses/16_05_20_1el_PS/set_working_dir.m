cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = true; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if(add_path)
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\16_05_20_1el_PS
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\16_05_20_1el_PS
end