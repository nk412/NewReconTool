params=training(pos,hpc,[9]);
time_window=1;
compression_factor=5;

bestscore=Inf;
bestk=1;

for k=50:1000:25000
	k
	[traj,prob]=reconstruction(hpc,params,[7.121265126000000e+09,7.275022445000000e+09],[],time_window,compression_factor);
	err=recon_error(pos,traj,params);
	interval_one=err{1};
	score=sum(interval_one(:,11))
	if(score<bestscore)
		bestscore=score;
		bestk=k;
	end
end
bestscore
bestk

