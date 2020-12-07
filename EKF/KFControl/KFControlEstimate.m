function [sHat, R]= KFControlEstimate(sPrev, o, muE, muGamma, varE, varGamma, A, B, R, G, u)
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