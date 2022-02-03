cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = true; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if(add_path)
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\axial
    addpath ./analyses\15_09_09_torus_analysis
    addpath ./analyses\15_09_09_torus_analysis\mat_nonlin
    addpath ./analyses\15_09_09_torus_analysis\mat_nonlin\cord_lookup
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\axial
    rmpath ./analyses\15_09_09_torus_analysis
    rmpath ./analyses\15_09_09_torus_analysis\mat_nonlin
    rmpath ./analyses\15_09_09_torus_analysis\mat_nonlin\cord_lookup
end