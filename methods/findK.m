params=training(pos,hpc,[32,32]);
time_window=1;
compression_factor=20;

bestscore=Inf;
bestk=1;

for k=50:50:900
	k
	[traj,prob]=reconstruction(hpc,params,[32000000,44000000],[],time_window,compression_factor,k);
	err=recon_error(pos,traj,params);
	interval_one=err{1};
	score=sum(interval_one(:,6))
	if(score<bestscore)
		bestscore=score;
		bestk=k;
	end
end
bestscore
bestk

