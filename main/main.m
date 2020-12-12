% 4 States are considered in this file
% Implemented by Owen and Parth, edited by Prasad and Frank

clear all; 
close all;
clc;

% generate basic senario elements
carInitX = 0;
carInitY = 15;
destinationX = 100;
destinationY = 15;
% obstacle location
obstacleX = [20,20,50,50]; %[75, 50];
obstacleY = [23,27,13,17]; %[15, 20];
% obstacle car location
ObstaclecarX1 = 90:-1:-10;  % need 100 points, match to condition in optimalControl2Inline
ObstaclecarY1 = 23 * ones(size(ObstaclecarX1));
% speed of obstacle car
speedObstacleCarX = [ObstaclecarX1(1), ObstaclecarX1(2:end) - ObstaclecarX1(1:end-1)];
speedObstacleCarY = [ObstaclecarY1(1), ObstaclecarY1(2:end) - ObstaclecarY1(1:end-1)];
speedObstacleCar = 10 * sqrt(speedObstacleCarX.^2 + speedObstacleCarY.^2) + 0.000001;

deltaT = 1;
N = 100; % Number of time steps

% initialize kalman filter
ax = 1; % 0 or 1 or -1
ay = 0; % 0 or 1 or -1
uInit = [ax;ay]; % Initialize driving term, 2*1

% initialize state vector
sInit = [carInitX; carInitY; 0; 0]; % s: [x; y; vx; vy]

% noise parameters
muE = zeros(1, 4); muGamma = zeros(1, 4);
varE = eye(4); varGamma = eye(4);

G = [deltaT 0;
    0 deltaT;
    1 0;
    0 1]; 

A = [1 0 deltaT 0;          
     0 1 0 deltaT;
     0 0 1 0;
     0 0 0 1]; 

B = eye(4); R = zeros(size(A));

% training kalman filter
o = B * sInit + normrnd(0, 1, size(sInit));
s = KFControlInline(sInit, N, o, muE, muGamma, varE, varGamma, A, B, R, G, uInit,...
    obstacleX, obstacleY, ObstaclecarX1, ObstaclecarY1, destinationX, destinationY);

figure(1)
scatter(s(1,:),s(2,:))
hold on
scatter(obstacleX, obstacleY)
ylim([10 30])

positions = s(1:2, 1:end)';
speedEgo = sqrt(s(3,:).^2 + s(4,:).^2);
speedEgo = 10 * speedEgo';

vehicleSimulatorSpeed(speedEgo, positions, obstacleX, obstacleY, speedObstacleCar, ObstaclecarX1, ObstaclecarY1);



