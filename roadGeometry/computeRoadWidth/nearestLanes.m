clear; clc;

KnearestLanes = 4;
interactionDatasetFolder = "D:\CMUclasses\18797\project\interactionDataset\interaction-dataset\recorded_trackfiles";
scenariosFolder = "D:\CMUclasses\18797\project\interactionDataset\INTERACTION-Dataset-DR-v1_1\recorded_trackfiles"; 
outputFolder = "D:\CMUclasses\18797\project\customDataset\orthogonalIntersection";
roadLanesFolder = "D:\CMUclasses\18797\project\customDataset\roadsLanes";

[inputFiles, scenarios] = getFiles(interactionDatasetFolder, scenariosFolder);
%createFolders(outputFolder, scenarios);

for i = 1:length(scenarios)
    roadCSVfilename = fullfile(roadLanesFolder, strcat(scenarios(i), ".csv"));
end