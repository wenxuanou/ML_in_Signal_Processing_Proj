clear; clc;

roadCSVfolder = "D:\CMUclasses\18797\project\customDataset\roadsNodes";
CSVfiles = dir(roadCSVfolder);

for i = 3:length(CSVfiles)
    CSVfileName = CSVfiles(i).name;
    CSVfile = fullfile(roadCSVfolder, CSVfileName);
    T = readtable(CSVfile);
    X = T.x; Y = T.y; Cn = T.nodeID; Cw = T.way;
    figure; 
    scatter(X, Y);
    title(strrep(CSVfileName, "_", "\_"));
    
    for j = 1:length(Cn)
        text(X(j), Y(j), strcat(num2str(Cw(j)), "\_", num2str(Cn(j))));
    end
end