function [ r2 ] = model_R2( params, model_output_info )
% [r2] =  model_R2(err);
%   Returns the R2, a measure of goodness of fit of reconstruction, by comparing it with a null model.
%	The null model in this case simply returns the most likely position of the animal, based on position
%	data, and is used to compared the performance of the Bayesian reconstruction. A value of 1 is ideal & means
%	the model is perfect with 0 error. A value of 0 means the model performs just as good/bad as the null
%	model, and negative values indicate that the model performs worse than the null model.
	if(nargin<2)
		error('Please input parameter model and post-recon error values');
	end
	if(iscell(model_output_info))
		model_output_info=model_output_info{1};
	end
	occupancy_grid=params{3};
	index=findnearest(max(max(occupancy_grid)),occupancy_grid);
	[best_x,best_y]=ind2sub(size(occupancy_grid),index(1));
	null_model=model_output_info(:,1:6);
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

