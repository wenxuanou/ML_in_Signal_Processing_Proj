close all;
clear all;
clc;

%% get the vehicle track
% path to the dataset
dataName = "../INTERACTION-Dataset-DR-v1_1/recorded_trackfiles/DR_DEU_Merging_MT/vehicle_tracks_000.csv";
data = readtable(dataName);

% plot all vehicle track
% figure(1)
% plotTrack(data);

% select the first track
track1 = data(data.track_id==19,:);
track2 = data(data.track_id==5,:);
[totalFrame1,~] = size(track1);       % number of frames
[totalFrame2,~] = size(track2);
if(totalFrame1 > totalFrame2)
    track1 = track1(1:totalFrame2,:);
    totalFrame = totalFrame2;
else
    track2 = track2(1:totlaFrame1,:);
    totalFrame = totalFrame1;
end

% plotTrack(track)

% comstruct expectation state matrix, numOfTimeStamp * 5
% each row is a expected state at each frame
% vx/vy in m/s, deltaT in s
% [x1, y1, x2, y2, vx1, vy1, vx2, vy2]
StateExpectedMatrix = [track1.x, track1.y, track2.x, track2.y, track1.vx, track1.vy, track2.vx, track2.vy];   

% timelapse between frames
deltaT = 0.1;   % 100 ms, assume fixed
% constant noise variance, avoid zero kalman gain
theta_epsilon = 0.0001;
theta_gamma = 0.0001;

% initial state: [x1, y1, x2, y2, vx1, vy1, vx2, vy2]
S_0 = [track1.x(1), track1.y(1), track2.x(1), track2.y(1), track1.vx(1), track1.vy(1), track2.vx(1), track2.vy(1)];
% initial variance, same size as S_0
R_0 = theta_epsilon * eye(length(S_0),length(S_0));     % values are primative assumptions, need to elaborate later

S = S_0;                            % initilize state vector
R = R_0;                            % initilize variance
outTrack1 = zeros(totalFrame,2);     % store actual track
outTrack2 = zeros(totalFrame,2);
for count = 1:totalFrame
     % prediction, row vector
    S_bar = StateExpectedMatrix(count,:);   % prediction is the expectation vector, ignore noise
    
    % observation matrix
    B = [1,0,0,0,deltaT,0,0,0;...
        0,1,0,0,0,deltaT,0,0;...
        0,0,1,0,0,0,deltaT,0;...
        0,0,0,1,0,0,0,deltaT;...
        0,0,0,0,1,0,0,0;...
        0,0,0,0,0,1,0,0;...
        0,0,0,0,0,0,1,0;
        0,0,0,0,0,0,0,1];
    % observation, column vector
    O = B * S.';    % ignore noise, add later
    outTrack1(count,:) = [O(1),O(2)];        % record observed track
    outTrack2(count,:) = [O(3),O(4)];
    
    % kalman gain
    % R is a row vector here, need extra transpose
    K = R.' * B.' * inv(B*(R.')*B.' + theta_gamma * eye(size(B*(R.')*B.'))); 
    
    % update state and variance
    S = S_bar.' + K * (O - B * S_bar.');
    S = S.';                                % transpose back to row vector
    R = (eye(size(K*B)) - K*B) * R.';
    
end
figure(2)
plot(track1.x,track1.y)
hold on
plot(track2.x,track2.y)
plot(outTrack1(:,1),outTrack1(:,2))
plot(outTrack2(:,1),outTrack2(:,2))

% evaluate performance in MSE
err1 = immse(outTrack1,[track1.x,track1.y]);
err2 = immse(outTrack2,[track2.x,track2.y]);

disp("MSE:")
disp(err1)
disp(err2)

