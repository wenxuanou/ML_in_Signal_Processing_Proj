function u_opt = optimalControl2Inline(si,oi,muE, muGamma, varE, varGamma, A, B, R, G, u,...
    obstacleX, obstacleY, ObstaclecarX, ObstaclecarY, destinationX, destinationY, iteration)
    % search for optimal driving term
    % implemented by Owen, edited by Parth and Prasad


    ux = 1 * [0 0 0 0; 1 1 1 1; 0 0 0 0; -1 -1 -1 -1; 0 0 0 0; 1 1 -1 -1; 0 0 0 0; -1 -1 1 1; 0 0 0 0];
    uy =  1 * [0 0 0 0; 0 0 0 0; 1 1 1 1; 0 0 0 0; -1 -1 -1 -1; 0 0 0 0; 1 1 -1 -1; 0 0 0 0; -1 -1 1 1];
    
    % setting cost function parameters (current setting the one we use to get the best path)
    
    roadBoundary1 = 10; roadBoundary2 = 30;     % left and right bound of the road
%     roadMid = (roadBoundary2 - roadBoundary1) / 2;
    
    muGaussianCost = 0;                         % mean of gaussian cost
    penalty = 3; sigmaGaussianCost = 5;         % max and std of obstacle gaussian cost
    carPenalty = 3; carsigmaCost = 6.5;           % max and std of obstacle car gaussian cost
    roadPenalty = 10; roadsigmaCost = 5;        % max and std of road boundary gaussian cost
%     roadMidPenalty = 7; roadMidSigmaCost = 5;   % max and std of middld of road gaussian cost
   
    minCost = Inf;
    u_opt = u;
    for i = 1:size(ux, 1)
        for scale = [0.25, 0.5, 1, 2]
            for j = 1:size(ux,2)
                u = scale * [ux(i,j);uy(i,j)];

                estS = si;
                o_pred = oi;
                [estS,R]= KFControlEstimateInline(estS, o_pred, muE, muGamma, varE, varGamma, A, B, R, G, u);
                o_pred = B * estS;% + normrnd(0, 1, size(oi));   % Number of state variable * 1

                if iteration + j - 1 > 100      % number of time frame
                    carPositionX = ObstaclecarX(end-1);
                    carPositionY = ObstaclecarY;
                else
                    carPositionX = ObstaclecarX(iteration + j - 1);
                    carPositionY = ObstaclecarY(iteration + j - 1);
                end
                
                cost = sqrt((o_pred(1) - destinationX)^2 + (o_pred(2) - destinationY)^2)+...
                    roadPenalty*(normpdf(o_pred(2) - roadBoundary1, muGaussianCost, roadsigmaCost) / normpdf(0, muGaussianCost, roadsigmaCost)) + ...
                    roadPenalty*(normpdf(o_pred(2) - roadBoundary2, muGaussianCost, roadsigmaCost) / normpdf(0, muGaussianCost, roadsigmaCost)) + ...
                    ((carPenalty*normpdf(o_pred(1) - carPositionX,muGaussianCost, carsigmaCost) / normpdf(0, muGaussianCost, carsigmaCost)) * ...
                    (carPenalty*normpdf(o_pred(2) - carPositionY,muGaussianCost, carsigmaCost) / normpdf(0, muGaussianCost, carsigmaCost)));
                    
%                     roadMidPenalty*(normpdf(o_pred(2) - roadMid, muGaussianCost, roadMidSigmaCost) / normpdf(0, muGaussianCost, roadMidSigmaCost)) +...

                for obstacleI = 1:size(obstacleX, 2)
                    obstacleXi = obstacleX(obstacleI); obstacleYi = obstacleY(obstacleI);
                    cost = cost + ...
                    ((penalty*normpdf(o_pred(1) - obstacleXi, muGaussianCost, sigmaGaussianCost) / normpdf(0, muGaussianCost, sigmaGaussianCost)) * ...
                    (penalty*normpdf(o_pred(2) - obstacleYi, muGaussianCost, sigmaGaussianCost) / normpdf(0, muGaussianCost, sigmaGaussianCost)));
                end

                if cost < minCost
                    u_opt = u;
                    minCost = cost;
                end
                disp(cost)
                disp(u)
            end
        end
    end
    disp('minCost:')
    disp(minCost)
    disp(u_opt)
end