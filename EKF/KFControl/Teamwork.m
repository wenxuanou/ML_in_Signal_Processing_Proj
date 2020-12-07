clear; clc;

% generate basic senario elements
carInitX = 0;
carInitY = 15;
destinationX = 100;
destinationY = 15;
obstacleX = 50;
obstacleY = 15;

deltaT = 1;
N = 100;        % number of time steps

% initialize kalman filter
ax = 1; % 0 or 1 or -1
ay = 0; % 0 or 1 or -1
u0 = [ax;ay];    % initialize driving term, 2*1

sInit = [carInitX;carInitY;0;0;ax;ay]; % s: [x;y;vx;vy;ax;ay]

muE = zeros(1, 6); muGamma = zeros(1, 6);
varE = eye(6); varGamma = eye(6);

G = [0.5*deltaT^2,0;
    0,0.5*deltaT^2;
    deltaT,0;
    0,deltaT;
    1,0;
    0,1]; 

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
