clear; clc;

roadCSVfolder = "D:\CMUclasses\18797\project\customDataset\roadCSV";
CSVfiles = dir(roadCSVfolder);

for i = 3:length(CSVfiles)
    CSVfileName = CSVfiles(i).name;
    CSVfile = fullfile(roadCSVfolder, CSVfileName);
    T = readtable(CSVfile);
    X = T.x; Y = T.y;
    figure; scatter(X, Y); title(CSVfileName);
end