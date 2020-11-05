clear; clc;

KnearestLanes = 4;
interactionDatasetFolder = "D:\CMUclasses\18797\project\interactionDataset\interaction-dataset\recorded_trackfiles";
scenariosFolder = "D:\CMUclasses\18797\project\interactionDataset\INTERACTION-Dataset-DR-v1_1\recorded_trackfiles"; 
outputFolder = "D:\CMUclasses\18797\project\customDataset\orthogonalIntersection";
roadLanesFolder = "D:\CMUclasses\18797\project\customDataset\roadsLanes";

[inputFiles, scenarios] = getFiles(interactionDatasetFolder, scenariosFolder);
createFolders(outputFolder, scenarios);

tic;
for i = 1:size(inputFiles, 1)
    display(i);
    roadLanesCSVfilename = fullfile(roadLanesFolder, strcat(inputFiles.scenario(i), ".csv"));
    roadLanesTable = readtable(roadLanesCSVfilename);
    interactionTable = readtable(inputFiles.file(i));
    
    interactionLanesTable = generateLanesColumns(interactionTable, roadLanesTable, KnearestLanes);
    [~, outputCSVfilename] = fileparts(inputFiles.file(i));
    outputCSVpath = fullfile(outputFolder, inputFiles.scenario(i), inputFiles.trainValFolder(i), strcat(outputCSVfilename, ".csv"));
    writetable([interactionTable interactionLanesTable], outputCSVpath);
end
toc;