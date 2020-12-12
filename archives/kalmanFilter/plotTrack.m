function plotTrack(data)
% plot vehicle track
vehicleNum = max(data.track_id);
figure(1)
hold on

for count = 1:vehicleNum
    vehicle = data(data.track_id==count,:);
    v_tan = sqrt(vehicle.vx.^2 + vehicle.vy.^2);

    surf([vehicle.x(:) vehicle.x(:)], [vehicle.y(:) vehicle.y(:)], [v_tan(:) v_tan(:)], ...  % Reshape and replicate data
         'FaceColor', 'none', ...    % Don't bother filling faces with color
         'EdgeColor', 'interp', ...  % Use interpolated color for edges
         'LineWidth', 2);  
    view(2);   % Default 2-D view
    colorbar;
end
end