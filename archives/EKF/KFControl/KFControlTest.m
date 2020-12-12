close all
clear all
clc

% generate basic senario elements
carInitX = 0;
carInitY = 0;
destinationX = 100;
destinationY = 0;
obstacleX = 50;
obstacleY = 0;

deltaT = 1;
N = 100;        % number of time steps

% observation:[x,y,vx,vy,ax,ay,distDestinationX,distDestinationY,distobstacleX,distobstacleY]


% initialize kalman filter
ax = 1; % 0 or 1 or -1
ay = 0; % 0 or 1 or -1
u0 = [ax;ay];    % initialize driving term, 2*1

% TODO: finish this part
sInit = [carInitX;carInitY;0;0;10;0]; % s: [x;y;vx;vy;ax;ay], 6*1

muE = zeros(1, 6); muGamma = zeros(1, 6);
varE = eye(6); varGamma = eye(6);

% 6*2
G = [0.5*deltaT^2,0;
    0,0.5*deltaT^2;
    deltaT,0;
    0,deltaT;
    1,0;
    0,1]; 

% 6*6
A = [1 0 deltaT 0 (deltaT^2)/2 0;
    0 1 0 deltaT 0 (deltaT^2)/2;
    0 0 1 0 deltaT 0;
    0 0 0 1 0 deltaT;
    0 0 0 0 1 0;
    0 0 0 0 0 1]; 

B = eye(6); R = zeros(size(A));

% training kalman filter
% TODO: find o
o = B * sInit + normrnd(0, 1, size(sInit));
s = KFControl(sInit, N, o, muE, muGamma, varE, varGamma, A, B, R, G, u0, obstacleX, obstacleY, destinationX, destinationY);

figure(1)
scatter(s(1,:),s(2,:))
hold on
scatter(obstacleX, obstacleY)




