cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = true; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if(add_path)
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\15_08_31_beams
    addpath ./analyses\15_08_31_beams\1el
    addpath ./analyses\15_08_31_beams\const_M
    addpath ./analyses\15_08_31_beams\plotting
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\15_08_31_beams
    rmpath ./analyses\15_08_31_beams\1el
    rmpath ./analyses\15_08_31_beams\const_M
    rmpath ./analyses\15_08_31_beams\plotting
end