clear; clc;

N = 50; deltaT = 1;
a1 = 10 * ones(1, N); a2 = -10 * ones(1, N);
t1 = 0:(N - 1); t2 = 0:(N - 1);

a = [a1 a2];
[a, v, x] = stateGenerator1D(a, deltaT);
sOriginal = [x; v; a]; t = [t1 t2 + N];
B = eye(3); A = eye(3); R = zeros(size(A)); I = eye(3);
A = [1 1 0.5; 0 1 1; 0 0 1];

Nobservations = 2 * N;
o = B * sOriginal + normrnd(0, 1, size(R, 1), Nobservations);
sInit = zeros(size(sOriginal, 1), 1);
muE = zeros(1, 3); muGamma = zeros(1, 3);
varE = eye(3); varGamma = eye(3);
sEstimated = KF(sInit, Nobservations, o, muE, muGamma, varE, varGamma, A, B, R);

stateIndex = 2;
scatter(t, o(stateIndex,:))
hold on
scatter(t, sEstimated(stateIndex, :))
legend('observation', 'prediction')
hold off