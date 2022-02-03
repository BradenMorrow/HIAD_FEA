cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = true; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if(add_path)
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\16_03_01_HIAD
    addpath ./analyses\16_03_01_HIAD\els
    addpath ./analyses\16_03_01_HIAD\lookup
    addpath ./analyses\16_03_01_HIAD\plotting
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\16_03_01_HIAD
    rmpath ./analyses\16_03_01_HIAD\els
    rmpath ./analyses\16_03_01_HIAD\lookup
    rmpath ./analyses\16_03_01_HIAD\plotting
end