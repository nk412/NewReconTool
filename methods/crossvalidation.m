function [ scores ] = crossvalidation( pos,hpc,interval,folds,compression_factor,time_window, velocity_K )
%CROSSVALIDATION function [ scores ] = crossvalidation( pos,hpc,interval,folds,compression_factor,time_window, velocity_K )
%   Detailed explanation goes here
if(nargin<2)
    error('Please provide the position data and spikes cell array');
elseif(nargin<3)
    interval=[];folds=10;compression_factor=10;time_window=1;velocity_K=400;
elseif(nargin<4)
    folds=10;compression_factor=10;time_window=1;velocity_K=400;
elseif(nargin<5)
    compression_factor=10;time_window=1;velocity_K=400;
elseif(nargin<6)
    time_window=1;velocity_K=400;
elseif(nargin<7)
    velocity_K=400;
end
unitspersecond=1;


if(numel(interval)<2)
    interval=[min(pos(:,1)),max(pos(:,1))];
end

p1=interval(1);
p2=interval(2);
scores=[];

interv=(p2-p1)/folds;
init=p1;
for x=1:folds
	train2=init;
	train3=init+interv;
	%fprintf('[%d,%d ; %d,%d]\n',p1,train2,train3,p2);
	init=init+interv;
	params=training(pos,hpc,[32,32],[p1,train2;train3,p2]);
	[traj,prob]=reconstruction(hpc,params,[train2,train3],time_window,compression_factor, velocity_K);
	err=recon_error(pos,traj,params);
	interval_one=err{1};
	sumsquares=sum(interval_one(:,6));
	R2=model_R2(params,err);
    scores=[scores;train2,train3,R2];
	fprintf('Fold %d/%d - SS:%d\t\t\tR2 = %f\n',x,folds,sumsquares, R2);
	display_plots(err);
end



end

