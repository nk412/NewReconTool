function [ scores ] = crossvalidation( pos,spikes,interval,folds,gridsize,compression_factor,time_window, velocity_K )
%CROSSVALIDATION function [ scores ] = crossvalidation( pos,hpc,interval,folds,gridsize,compression_factor,time_window, velocity_K )
%	This function carries out a k-fold cross validation over the provided data set
%	and intervals. It returns a matrix that contains the results for every fold.
%
%   Inputs
% position_data - Positional data in the form of a Tx3 matrix, where T is the
%                 number of timesteps. The three columns correspond to timestep,
%                 X coordinate, and the Y coordinate at the timestep respectively.
% spikes        - A cell array containing N vectors, where N is the number of
%                 neurons. Each vector contains timestamps at which the neuron
%                 fired.
% 	Optional paramaters:
% interval  	   	- This is a vector with two elements, which specifies the start point
% 					  and the end point for the interval to cross-valdiate. By default,
% 					  cross validation is carried out over the entire set.
%  folds 			- The number of folds for the cross validation. Default = 10
% compression_factor- The compression_factor allows representations of neural sequences
%                     occurring faster than animal behaviour. By default, this is set
%                     at 1X. (Algorithm Dependent) 
% velocity_K        - A constant that denotes how much of the velocity information is used
%                     in the two step correction step. Reconstruction accuracy can be
%                     tweaked using this parameter, as it is animal dependent. Lies 
%                     anywhere between 50 to 5000. Default : 400
%
%
%  OUTPUT
%  scores			- This is a matrix of size folds x 3; one row for each fold. The first
% 					  and the second column represent the start and end points of the
% 					  corresponding fold, while the third column represents the goodness
% 					  of fit value calculated over that fold by model_R2.

if(nargin<2)
    error('Please provide the position data and spikes cell array');
elseif(nargin<3)
    interval=[];folds=10;gridsize=16;compression_factor=10;time_window=1;velocity_K=400;
elseif(nargin<4)
    folds=10;gridsize=16;compression_factor=10;time_window=1;velocity_K=400;
elseif(nargin<5)
    gridsize=16;compression_factor=10;time_window=1;velocity_K=400;
elseif(nargin<6)
    compression_factor=10;time_window=1;velocity_K=400;
elseif(nargin<7)
    time_window=1;velocity_K=400;
elseif(nargin<8)
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
	params=training(pos,spikes,gridsize,[p1,train2;train3,p2]);
	[traj,prob]=reconstruction(spikes,params,[train2,train3],time_window,compression_factor, velocity_K);
	err=recon_error(pos,traj,params);
	interval_one=err{1};
	sumsquares=sum(interval_one(:,6));
	R2=model_R2(params,err);
    scores=[scores;train2,train3,R2];
	fprintf('Fold %d/%d - SS:%d\t\t\tR2 = %f\n',x,folds,sumsquares, R2);
	display_plots(err);
end



end

