compression_factor=30;
time_window=1;
K_constant=400;
p1=31323734;
p2=44830391;

% % p1=6.140036786000000e+09;
% % p2=8.396972839000000e+09;

% p1=6.840036786000000e+09;
% p2=7.896972839000000e+09;


folds=10;

scoreslist=[];


for gridsize=2:128	
	gridsize
	params=training(pos,hpc,gridsize);
	[traj,prob]=reconstruction(hpc,params,[	p1,p2],[],time_window,compression_factor);
	err=recon_error(pos,traj,params);
	interval_one=err{1};
	% sumsquares=sum(interval_one(:,6));
	R2=model_R2(params,err);
	avgSS_grid=mean(interval_one(:,6));
	avgSS_true=mean(interval_one(:,11));
	scoreslist=[scoreslist;gridsize, R2,avgSS_grid,avgSS_true];
	fprintf('R2 : %f\n',R2);
end

% for gridsize=2:32	
% 	gridsize
% 	[scores,meanR2]=do_cv( pos,hpc,p1,p2,folds,compression_factor,time_window,gridsize );
% 	avgSS_grid=mean(scores(:,1));
% 	avgSS_true=mean(scores(:,2));
% 	scoreslist=[scoreslist;gridsize, meanR2,avgSS_grid,avgSS_true];
% 	fprintf('R2 : %f\n',meanR2);
% end


clear gridsize;
clear score;


	

