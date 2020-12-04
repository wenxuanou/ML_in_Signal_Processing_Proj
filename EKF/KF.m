function s = KF(sInit, N, o, muE, muGamma, varE, varGamma, Ainit, Binit, Rinit)
    A = Ainit; B = Binit; R = Rinit;
    I = eye(size(A)); sHat = sInit;
    s = zeros(size(sInit, 1), N);
    
    for i = 1:N
        %Predict
        sT = A * sHat + muE';
        R = varE + A * R * A';

        %Update
        K = R * B' * inv(B * R * B' + varGamma);
        sHat = sT + K * (o(:, i) - B * sT - muGamma');
        R = (I - K * B) * R;
        
        s(:, i) = sT;
    end

end