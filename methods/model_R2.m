function [ r2 ] = model_R2( params, model_output_info )
% [r2] =  model_R2(err);
%   Detailed explanation goes here
	occupancy_grid=params{3};
	index=findnearest(max(max(occupancy_grid)),occupancy_grid);
	[best_x,best_y]=ind2sub(size(occupancy_grid),index(1));
	null_model=model_output_info{1}(:,1:6);
	null_model(:,4)=best_x;
	null_model(:,5)=best_y;
	sum_squares_null=0;
	sum_squares_model=sum(null_model(:,6));
	entries=size(null_model);
	entries=entries(1);
	for x=1:entries
		euclidian_dist= sqrt( ((null_model(x,2)-null_model(x,4))^2)  +  ((null_model(x,3)-null_model(x,5))^2));
		sum_squares_null=sum_squares_null + power(euclidian_dist,2);
	end
	r2=1-(sum_squares_model/sum_squares_null);
end

