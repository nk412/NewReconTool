p1=31323734;
p2=44830391;
folds=10;
compression_factor=15;
time_window=1;
gridsize=9;
velocity_K=100;


[scores,meanR2]=do_cv( pos,hpc,p1,p2,folds,compression_factor,time_window,gridsize );
meanR2