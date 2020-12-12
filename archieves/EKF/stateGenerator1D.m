function [a, v, p] = stateGenerator1D(a, deltaT)
    
    vt = 0; pt = 0;
    v = zeros(size(a)); p = zeros(size(a));
    
    for t = 1:size(a, 2)
        at = a(t);
        vt = vt + at * deltaT;
        pt = pt + vt * deltaT;
        
        v(t) = vt; p(t) = pt;
    end
    
    %a = [0 a]; v = [0 v]; p = [0 p];
    
end