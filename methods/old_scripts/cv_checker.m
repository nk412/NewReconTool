compression_factor=30;
time_window=1;
K_constant=400;

startpoint=7.121265126000000e+09;
endpoint=7.275022445000000e+09;



lims=[31323734,	32674398;32674399,	34025064;
	  34025065,	35375730;35375731,	36726395;
	  36726396,	38077061;38077062,	39427727;
	  39427728,	40778392;40778393,	42129058;
	  42129059,	43479724;43479725,	44830391];



% lims=[31323734,33323796;33323797,44830391];
% lims=[31323734,44830391];1
params=training(pos,hpc,[8,8]);
params2=training(pos,hpc,[8,8],lims);

clear lims;




tic
[traj,prob]=reconstruction(hpc,params,[	35300000,37100000],[],time_window,compression_factor,K_constant);
toc
err=recon_error(pos,traj,params);
interval_one=err{1};
sum(interval_one(:,6))
beep;

tic
[traj,prob]=reconstruction(hpc,params2,[	35300000,37100000],[],time_window,compression_factor,K_constant);
toc
err=recon_error(pos,traj,params);
interval_one=err{1};
sum(interval_one(:,6))
beep;




clear startpoint;
clear endpoint;

clear time_window;
clear compression_factor;
clear K_constant;
