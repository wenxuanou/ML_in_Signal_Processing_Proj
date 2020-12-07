function u_opt = optimalControl2(si,oi,muE, muGamma, varE, varGamma, A, B, R, G, u, obsticalX, obsticalY, destinationX, destinationY)
    ux = [0 0 0 0; 1 1 1 1; 0 0 0 0; -1 -1 -1 -1; 0 0 0 0; 1 1 -1 -1; 0 0 0 0; -1 -1 1 1; 0 0 0 0];
    uy = [0 0 0 0; 0 0 0 0; 1 1 1 1; 0 0 0 0; -1 -1 -1 -1; 0 0 0 0; 1 1 -1 -1; 0 0 0 0; -1 -1 1 1];

     minCost = Inf;
    u_opt = u;
    for i = 1:size(ux, 1)
        for j = 1:size(ux,2)
            u = [ux(i,j);uy(i,j)];
           
            estS = si;
            o_pred = oi;
            cost = 0;
            [estS,R]= KFControlEstimate(estS, o_pred, muE, muGamma, varE, varGamma, A, B, R, G, u);
            o_pred = B * estS + normrnd(0, 1, size(oi));   % Number of state variable * 1

            % observation:[x,y,vx,vy,ax,ay]
            % accumulate cost alone the look ahead states
            cost = cost +...
                sqrt((o_pred(1) - destinationX)^2 + (o_pred(2) - destinationY)^2) +... 
                1/(sqrt((o_pred(1) - obsticalX)^2 + (o_pred(2) - obsticalY)^2));
            
            if cost < minCost
                u_opt = u;
                minCost = cost;
            end
            
        end
    end
    
    disp(minCost)
end