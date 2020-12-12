function s = KFControlLookAhead(sInit, N, o, muE, muGamma, varE, varGamma, Ainit, Binit, Rinit)
    % This function looks forward N steps, from a specic observation and state.

    A = Ainit;  % state transition matrix
    B = Binit;  % observation matrix
    R = Rinit;  % state variance
    
    s = zeros(size(sInit, 1), N);
    s(:, 1) = sInit;

    oBar = zeros(size(sInit, 1), N);
    % Obar starts with first observation
    oBar(:, 1) = o(:, 1);
    
     for i = 1:N
         
         % What is the previous state?
         prev  = 1;
         if i > 1
             prev = i - 1;
         end
         
         % Estimate the state for a given observation and confidence level
         [estS, R ]= estimate(s(:, prev), oBar(:, prev), muE, muGamma, varE, varGamma, A, B, R);
         
         % Update state estimates and observation estimates
         s(:, i) = estS;

         % We need to define B, at the moment we use A.
         oBar(:, i) = A * estS + muGamma';
    
     end

end