%This file consists of 2 cars and 'n' obstacles
clear all; 
close all;
clc;

addpath '/Users/owenou/Documents/MATLAB/cmu/18797 ml in signal processing/ML_in_Signal_Processing_Proj/simulator'

% generate basic senario elements
carInitX = 0;
carInitY = 15;
destinationX = 100;
destinationY = 15;
obstacleX = [0]; %[75, 50];
obstacleY = [0]; %[15, 20];

ObstaclecarX1 = 110:-2:10;  % need 100 points, match to condition in optimalControl2Inline
ObstaclecarX1 = [ObstaclecarX1, 10 * ones(1,50)];
ObstaclecarY1 = 20 * ones(size(ObstaclecarX1));

ObstaclecarX2 = 10:0.5:100;  % need 100 points, match to condition in optimalControl2Inline
ObstaclecarX2 = [ObstaclecarX2, 105*ones(1,20)];
ObstaclecarY2 = 15 * ones(size(ObstaclecarX2));

deltaT = 1;
N = 100; % Number of time steps

% initialize kalman filter
ax = 1; % 0 or 1 or -1
ay = 0; % 0 or 1 or -1
uInit = [ax;ay]; % Initialize driving term, 2*1

sInit = [carInitX; carInitY; 0; 0; ax; ay]; % s: [x; y; vx; vy; ax; ay]

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
o = B * sInit + normrnd(0, 1, size(sInit));
s = KFControlInline(sInit, N, o, muE, muGamma, varE, varGamma, A, B, R, G, uInit,...
    obstacleX, obstacleY, ObstaclecarX1, ObstaclecarY1, ObstaclecarX2, ObstaclecarY2, destinationX, destinationY);

figure(1)
scatter(s(1,:),s(2,:))
hold on
scatter(obstacleX, obstacleY)
ylim([10 30])

positions = s(1:2, 1:end)';

Prasad2cars(20, positions, obstacleX, obstacleY, ObstaclecarX1, ObstaclecarY1, ObstaclecarX2, ObstaclecarY2);

function s = KFControlInline(sInit, N, o, muE, muGamma, varE, varGamma, A, B, R, G, uInit,...
    obstacleX, obstacleY, ObstaclecarX1, ObstaclecarY1, ObstaclecarX2, ObstaclecarY2, destinationX, destinationY)

    s = zeros(size(sInit, 1), N);
    s(:, 1) = sInit; 

    u = uInit;
    for i = 2:N % Iterate over all observations
        
        u = optimalControl2Inline(s(:, i-1),o,muE, muGamma, varE, varGamma, A, B, R, G, u,...
            obstacleX, obstacleY, ObstaclecarX1, ObstaclecarY1, ObstaclecarX2, ObstaclecarY2, destinationX, destinationY, i);           % predict multiple step for optimal u

        disp(u)
        % Estimate the state for a given observation and confidence level
        [estS, R ]= KFControlEstimateInline(s(:, i-1), o, muE, muGamma, varE, varGamma, A, B, R, G, u);    % move onstep forward
        o  = B * estS;% + normrnd(0, 1, size(sInit));
        s(:, i) = estS;

    end

end

function [sHat, R]= KFControlEstimateInline(sPrev, o, muE, muGamma, varE, varGamma, A, B, R, G, u)
% This fuction estimate a single state
% Takes an single observation and estimate a state
% Returns the predicted state and the confidence level
    
    I = eye(size(A));
    sHat = sPrev;
    
    %Predict
    % sT: [x;y;vx;vy;ax;ay], 6*1
    sT = A * sHat + G * u + muE';   % st[N*1] = At[N*N] * st-1[N*1] + G[N*2] * u[2*1] + epsilon
    R = varE + A * R * A';

    %Update
    K = R * B' * inv(B * R * B' + varGamma);
    sHat = sT + K * (o - B * sT - muGamma');
    R = (I - K * B) * R;
    
end

function u_opt = optimalControl2Inline(si,oi,muE, muGamma, varE, varGamma, A, B, R, G, u,...
    obstacleX, obstacleY, ObstaclecarX1, ObstaclecarY1, ObstaclecarX2, ObstaclecarY2, destinationX, destinationY, iteration)

    ux = 0.75 * [0 0 0 0; 1 1 1 1; 0 0 0 0; -1 -1 -1 -1; 0 0 0 0; 1 1 -1 -1; 0 0 0 0; -1 -1 1 1; 0 0 0 0];
    uy =  0.75 * [0 0 0 0; 0 0 0 0; 1 1 1 1; 0 0 0 0; -1 -1 -1 -1; 0 0 0 0; 1 1 -1 -1; 0 0 0 0; -1 -1 1 1];
    
    muGaussianCost = 0; sigmaGaussianCost = 2.5; penalty = 10; 
    carPenalty = 10; carsigmaCost = 1.5;
    roadBoundary1 = 10; roadBoundary2 = 30; roadPenalty = 20; roadsigmaCost = 1;
    
    minCost = Inf;
    u_opt = u;
    for i = 1:size(ux, 1)
        for j = 1:size(ux,2)
            u = [ux(i,j);uy(i,j)];
           
            estS = si;
            o_pred = oi;
            [estS,R]= KFControlEstimate(estS, o_pred, muE, muGamma, varE, varGamma, A, B, R, G, u);
            o_pred = B * estS;% + normrnd(0, 1, size(oi));   % Number of state variable * 1
            
            if iteration + j - 1 > 100
                carPositionX1 = ObstaclecarX1(end-1);
                carPositionX2 = ObstaclecarX2(end-1);
            else
                carPositionX1 = ObstaclecarX1(iteration + j - 1);
                carPositionX2 = ObstaclecarX2(iteration + j - 1);
            end
            
            carPositionY1 = ObstaclecarY1(iteration);
            carPositionY2 = ObstaclecarY2(iteration);
            
            cost = sqrt((o_pred(1) - destinationX)^2 + (o_pred(2) - destinationY)^2)+...
                roadPenalty*(normpdf(o_pred(2) - roadBoundary1, muGaussianCost, roadsigmaCost) / normpdf(0, muGaussianCost, roadsigmaCost)) + ...
                roadPenalty*(normpdf(o_pred(2) - roadBoundary2, muGaussianCost, roadsigmaCost) / normpdf(0, muGaussianCost, roadsigmaCost)) + ...
                ((carPenalty*normpdf(o_pred(1) - carPositionX1,muGaussianCost, carsigmaCost) / normpdf(0, muGaussianCost, carsigmaCost)) * ...
                (carPenalty*normpdf(o_pred(2) - carPositionY1,muGaussianCost, carsigmaCost) / normpdf(0, muGaussianCost, carsigmaCost))) + ...
                 ((carPenalty*normpdf(o_pred(1) - carPositionX2,muGaussianCost, carsigmaCost) / normpdf(0, muGaussianCost, carsigmaCost)) * ...
                (carPenalty*normpdf(o_pred(2) - carPositionY2,muGaussianCost, carsigmaCost) / normpdf(0, muGaussianCost, carsigmaCost)));
       
            for obstacleI = 1:size(obstacleX, 2)
                obstacleXi = obstacleX(obstacleI); obstacleYi = obstacleY(obstacleI);
                cost = cost + ...
                ((penalty*normpdf(o_pred(1) - obstacleXi, muGaussianCost, sigmaGaussianCost) / normpdf(0, muGaussianCost, sigmaGaussianCost)) * ...
                (penalty*normpdf(o_pred(2) - obstacleYi, muGaussianCost, sigmaGaussianCost) / normpdf(0, muGaussianCost, sigmaGaussianCost)));
            end

            if cost < minCost
                u_opt = u;
                minCost = cost;
            end
            disp(cost)
            disp(u)
        end
    end
    disp('minCost:')
    disp(minCost)
    disp(u_opt)
end

% s(:, i-1),o,muE, muGamma, varE, varGamma, A, B, R, G, u,...
%             obstacleX, obstacleY, ObstaclecarX1, ObstaclecarY1, ObstaclecarX2, ObstaclecarY2, destinationX, destinationY, i
% si,oi,muE, muGamma, varE, varGamma, A, B, R, G, u,...
%     obstacleX, obstacleY, ObstaclecarX1, ObstaclecarY1, ObstaclecarX2, ObstaclecarY2, destinationX, destinationY, iteration)