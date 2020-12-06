function s = KF1(K, sInit, N, o, muE, muGamma, varE, varGamma, Ainit, Binit, Rinit)
    
    for i = 1:K
        s = KF(sInit, N, o, muE, muGamma, varE, varGamma, Ainit, Binit, Rinit);
    end

end