clear; clc;
Nobservations = 100; N = 1000;
A = eye(2); B = eye(2); R = zeros(2, 2); I = eye(2);
s_ = zeros(Nobservations, 2);

mu = [0 0]; Sigma = [1 0.5; 0.5 2]; R1 = chol(Sigma);
e = repmat(mu, Nobservations, 1) + randn(Nobservations, 2) * R1;
Gamma = repmat(mu, Nobservations, 1) + randn(Nobservations, 2) * R1;

muE = mu; muGamma = mu;
varE = Sigma; varGamma = Sigma;

o_ = repmat(1:Nobservations, 2, 1)' * B + Gamma;

s = s_'; o = o_';
for i = 1:N
    %Predict
    s = A * s + repmat(muE', 1, Nobservations);
    R = varE + A * R * A';
    
    %Update
    K = R * B' * inv(B * R * B' + varGamma);
    s = s + K * (o - B * s - muGamma');
    R = (I - K * B) * R;
end

plot(s(1, :), s(2, :));