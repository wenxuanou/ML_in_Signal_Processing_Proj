function [sHat, R ]= estimate(sPrev, o, muE, muGamma, varE, varGamma, A, B, R)
% This fuction estimate a single state
% Takes an single observation and estimate a state
% Returns the predicted state and the confidence level
    
    I = eye(size(A));
    sHat = sPrev;
    s = zeros(size(sPrev, 1), 1);
    
    %Predict
    sT = A * sHat + muE';
    R = varE + A * R * A';

    %Update
    K = R * B' * inv(B * R * B' + varGamma);
    sHat = sT + K * (o - B * sT - muGamma');
    R = (I - K * B) * R;
    
end