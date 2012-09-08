compression_factor=1;
time_window=1;
K_constant=100;

tic
% [traj,prob]=reconstruction(hpc,params,[	35300000,37100000],[],time_window,compression_factor,K_constant);
[traj,prob]=reconstruction(hpc,params,[	36000000,36500000],[],time_window,compression_factor,K_constant);

% [traj,prob]=reconstruction(hpc,params,[	35300000,37100000],[],time_window,compression_factor);
% [traj,prob]=reconstruction(hpc,params,[32000000,44000000],[],time_window,compression_factor);
% [traj,prob]=reconstruction(hpc,params,[6.825625126000000e+07,7.009346939000000e+07],[],time_window,compression_factor);

toc
err=recon_error(pos,traj,params);
interval_one=err{1};
sum(interval_one(:,6))
beep;

clear time_window;
clear compression_factor;
clear K_constant;
