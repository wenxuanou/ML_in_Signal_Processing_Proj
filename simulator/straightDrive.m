%% striaghtDrive
% Plot a movement of a car along a defined lenght of a road with no 
% obstacle.
%
% parameters:
% road_legth (some numbers), car_speed (m/s), car_positions(2 dimension * N )
% Usage: straightDrive(50, 20, [0 2; 25 2 ])

function [] = straightDrive(road_length, car_speed, car_positions)

    % A driving scenario
    scenario = drivingScenario;

    % Adding a 2 lanes road starting from 0 to road_leghth
    roadCenters = [0 0; road_length 0];
    road(scenario,roadCenters,'Lanes',lanespec(2));

    % A car
    v = vehicle(scenario,'ClassID',1);

    % Making a trajectory
    trajectory(v,car_positions,car_speed)

    % Plot the scenario and advance the vehicle
    plot(scenario)

    % How fast are we plotting
    while advance(scenario)
        pause(0.01)
    end

end