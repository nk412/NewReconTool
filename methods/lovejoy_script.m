
pos = shift_origin(pos);   % Shift origin
params = training (pos, hpc, 32);  % Train the entire set on a 32x32 bin resolution

[traj,prob]= reconstruction(hpc, params, [3.53e7, 3.63e7], 1, 2);  %interval [3.53 e7 to 3.63 e7], time_window=1, compression_factor=2;

reconstruction_error = recon_error( pos, traj, params);  % calculate the reconstruction error
r2 = model_R2( params, reconstruction_error)  % calculate the R2 value for the model

display_plots(reconstruction_error);  % display plot for X-coordinate





