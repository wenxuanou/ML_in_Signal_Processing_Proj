function u_opt = optimalControl(si,oi,muE, muGamma, varE, varGamma, A, B, R, G, u)
    % ax = 0 or 1 or -1     increase or decrease in acceleration
    % ay = 0 or 1 or -1
    
    minCost = Inf;
    u_opt = u;
    for ax = -1:1
        for ay = -1:1
            u = [ax;ay];
            
            % predict 4 future states
            estS = si;
            o_pred = oi;
            cost = 0;
            for iter = 1:2
            %for iter = 1:4
                [estS,R]= KFControlEstimate(estS, o_pred, muE, muGamma, varE, varGamma, A, B, R, G, u);
                o_pred = B * estS + normrnd(0, 1, size(oi));   % Number of state variable * 1
                
                % observation:[x,y,vx,vy,ax,ay,distDestinationX,distDestinationY,distObsticalX,distObsticalY]
                % accumulate cost alone the look ahead states
                cost = cost +...
                    sqrt(o_pred(7)^2 + o_pred(8)^2) +... 
                    1/(sqrt(o_pred(9)^2 + o_pred(10)^2));
                
            end
            
            if cost < minCost
                u_opt = u;
            end
        end
    end
    

end