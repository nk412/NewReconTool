compression_factor=5;
time_window=1;
K_constant=400;
p1=31323734;
p2=44830391;
folds=10;

scoreslist=[];
for gridsize=2:32	
	gridsize
	[scores,meanR2]=do_cv( pos,hpc,p1,p2,folds,compression_factor,time_window,gridsize );
	avgSS_grid=mean(scores(:,1));
	avgSS_true=mean(scores(:,2));
	scoreslist=[scoreslist;gridsize, meanR2];
	fprintf('R2 : %f\n',meanR2);
end
clear gridsize;
clear score;


	

