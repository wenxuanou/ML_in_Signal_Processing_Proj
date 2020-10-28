clc; clear;

roadsLanes = "D:\CMUclasses\18797\project\customDataset\roadsLanes";
CSVfiles = dir(roadsLanes);

for i = 3:length(CSVfiles)
    CSVfileName = CSVfiles(i).name;
    CSVfile = fullfile(roadsLanes, CSVfileName);
    T = readtable(CSVfile);
    x0 = T.x0; y0 = T.y0; x1 = T.x1; y1 = T.y1;
    figure; 
    
    for j = 1:length(x0)
        plot([x0(j) x1(j)], [y0(j), y1(j)]);
        hold on;
    end
    hold off;
    title(strrep(CSVfileName, "_", "\_"));
end