p1=min(pos(:,1));
p2=max(pos(:,1));
interv=(p2-p1)/10;
interv=round(interv);
p1=p1+interv;
p2=p2-interv;
gridscores=[];

for gridcell=2:32
	scores=crossvalidation(hpc,pos,gridcell,[p1,p2],10,10,1, 1000000, 2400 );
	meanr2=mean(scores(:,3));
	gridscores=[gridscores;gridcell,meanr2];
end

