%% striaghtDrive
% Plot a movement of a car along a defined lenght of a road with no 
% obstacle.
%
% parameters:
% roadLegth (some numbers), carSpeed (m/s), carPositions(Array of x, y)
% Usage: straightDrive(50, 20, [0 2; 25 2 ])

function [] = straightDrive(roadLength, carSpeed, carPositions)

    % A driving scenario
    scenario = drivingScenario;

    % Adding a 2 lanes road starting from 0 to road_leghth
    roadCenters = [0 0; roadLength 0];
    road(scenario,roadCenters,'Lanes',lanespec(2));

    % A car
    car = vehicle(scenario,'ClassID',1);

    % Making a trajectory
    trajectory(car,carPositions,carSpeed)

    % Plot the scenario and advance the vehicle
    plot(scenario)

    % How fast are we plotting
    while advance(scenario)
        pause(0.01)
    end

end