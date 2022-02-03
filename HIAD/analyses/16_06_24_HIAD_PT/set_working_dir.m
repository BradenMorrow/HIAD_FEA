cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = true; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if add_path
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\16_06_24_HIAD_PT
    addpath ./analyses\16_06_24_HIAD_PT\els
    addpath ./analyses\16_06_24_HIAD_PT\lookup
    addpath ./analyses\16_06_24_HIAD_PT\plotting
    addpath ./analyses\16_06_24_HIAD_PT\PTopt
    addpath ./analyses\16_06_24_HIAD_PT\PTopt\pre_load
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\16_06_24_HIAD_PT
    rmpath ./analyses\16_06_24_HIAD_PT\els
    rmpath ./analyses\16_06_24_HIAD_PT\lookup
    rmpath ./analyses\16_06_24_HIAD_PT\plotting
    rmpath ./analyses\16_06_24_HIAD_PT\PTopt
    rmpath ./analyses\16_06_24_HIAD_PT\PTopt\pre_load
end
