function interactionLanesTable = generateLanesColumns(interactionTable, roadLanesTable, KnearestLanes)
lanesArrayAll = zeros(size(interactionTable, 1), KnearestLanes * 2);
for i = 1:size(interactionTable, 1)
    Cx = interactionTable.x(i); Cy = interactionTable.y(i);
    validLanesArray = zeros(size(roadLanesTable, 1), 4);
    for j = 1:size(roadLanesTable, 1)
        Ax = roadLanesTable.x0(j); Ay = roadLanesTable.y0(j);
        Bx = roadLanesTable.x1(j); By = roadLanesTable.y1(j);
        [Dx, Dy, DClength, validLane] = orthogonalIntersection(Ax, Ay, Bx, By, Cx, Cy);
        validLanesArray(j, :) = [Dx, Dy, DClength, validLane];
    end
    validLanesArray = validLanesArray(validLanesArray(:, 4) == 1, :);
    validLanesArray = sortrows(validLanesArray, 3);
    
    reshape2Darray = zeros(KnearestLanes, 2);
    if size(validLanesArray, 1) < KnearestLanes
        reshape2Darray(1:size(validLanesArray, 1), :) = validLanesArray(1:end, 1:2);
    else
        reshape2Darray = validLanesArray(1:KnearestLanes, 1:2);
    end
    lanesArrayAll(i, :) = reshape(reshape2Darray', 1, KnearestLanes * 2);
end

tableHeaders = reshape(["laneX", "laneY"]' + (1:KnearestLanes), 1, 2 * KnearestLanes);
interactionLanesTable = array2table(lanesArrayAll, 'VariableNames', cellstr(tableHeaders));

end