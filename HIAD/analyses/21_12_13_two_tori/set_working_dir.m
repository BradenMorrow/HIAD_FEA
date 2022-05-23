cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = 0; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if add_path
    % Add analysis paths
    addpath(genpath('analyses/21_12_13_two_tori'))

else
    % Remove analysis paths
    rmpath(genpath('analyses/21_12_13_two_tori'))
end
