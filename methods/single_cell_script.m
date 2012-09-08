compression_factor=1;
time_window=1;

startpoint=7.228994850000000e+09;
endpoint=7.328994850000000e+09;

% startpoint=7.240036786000000e+09;
% endpoint=7.356972839000000e+09;
tic

% [traj,prob]=reconstruction(hpc,params,[	36000000,36500000],[],time_window,compression_factor,K_constant);

% p1=31323734;
% p2=44830391;
%-------------------------------------------------------------------------------------------------------------
% [traj,prob]=reconstruction(hpc,params,[	p1,p2],[],time_window,compression_factor);
%------------------------------------------------------------------------------------------------------------lovejoy sequence


[traj,prob]=reconstruction(hpc,params,[35300000,37100000],time_window,compression_factor);
% [traj,prob]=reconstruction(hpc,params,[32000000,44000000],[],time_window,compression_factor);
% [traj,prob]=reconstruction(hpc,params,[6.825625126000000e+07,7.009346939000000e+07],[],time_window,compression_factor);

% [traj,prob]=reconstruction(hpc_PN_xy,params,[8.612980772000000e+09,9.151536559000000e+09],[],time_window,compression_factor,K_constant);

% ----------------------[[[]]][][][][][][][][][][][][][][[[[][]]]]
% [traj,prob]=reconstruction(hpc,params,[	startpoint,endpoint],time_window,compression_factor,1000000);




toc
err=recon_error(pos,traj,params);
interval_one=err{1};
sumsquares=sum(interval_one(:,6));
R2=model_R2(params,err);
fprintf('Model Error Details - SS:%d\t\t\tR2 = %f\n',sumsquares, R2);
beep;

clear startpoint;
clear endpoint;

clear time_window;
clear compression_factor;
clear K_constant;
