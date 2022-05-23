file_loc = fileparts(mfilename('fullpath'));
cd(file_loc) % Automatically navigate to the current folder
cd ..
cd ..

add_path = 0; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if add_path
    % Add analysis paths
    addpath(genpath(file_loc))

else
    % Remove analysis paths
    rmpath(genpath(file_loc))
end
