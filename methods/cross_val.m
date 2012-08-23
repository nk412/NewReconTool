p1=31323734;
p2=44830391;
folds=10;
compression_factor=15;
time_window=1;
velocity_K=100;

interv=(p2-p1)/folds;
init=p1;
for x=1:folds
	train1=p1;
	train2=init;
	train3=init+interv;
	train4=p2;
	fprintf('[%d,%d ; %d,%d]\n',train1,train2,train3,train4);
	init=init+interv;
	params=training(pos,hpc,[32,32],[train1,train2;train3,train4]);
	% // fprintf('[traj,prob]=reconstruction(hpc,params,[train2,train3],[],time_window,compression_factor,velocity_K);');
	[traj,prob]=reconstruction(hpc,params,[train2,train3],[],time_window,compression_factor,velocity_K);
	err=recon_error(pos,traj,params);
	% // fprintf('err=recon_error(pos,traj,params);');
	interval_one=err{1};
	% // fprintf('interval_one=err{1};');
	% // sum(interval_one(:,6));
	sumsquares=sum(interval_one(:,6));
	R2=model_R2(params,err);
	fprintf('Fold %d/%d - SS:%d\t\t\tR2 = %f\n',x,folds,sumsquares, R2);
	% // fprintf('sum(interval_one(:,6));');
	display_plots;
	% waitforbuttonpress;
	% fprintf('\n\n\n\n\n\n\n\n');
end



clear p1;
clear p2;
clear train1;
clear train2;
clear train3;
clear train4;
clear init;
clear compression_factor;
clear time_window;


