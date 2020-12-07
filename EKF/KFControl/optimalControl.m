function u_opt = optimalControl(si,oi,muE, muGamma, varE, varGamma, A, B, R, G, u, obsticalX, obsticalY, destinationX, destinationY)
    % delAx = 0 or 1 or -1     increase or decrease in acceleration
    % delAy = 0 or 1 or -1
    
    minCost = Inf;
    u_opt = u;
    for delAx = -1:1
        for delAy = -1:1
            u = [delAx;delAy];
            
            % predict 4 future states
            estS = si;
            o_pred = oi;
            cost = 0;
            for iter = 1:2
            %for iter = 1:4
                [estS,R]= KFControlEstimate(estS, o_pred, muE, muGamma, varE, varGamma, A, B, R, G, u);
                o_pred = B * estS + normrnd(0, 1, size(oi));   % Number of state variable * 1
                
                % observation:[x,y,vx,vy,ax,ay]
                % accumulate cost alone the look ahead states
                cost = cost +...
                    sqrt((o_pred(1) - destinationX)^2 + (o_pred(2) - destinationY)^2) +... 
                    1/(sqrt((o_pred(1) - obsticalX)^2 + (o_pred(2) - obsticalY)^2));
                
%                 disp(cost)
            end
            
            if cost < minCost
                u_opt = u;
                minCost = cost;
            end
        end
    end
    
    disp(minCost)
end