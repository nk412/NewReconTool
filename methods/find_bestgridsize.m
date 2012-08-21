compression_factor=5;
time_window=1;
K_constant=400;

scoreslist=[];
for gridsize=2:4	
	gridsize
	params=training(pos,hpc,[gridsize,gridsize]);
	tic
	[traj,prob]=reconstruction(hpc,params,[	35300000,37100000],[],time_window,compression_factor,K_constant);
	secs=toc;
	err=recon_error(pos,traj,params);
	interval_one=err{1};
	score=sum(interval_one(:,11));
	scoreslist=[scoreslist;gridsize,score,secs];
end
clear gridsize;

	

