clear; clc;

N = 50; deltaT = 1; K = 10;
a1 = 10 * ones(1, N); a2 = -10 * ones(1, N);
t1 = 0:(N - 1); t2 = 0:(N - 1);

a = [a1 a2];
[a, v, x] = stateGenerator1D(a, deltaT);
sOriginal = [x; v; a]; t = [t1 t2 + N];
B = eye(3); A = [1 deltaT (deltaT^2)/2; 0 1 deltaT; 0 0 1]; R = zeros(size(A));

Nobservations = 2 * N;
o = B * sOriginal + normrnd(0, 1, size(R, 1), Nobservations);
sInit = zeros(size(sOriginal, 1), 1);
muE = zeros(1, 3); muGamma = zeros(1, 3);
varE = eye(3); varGamma = eye(3);
sEstimated = KFK(K, sInit, Nobservations, o, muE, muGamma, varE, varGamma, A, B, R);

stateIndex = 1;
scatter(0:(Nobservations + K - 1), sEstimated(stateIndex, :))
hold on
scatter(t, o(stateIndex,:))
legend('prediction', 'observation')
hold off
