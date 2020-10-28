clc; clear;

roadsNodes = "D:\CMUclasses\18797\project\customDataset\roadsNodes";
roadsLanes = "D:\CMUclasses\18797\project\customDataset\roadsLanes";

CSVfiles = dir(roadsNodes);

for i = 3:length(CSVfiles)
    lanesArray = zeros(0, 4);
    CSVfileName = CSVfiles(i).name;
    CSVfile = fullfile(roadsNodes, CSVfileName);
    T = readtable(CSVfile);
    X = T.x; Y = T.y; Cn = T.nodeID; Cw = T.way;
    CwUnique = unique(Cw);
    for j = 1:length(CwUnique)
        eachCw = CwUnique(j);
        rows = Cw == eachCw;
        
        nodes = T(rows, :);
        for k = 1:(size(nodes, 1) - 1)
            node0 = nodes(k, :); node1 = nodes(k + 1, :);
            lanesArray = [lanesArray; node0.x node0.y node1.x node1.y];
        end
    end
    
    lanesTable = table();
    lanesTable.x0 = lanesArray(:, 1); lanesTable.y0 = lanesArray(:, 2);
    lanesTable.x1 = lanesArray(:, 3); lanesTable.y1 = lanesArray(:, 4);
    writetable(lanesTable, fullfile(roadsLanes, CSVfileName));
end