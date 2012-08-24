p1=31323734;
p2=44830391;
% p1=6.140036786000000e+09;
% p2=8.396972839000000e+09;
folds=10;
compression_factor=10;
time_window=1;
gridsize=16;


[scores,meanR2]=do_cv( pos,hpc,p1,p2,folds,compression_factor,time_window,gridsize );
meanR2

% tic
% params=training(pos,hpc,[10]);
% toc
