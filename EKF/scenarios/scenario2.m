clear; clc;

ax = [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1];
ay = [0, 0, 0, 0, 0, 1, 1, 0, -1, -1, 0, 0, 0, 0, 0, -1, -1, 0, 1, 1];

N = 10; deltaT = 1; t = 0:(10 * N - 1);
ax1 = 10 * ones(1, N); ax2 = zeros(1, 8 * N); ax3 = -10 * ones(1, N);
ay1 = zeros(1, N); ay2 = 5 * ones(1, N); ay3 = -5 * ones(1, N);
ay4 = zeros(1, 5 * N); ay5 = -5 * ones(1, N); ay6 = 5 * ones(1, N);

ax = [ax1 ax2 ax3]; ay = [ay1 ay2 ay3 ay4 ay5 ay6];
[ax, vx, x] = stateGenerator1D(ax, deltaT);
[ay, vy, y] = stateGenerator1D(ay, deltaT);

sOriginal = [x; y; vx; vy; ax; ay];
A = [1 1 1 1 0.5 0.5; 0 0 1 1 1 1; 0 0 0 0 1 1];

