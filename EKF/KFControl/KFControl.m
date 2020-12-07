function s = KFControl(sInit, N, o, muE, muGamma, varE, varGamma, A, B, R, G, u0, obstacleX, obstacleY, destinationX, destinationY)
    s = zeros(size(sInit, 1), N);
    s(:, 1) = sInit; 

    u = u0;
    for i = 2:N     % iterate all observations

        % select the best driving term
%         u = optimalControl(s(:, i-1),o,muE, muGamma, varE, varGamma, A, B, R, G, u, obstacleX, obstacleY, destinationX, destinationY);           % predict multiple step for optimal u
        u = optimalControl2(s(:, i-1),o,muE, muGamma, varE, varGamma, A, B, R, G, u, obstacleX, obstacleY, destinationX, destinationY);           % predict multiple step for optimal u

        disp(u)
        % Estimate the state for a given observation and confidence level
        [estS, R ]= KFControlEstimate(s(:, i-1), o, muE, muGamma, varE, varGamma, A, B, R, G, u);    % move onstep forward
        o  = B * estS + normrnd(0, 1, size(sInit));
        s(:, i) = estS;

    end

end