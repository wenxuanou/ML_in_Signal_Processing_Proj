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
track = data(data.track_id==19,:);
plotTrack(track)

% comstruct expectation state matrix, numOfTimeStamp * 5
% each row is a expected state at each frame
% vx/vy in m/s, deltaT in s
StateExpectedMatrix = [track.x, track.y, track.vx, track.vy];   % [x, y, vx, vy]

% timelapse between frames
deltaT = 0.1;   % 100 ms, assume fixed
% constant noise variance, avoid zero kalman gain
theta_epsilon = 0.0001;
theta_gamma = 0.0001;

% initial state: [x, y, vx, vy, deltaTime]
S_0 = [track.x(1), track.y(1), track.vx(1), track.vy(1)];
% initial variance, same size as S_0
R_0 = theta_epsilon * eye(length(S_0),length(S_0));     % values are primative assumptions, need to elaborate later

[totalFrame,~] = size(track);       % number of frames
S = S_0;                            % initilize state vector
R = R_0;                            % initilize variance
outTrack = zeros(totalFrame,2);     % store actual track

for count = 1:totalFrame
     % prediction, row vector
    S_bar = StateExpectedMatrix(count,:);   % prediction is the expectation vector, ignore noise
    
    % observation matrix
    B = [1,0,deltaT,0;...
        0,1,0,deltaT;...
        0,0,1,0;...
        0,0,0,1];
    % observation, column vector
    O = B * S.';    % ignore noise, add later
    outTrack(count,:) = [O(1),O(2)];        % record observed track
    
    % kalman gain
    % R is a row vector here, need extra transpose
    K = R.' * B.' * inv(B*(R.')*B.' + theta_gamma * eye(size(B*(R.')*B.'))); 
    
    % update state and variance
    S = S_bar.' + K * (O - B * S_bar.');
    S = S.';                                % transpose back to row vector
    R = (eye(size(K*B)) - K*B) * R.';
    
end
figure(2)
plot(track.x,track.y)
hold on
plot(outTrack(:,1),outTrack(:,2))

% evaluate performance in MSE
err = immse(outTrack,[track.x,track.y]);
disp("MSE:")
disp(err)


