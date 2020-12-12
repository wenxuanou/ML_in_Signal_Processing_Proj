function s = KFControlInline(sInit, N, o, muE, muGamma, varE, varGamma, A, B, R, G, uInit,...
    obstacleX, obstacleY, ObstaclecarX, ObstaclecarY, destinationX, destinationY)
    % kalman filter main loop with control
    % implemented by Owen and Parth, edited by Frank

    s = zeros(size(sInit, 1), N);
    s(:, 1) = sInit; 

    u = uInit;
    for i = 2:N % Iterate over all observations
        
        u = optimalControl2Inline(s(:, i-1),o,muE, muGamma, varE, varGamma, A, B, R, G, u,...
            obstacleX, obstacleY, ObstaclecarX, ObstaclecarY, destinationX, destinationY, i);           % predict multiple step for optimal u

        disp(u)
        % Estimate the state for a given observation and confidence level
        [estS, R ]= KFControlEstimateInline(s(:, i-1), o, muE, muGamma, varE, varGamma, A, B, R, G, u);    % move onstep forward
        o  = B * estS;% + normrnd(0, 1, size(sInit));
        s(:, i) = estS;

    end

end