
%% Set Paths

% Need to have a project folder location, where the linked data is, config
% files etc.  

ProjectFolderLocation = ['C:\Users\joshpr\OneDrive - Bill & Melinda Gates Foundation\ResearchProjects\NeurodevelopmentWithMNCH\Projects\',ExperimentName];
githubCodeLocation = pwd;
linkedDataFileLocation = [ProjectFolderLocation,'\Data\'];
configFileLocation = [ProjectFolderLocation,'\Config\'];
outputFileLocation = [ProjectFolderLocation,'\Output\',date,'\'];

addpath(genpath(pwd));
addpath(configFileLocation);
addpath(linkedDataFileLocation)

if ~exist(ProjectFolderLocation, 'dir')
    mkdir(ProjectFolderLocation)
end

if ~exist(linkedDataFileLocation, 'dir')
    mkdir(linkedDataFileLocation)
end

if ~exist(configFileLocation, 'dir')
    mkdir(configFileLocation)
end


if ~exist(outputFileLocation , 'dir')
    mkdir(outputFileLocation )
end


copyfile([githubCodeLocation,'\Config_CRYPTO.m'],configFileLocation)