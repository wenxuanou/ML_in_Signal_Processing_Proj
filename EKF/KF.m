function s = KF(sInit, N, Nobservations, o, muE, muGamma, varE, varGamma, Ainit, Binit, Rinit)
    A = Ainit; B = Binit; R = Rinit;
    I = eye(size(A)); s = sInit;

    for i = 1:N
        %Predict
        s = A * s + repmat(muE', 1, Nobservations);
        R = varE + A * R * A';

        %Update
        K = R * B' * inv(B * R * B' + varGamma);
        s = s + K * (o - B * s - muGamma');
        R = (I - K * B) * R;
    end

end