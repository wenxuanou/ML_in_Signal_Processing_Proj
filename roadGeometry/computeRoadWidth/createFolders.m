function createFolders(outputFolder, scenarios)
for i = 1:length(scenarios)
    mkdir(fullfile(outputFolder, scenarios(i)));
    mkdir(fullfile(outputFolder, scenarios(i), "train"));
    mkdir(fullfile(outputFolder, scenarios(i), "val"));
end
end