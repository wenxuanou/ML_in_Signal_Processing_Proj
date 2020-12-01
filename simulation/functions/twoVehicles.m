function [scenario, egoVehicle] = twoVehicles()
% Generated on: 01-Dec-2020 02:27:08

% Construct a drivingScenario object.
scenario = drivingScenario('SampleTime', 0.04);

% Add all road segments
roadCenters = [150 24.2 0;
    54 24.2 0];
laneSpecification = lanespec([2 2]);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [105 75 0;
    105 -20 0];
laneSpecification = lanespec([2 2]);
road(scenario, roadCenters, 'Lanes', laneSpecification);

% Add the ego vehicle
ego_kf = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [56 19 0]);

% I want us to generate this by calling KF
% How to do this?
waypoints = [56 19 0;
    135 19 0];
speed = 10;
trajectory(ego_kf, waypoints, speed);

% Add the non-ego actors
actor_vehicle = vehicle(scenario, ...
    'ClassID', 2, ...
    'Length', 8.2, ...
    'Width', 2.5, ...
    'Height', 3.5, ...
    'Position', [56 23.6 0]);
waypoints = [56 23.6 0;
    145.3 23.8 0];
speed = 20;
trajectory(actor_vehicle, waypoints, speed);

