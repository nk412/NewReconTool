p1=32000000;
p2=44000000;
folds=20;
compression_factor=1;
time_window=1;

interv=(p2-p1)/folds;
init=p1;
for x=1:folds
	train1=p1;
	train2=init;
	train3=init+interv;
	train4=p2;
	train3-train2
	init=init+interv;
	params=training(pos,hpc,[16,16],[train1,train2;train3,train4]);
	[traj,prob]=reconstruction(hpc,params,[train2,train3],[],time_window,compression_factor);
	err=recon_error(pos,traj,params);
	interval_one=err{1};
	sum(interval_one(:,6))
	display_plots;
	% waitforbuttonpress;
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


