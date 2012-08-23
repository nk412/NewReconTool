function [ position_data ] = shift_origin( position_data )
%SHIFT_ORIGIN Summary of this function goes here
%   Detailed explanation goes here

minimum_pos_x=min(position_data(:,2));
minimum_pos_y=min(position_data(:,3));
for x=1:numel(position_data(:,1))
    position_data(x,2)=position_data(x,2)-minimum_pos_x;
    position_data(x,3)=position_data(x,3)-minimum_pos_y;
end
fprintf('New origin (0,0) set at (%d,%d).\nX offset: %d units \t\tY offset: %d units\n',minimum_pos_x,minimum_pos_y,minimum_pos_x,minimum_pos_y);

end

