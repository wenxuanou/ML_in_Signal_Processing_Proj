function s = KFControl(sInit, N, o, muE, muGamma, varE, varGamma, A, B, R, G, u, obstacleLoc)
    s = zeros(size(sInit, 1), N);
    s(:, 1) = sInit; 
    
     for i = 1:N     % iterate all observations
         
         % What is the previous state?
         prev  = 1;
         if i > 1
             prev = i - 1;
         end
         
         % select the best driving term
         u = optimalControl(s(:, prev),o(:, i),muE, muGamma, varE, varGamma, A, B, R, G, u, obstacleLoc);           % predict multiple step for optimal u
         % Estimate the state for a given observation and confidence level
         [estS, R ]= KFControlEstimate(s(:, prev), o(:, i), muE, muGamma, varE, varGamma, A, B, R, G, u);    % move onstep forward
         
         s(:, i) = estS;
    
     end

end