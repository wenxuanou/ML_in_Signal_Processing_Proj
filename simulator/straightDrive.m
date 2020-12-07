function [] = straightDrive(road_length, car_speed, car_positions)

% A simple scenario
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

% if we want it to appear in the drivingScenario
end