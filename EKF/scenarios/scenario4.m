clear; clc;

Npaths = 20; K = 10;
%Predict K next values in KF
muA = 0; sigmaA = 1; deltaT = 1;
simulationEnd = 100;

for sI = 1:simulationEnd
    axrnd = normrnd(muA, sigmaA, K, Npaths);
    ayrnd = normrnd(muA, sigmaA, K, Npaths);
    ax = double(axrnd > 0.5 * sigmaA) - double(axrnd < -0.5 * sigmaA);
    ay = double(ayrnd > 0.5 * sigmaA) - double(ayrnd < -0.5 * sigmaA);
    
    [ax, vx, x] = stateGenerator1D(ax, deltaT);
    [ay, vy, y] = stateGenerator1D(ay, deltaT);
    
end