clear; clc;
Nobservations = 100; N = 1000;
A = eye(2); B = eye(2); R = zeros(2, 2); s = zeros(2, Nobservations);

mu = [0 0]; Sigma = [1 0.5; 0.5 2]; R1 = chol(Sigma);
e = repmat(mu, Nobservations, 1) + randn(Nobservations, 2) * R1;
Gamma = repmat(mu, Nobservations, 1) + randn(Nobservations, 2) * R1;

muE = mu; muGamma = mu;
varE = Sigma; varGamma = Sigma;

o = repmat(1:Nobservations, 2, 1)' * B + Gamma;

