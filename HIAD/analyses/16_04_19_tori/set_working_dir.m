cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = false; % Add or remove analysis paths
set_directory;

if(add_path)
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\16_04_19_tori
    addpath ./analyses\16_04_19_tori\els
    addpath ./analyses\16_04_19_tori\lookup
    addpath ./analyses\16_04_19_tori\model
    addpath ./analyses\16_04_19_tori\plotting
    addpath ./analyses\16_04_19_tori\test_fun
    addpath ./analyses\16_04_19_tori\test_fun\test_lin_ax
    addpath ./analyses\16_04_19_tori\torus
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\16_04_19_tori
    rmpath ./analyses\16_04_19_tori\els
    rmpath ./analyses\16_04_19_tori\lookup
    rmpath ./analyses\16_04_19_tori\model
    rmpath ./analyses\16_04_19_tori\plotting
    rmpath ./analyses\16_04_19_tori\test_fun
    rmpath ./analyses\16_04_19_tori\test_fun\test_lin_ax
    rmpath ./analyses\16_04_19_tori\torus
end
