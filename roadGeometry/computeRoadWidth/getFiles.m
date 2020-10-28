function [inputFiles, scenarios] = getFiles(interactionDatasetFolder, scenariosFolder)
scenariosStruct = dir(scenariosFolder);

scenarios = [];
for i = 3:length(scenariosStruct)
    scenarios = [scenarios; convertCharsToStrings(scenariosStruct(i).name)];
end

inputFiles = table();
inputFiles_ = []; trainVal = []; scenariosFull = [];
for i = 1:length(scenarios)
    trainFiles = dir(fullfile(interactionDatasetFolder, scenarios(i), "train"));
    for j = 3:length(trainFiles)
        if trainFiles(j).isdir == 0
            inputFile = fullfile(trainFiles(j).folder, trainFiles(j).name);
            inputFiles_ = [inputFiles_; convertCharsToStrings(inputFile)];
            scenariosFull = [scenariosFull; scenarios(i)];
            trainVal = [trainVal; "train"];
        end
    end
    
    valFiles = dir(fullfile(interactionDatasetFolder, scenarios(i), "val"));
    for j = 3:length(valFiles)
        if valFiles(j).isdir == 0
            inputFile = fullfile(valFiles(j).folder, valFiles(j).name);
            inputFiles_ = [inputFiles_; convertCharsToStrings(inputFile)];
            scenariosFull = [scenariosFull; scenarios(i)];
            trainVal = [trainVal; "val"];
        end
    end
end

inputFiles.files = inputFiles_;
inputFiles.scenarios = scenariosFull;
inputFiles.trainVal = trainVal;
end