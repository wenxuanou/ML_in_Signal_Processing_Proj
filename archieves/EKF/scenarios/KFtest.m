clear; clc;
Nobservations = 100;
Ainit = eye(2); Binit = eye(2); Rinit = zeros(2, 2);
s_ = zeros(1, 2);

mu = [0 0]; Sigma = 10 * eye(2); R1 = chol(Sigma);
e = repmat(mu, Nobservations, 1) + randn(Nobservations, 2) * R1;
Gamma = repmat(mu, Nobservations, 1) + randn(Nobservations, 2) * R1;

muE = mu; muGamma = mu;
varE = Sigma; varGamma = Sigma;

o_ = repmat(1:Nobservations, 2, 1)' * Binit + Gamma;

sInit = s_'; o = o_';
s = KF(sInit, Nobservations, o, muE, muGamma, varE, varGamma, Ainit, Binit, Rinit);
plot(s(1, :), s(2, :));