compression_factor=5;
time_window=1;
K_constant=400;

startpoint=7.121265126000000e+09;
endpoint=7.275022445000000e+09;

tic
% [traj,prob]=reconstruction(hpc,params,[	36000000,36500000],[],time_window,compression_factor,K_constant);

[traj,prob]=reconstruction(hpc,params,[	35300000,37100000],[],time_window,compression_factor,K_constant);

% [traj,prob]=reconstruction(hpc,params,[	35300000,37100000],[],time_window,compression_factor);
% [traj,prob]=reconstruction(hpc,params,[32000000,44000000],[],time_window,compression_factor);
% [traj,prob]=reconstruction(hpc,params,[6.825625126000000e+07,7.009346939000000e+07],[],time_window,compression_factor);

% [traj,prob]=reconstruction(hpc_PN_xy,params,[8.612980772000000e+09,9.151536559000000e+09],[],time_window,compression_factor,K_constant);


% [traj,prob]=reconstruction(hpc,params,[	startpoint,endpoint],[],time_window,compression_factor,K_constant);





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
