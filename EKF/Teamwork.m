clear; clc;
%Generate noise first
mu = [0 0 0]; Sigma = 10 * eye(3); Nobservations = 100;
[e, Gamma] = generateNoise(mu, Sigma, Nobservations);

%define observations
N = Nobservations / 2;

%define time
t1 = 0:(N - 1); 
t2 = 0:(N - 1);

%define acceleration
a1 = ones(1, N); 
a2 = -ones(1, N);

%define velocity
v1 = a1 .* t1; 
v2 = v1(end) + a2 .* t2;

%define position
x1 = (0.5 * a1) .* (t1 .^ 2); 
x2 = x1(end) + v1(end) .* t2 + (0.5 * a2) .* (t2 .^ 2);

%Bring it all together
x = [x1 x2]; v = [v1 v2]; a = [a1 a2];
s = [x; v; a]; t = [t1 t2 + N];
o = B * s + Gamma'; %Observations

B = eye(3); A = eye(3); R = zeros(size(A)); I = eye(3);

s_hat = [0; 0; 0]; %initial state
outputPos = zeros(100,1); %store output
R_hat = zeros(3,3);

for i = 1:100
    s_t = A*s_hat + 2*rand([3,1])-1; %error between -1 to 1
    R_t = 2*rand([3,3])-1 + A*R_hat*A';
    K = R_t * B' * inv(B * R_t * B' + 2*rand([3,3])-1);
    s_hat = s_t + K * (o(:,i) - B * s_t - (2*rand([3,3])-1)');
    R_hat = (I - K * B) * R_t;
    
    outputPos(i) = s_t(1);
end

scatter(t, o(1,:))
hold on
scatter(t, outputPos)
legend('observation','prediction')
hold off