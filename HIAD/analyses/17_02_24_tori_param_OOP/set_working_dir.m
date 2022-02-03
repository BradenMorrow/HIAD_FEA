cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = true; % Add or remove analysis paths
set_directory;

if(add_path)
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\17_02_24_tori_param_OOP
    addpath ./analyses\17_02_24_tori_param_OOP\els
    addpath ./analyses\17_02_24_tori_param_OOP\lookup
    addpath ./analyses\17_02_24_tori_param_OOP\model
    addpath ./analyses\17_02_24_tori_param_OOP\plotting
    addpath ./analyses\17_02_24_tori_param_OOP\test_fun
    addpath ./analyses\17_02_24_tori_param_OOP\test_fun\test_lin_ax
    addpath ./analyses\17_02_24_tori_param_OOP\torus
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\17_02_24_tori_param_OOP
    rmpath ./analyses\17_02_24_tori_param_OOP\els
    rmpath ./analyses\17_02_24_tori_param_OOP\lookup
    rmpath ./analyses\17_02_24_tori_param_OOP\model
    rmpath ./analyses\17_02_24_tori_param_OOP\plotting
    rmpath ./analyses\17_02_24_tori_param_OOP\test_fun
    rmpath ./analyses\17_02_24_tori_param_OOP\test_fun\test_lin_ax
    rmpath ./analyses\17_02_24_tori_param_OOP\torus
end
