cd(fileparts(mfilename('fullpath'))) % Automatically navigate to the current folder
cd ..
cd ..

add_path = true; % Add or remove analysis paths
set_directory; % Sets the directory for FE_routines and GA_toolbox

if(add_path)
    % Add analysis paths
    addpath ./analyses
    addpath ./analyses\axial
    addpath ./analyses\16_05_10_HIAD_PT
    addpath ./analyses\16_05_10_HIAD_PT\els
    addpath ./analyses\16_05_10_HIAD_PT\lookup
    addpath ./analyses\16_05_10_HIAD_PT\plotting
    addpath ./analyses\16_05_10_HIAD_PT\PTopt
    addpath ./analyses\16_05_10_HIAD_PT\PTopt\fmincon
    % addpath ./analysis\16_05_10_HIAD_PT\PTopt\GA
    % addpath ./analysis\16_05_10_HIAD_PT\test
else
    % Remove analysis paths
    rmpath ./analyses
    rmpath ./analyses\axial
    rmpath ./analyses\16_05_10_HIAD_PT
    rmpath ./analyses\16_05_10_HIAD_PT\els
    rmpath ./analyses\16_05_10_HIAD_PT\lookup
    rmpath ./analyses\16_05_10_HIAD_PT\plotting
    rmpath ./analyses\16_05_10_HIAD_PT\PTopt
    rmpath ./analyses\16_05_10_HIAD_PT\PTopt\fmincon
    % rmpath ./analysis\16_05_10_HIAD_PT\PTopt\GA
    % rmpath ./analysis\16_05_10_HIAD_PT\test
end