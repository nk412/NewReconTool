params=training(pos,hpc,16);

display_firingrate(params,4);
display_neuronselectivity(params);
display_occupancy(params);


intervals=[3.53e3, 3.63e3];

[traj,prob] = reconstruction( hpc, params, intervals);

r_err=recon_error(pos,traj,params);

model_R2(params, r_err);

display_plots(r_err);

display_trajectory(params, prob, r_err);

crossvalidation(hpc,pos,16);
