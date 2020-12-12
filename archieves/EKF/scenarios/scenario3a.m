clear; clc;

N = 25; deltaT = 1; t = 0:(4 * N - 1);
ax1 = 10 * ones(1, N); ax2 = zeros(1, 2 * N); ax3 = -10 * ones(1, N);
ax = [ax1 ax2 ax3]; ay = zeros(1, 4 * N);

[ax, vx, x] = stateGenerator1D(ax, deltaT);
[ay, vy, y] = stateGenerator1D(ay, deltaT);
xd = x(end) - x; yd = zeros(size(x));

sOriginal = [x; y; vx; vy; ax; ay; xd; yd];
A = [1 0 deltaT 0 (deltaT^2)/2 0 0 0;
    0 1 0 deltaT 0 (deltaT^2)/2 0 0;
    0 0 1 0 deltaT 0 0 0;
    0 0 0 1 0 deltaT 0 0;
    0 0 0 0 1 0 0 0;
    0 0 0 0 0 1 0 0;
    0 0 -deltaT 0 -(deltaT^2)/2 0 1 0;
    0 0 0 -deltaT 0 -(deltaT^2)/2 0 1];

B = eye(8); R = zeros(size(A));

Nobservations = 4 * N;
o = B * sOriginal + normrnd(0, 1, size(R, 1), Nobservations);
sInit = zeros(size(sOriginal, 1), 1);
muE = zeros(1, 8); muGamma = zeros(1, 8);
varE = eye(8); varGamma = eye(8);

sEstimated = KF(sInit, Nobservations, o, muE, muGamma, varE, varGamma, A, B, R);

stateIndex = 8;
scatter(t, o(stateIndex,:))
hold on
scatter(t, sEstimated(stateIndex, :))
legend('observation', 'prediction')
hold off