function s = KF(sInit, N, o, muE, muGamma, varE, varGamma, Ainit, Binit, Rinit)
    A = Ainit;
    B = Binit; 
    R = Rinit;
    s = zeros(size(sInit, 1), N);
    s(:, 1) = sInit; 
    
     for i = 1:N
         
         % What is the previous state?
         prev  = 1;
         if i > 1
             prev = i - 1;
         end
         
         % Estimate the state for a given observation and confidence level
         [estS, R ]= estimate(s(:, prev), o(:, i), muE, muGamma, varE, varGamma, A, B, R);
         
         s(:, i) = estS;
    
     end

end